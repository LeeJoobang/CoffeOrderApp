//
//  OrderViewModel.swift
//  CoffeOrder
//
//  Created by Joobang on 2023/04/04.
//

import Foundation

class OrderListViewModel {
    var orderViewModel: [OrderViewModel]
    
    init(){
        self.orderViewModel = [OrderViewModel]()
    }
}

extension OrderListViewModel{
    func orderViewModel(at index: Int) -> OrderViewModel {
        return self.orderViewModel[index]
    }
}

struct OrderViewModel {
    let order: Order
     
}

extension OrderViewModel {
    var name: String{
        return self.order.name
    }
    
    var email: String{
        return self.order.email
    }
    
    var type: String{
        return self.order.type.rawValue.capitalized
    }
    // 원시값을 가져 온 후 capitalized를 사용해 view에 표시될 때 대문자로 표시함.
    
    var size: String{
        return self.order.size.rawValue.capitalized
    }
}

