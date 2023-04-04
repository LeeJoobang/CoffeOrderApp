//
//  Order.swift
//  CoffeOrder
//
//  Created by Joobang on 2023/04/04.
//

import Foundation

enum CoffeeSize: String, Codable {
    case samll
    case medium
    case large
}

enum Coffeetype: String, Codable {
    case espresso
    case americano
    case latte
    case tea
} 

struct Order: Codable{
    let name: String
    let email: String
    let type: Coffeetype
    let size: CoffeeSize
}


