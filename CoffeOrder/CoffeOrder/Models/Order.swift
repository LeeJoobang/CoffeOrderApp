//
//  Order.swift
//  CoffeOrder
//
//  Created by Joobang on 2023/04/04.
//

import Foundation

enum CoffeeSize: String, Codable, CaseIterable {
    case samll
    case medium
    case large
}

enum CoffeeType: String, Codable, CaseIterable {
    case espresso
    case cappuccino
    case latte
}

struct Order: Codable{
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
}

extension Order {
    static var all: Resource<[Order]> = {
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("URL is incorrect!")
        }
        return Resource<[Order]>(url: url)
    }()
    
    static func create(vm: AddCoffeeOrderViewModel) -> Resource<Order?>{
        let order = Order(vm)
        
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("URL is incorrect!")
        }
        
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("Data encoding error!")
        }
        
        var resource = Resource<Order?>(url: url)
        resource.httpMethod = HttpMethod.post
        resource.body = data
        
        return resource
    }
}

extension Order {
    init?(_ vm: AddCoffeeOrderViewModel){
        guard let name = vm.name,
              let email = vm.email,
              let selectedSize = CoffeeSize(rawValue: vm.selectedSize!.lowercased()),
              let selectedType = CoffeeType(rawValue: vm.selectedType!.lowercased()) else {
            return nil
        }
        
        self.name = name
        self.email = email
        self.size = selectedSize
        self.type = selectedType
        
        
    }
}


