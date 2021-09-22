//
//  ProductTableViewController.swift
//  Lab_A1_A2_iOS_ Gurpreet_c0823239
//
//  Created by Mac on 2021-09-21.
//

import UIKit

class ProductTableViewController: UITableViewController {

    var arrProviders = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrProviders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProviderProduct", for: indexPath)
        cell.textLabel?.text = arrProviders[indexPath.row]
        
        return cell
    }

}
