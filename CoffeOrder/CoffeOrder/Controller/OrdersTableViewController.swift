//
//  OrdersTableViewController.swift
//  CoffeOrder
//
//  Created by Joobang on 2023/03/19.
//

import UIKit

class OrdersTableViewController: UITableViewController, AddCoffeOrderDelegate{
    
    var orderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populataOrder()
    }
    
    //delegate 처리
    func addCoffeeOrderViewControllerDidClose(controller: UIViewController) {
        controller.dismiss(animated: true)
    }
    func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController) {
        controller.dismiss(animated: true)
        
        let orderVM = OrderViewModel(order: order)
        self.orderListViewModel.orderViewModel.append(orderVM)
        self.tableView.insertRows(at: [IndexPath.init(row: self.orderListViewModel.orderViewModel.count - 1, section: 0)], with: .automatic)
    }
    
    
    private func populataOrder(){
//        guard let coffeeOrdersURL =  URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
//            fatalError("URL was incorrect")
//        }
        
        // Resource의 [Order]의 배열은 여러개의 주문을 담을 수 있기에 배열로 처리함.
//        let resource = Resource<[Order]>(url: coffeeOrdersURL)
        // resouce를 담을 필요가 없어졌다.
        
        WebService().load(resource: Order.all) {[weak self] result in
            switch result{
            case .success(let orders):
                self?.orderListViewModel.orderViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
            case .failure(let errors):
                print(errors)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController, let addCoffeeOrderVC = navC.viewControllers.first as? AddOrderViewController else {
            fatalError("Error page")
        }
        addCoffeeOrderVC.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListViewModel.orderViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = self.orderListViewModel.orderViewModel(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        cell.textLabel?.text = vm.type
        cell.detailTextLabel?.text = vm.size
        
        return cell
    }
    
    
}
