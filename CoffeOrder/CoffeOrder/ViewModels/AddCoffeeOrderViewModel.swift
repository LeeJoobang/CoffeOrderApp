//
//  AddCoffeeViewModel.swift
//  CoffeOrder
//
//  Created by Joobang on 2023/04/04.
//

import Foundation

struct AddCoffeeOrderViewModel{
    
    var name: String?
    var email: String?
    
    var types: [String] {
        return CoffeeType.allCases.map{ $0.rawValue.capitalized }
    }
    
    var sizes: [String] {
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
    }
    
}
