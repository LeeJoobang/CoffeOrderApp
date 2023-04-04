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
            // 만약 처리되지 않으면 .decodingerror로 분류함.
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } else {
                completion(.failure(.decodingError))
            }
        }
    }
}

