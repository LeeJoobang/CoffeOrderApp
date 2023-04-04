//
//  WebService.swift
//  CoffeOrder
//
//  Created by Joobang on 2023/04/04.
//

import Foundation

enum NetworkError: Error{
    case decodingError
    case domainError
    case urlError
}

struct Resource<T: Codable>{
    let url: URL
}

class WebService{
    // .resume을 해주지 않아 오류 발생
    // .해당 서버에 CoffeeType .카푸치노를 누군가 post했음. 해당 유형의 값이 나에게 없어 decoding오류 발생
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void){
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            // data check
            // data, error가 nil이면 networkerror -> .domainerror
            guard let data = data, error == nil else {
                completion(.failure(.domainError))
                return
            }
            
            // .data유무를 확인하였으니, data를 제네릭으로 디코딩 후 result에 담는다.
            // 처리된 result는 main thread에서 처리해 ui에 반영될 수 있도록 한다.
            // 만약 처리되지 않으면 .decodingerror로 분류함
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

