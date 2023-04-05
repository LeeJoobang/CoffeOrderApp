//
//  AddOrderViewController.swift
//  CoffeOrder
//
//  Created by Joobang on 2023/03/19.
//

import Foundation
import UIKit

class AddOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    private var vm = AddCoffeeOrderViewModel()
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    private var coffeeSizesSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        setupUI()
    }
    
    func setupUI(){
        self.coffeeSizesSegmentedControl = UISegmentedControl(items: self.vm.sizes)
        self.coffeeSizesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.coffeeSizesSegmentedControl)
        self.coffeeSizesSegmentedControl.topAnchor.constraint(equalTo: self.tableview.bottomAnchor, constant: 20).isActive = true
        self.coffeeSizesSegmentedControl.centerXAnchor.constraint(equalTo: self.tableview.centerXAnchor).isActive  = true
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    // 하나만 선택할 수 있도록 함.
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddNewTableViewCell", for: indexPath)
        cell.textLabel?.text = self.vm.types[indexPath.row]
        return cell
        
    }
    
    
    @IBAction func saveButtonClicked(){
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        
        let selectedSize = self.coffeeSizesSegmentedControl.titleForSegment(at: self.coffeeSizesSegmentedControl.selectedSegmentIndex)
        
        guard let indexPath = self.tableview.indexPathForSelectedRow else {
            fatalError("Error in selecting coffee!")
        }
        
        self.vm.name = name
        self.vm.email = email
        
        self.vm.selectedSize = selectedSize
        self.vm.selectedType = self.vm.types[indexPath.row]
        
        WebService().load(resource: Order.create(vm: self.vm)) { result in
            switch result{
            case .success(let order):
                print(order)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
