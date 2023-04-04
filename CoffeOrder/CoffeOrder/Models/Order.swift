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


