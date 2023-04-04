//
//  OrdersTableViewController.swift
//  CoffeOrder
//
//  Created by Joobang on 2023/03/19.
//

import UIKit

class OrdersTableViewController: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populataOrder()
        
    }
    
    private func populataOrder(){
        guard let coffeeOrdersURL =  URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("URL was incorrect")
        }
        
        // Resource의 [Order]의 배열은 여러개의 주문을 담을 수 있기에 배열로 처리함.
        let resource = Resource<[Order]>(url: coffeeOrdersURL)
        let webService = WebService()
        webService.load(resource: resource) { result in
            switch result{
            case .success(let orders):
                print(orders)
            case .failure(let errors):
                print(errors)
            }
        }
    }
    
}
