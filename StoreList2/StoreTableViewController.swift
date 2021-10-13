//
//  ViewController.swift
//  StoreList2
//
//  Created by Andjela Rakic on 10/12/21.
//

import UIKit

class StoreTableViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var stores = [Store](){
        didSet {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        fetchStoreData()
    }
    
    func fetchStoreData() {
        guard let url = URL(string: "http://sandbox.bottlerocketapps.com/BR_Android_CodingExam_2015_Server/stores.json") else {return}
        
        let storeManager = StoreManager()
        
        storeManager.fetchData(from: url) { stores in
            self.stores = stores
            
        }
    }
    
   
    
   
    
}
extension StoreTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoreTableViewCell.identifier, for: indexPath)as? StoreTableViewCell else {
            return UITableViewCell()
            
        }
        let store = stores[indexPath.row]
        cell.titleLabel.text = store.name
        return cell
        
    }
    
}
