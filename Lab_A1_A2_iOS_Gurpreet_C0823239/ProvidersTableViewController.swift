//
//  ProvidersTableViewController.swift
//  Lab_A1_A2_iOS_ Gurpreet_c0823239
//
//  Created by Mac on 2021-09-21.
//

import UIKit
import CoreData

class ProvidersTableViewController: UITableViewController {

        var arrProducts = [Product]()
        var arrProviders = [Provider]()
        var isProduct = true
        var isRedirected = false
        var selectedProduct: Product?
        var productIndex = 0
        var providerIndex = 0
        var isSave = false
        @IBOutlet weak var addProduct: UIBarButtonItem!
        var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let searchBar = UISearchController(searchResultsController: nil)
        
        // MARK: - Life cycle method view did load
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationItem.rightBarButtonItem = self.editButtonItem
            title = "Products"
            showSearchBar()
            handleLoadProducts()
            handleLoadProviders()
            if(arrProducts.count == 0){
                handleSetData()
            }
            tableView.reloadData()

        }
        
        // MARK: - Life cycle method view did apppear
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            tableView.reloadData()
        }
        
        // MARK: - Life cycle method view will apppear
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tableView.reloadData()
        }
    
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if(isProduct){
                productIndex = indexPath.row
                performSegue(withIdentifier: "toProduct", sender: self)
            } else {
                providerIndex = indexPath.row
                performSegue(withIdentifier: "toHome", sender: self)
            }
        }
        
        func handleSetData(){
                let product1 = Product(context: context)
                product1.id = 1
                product1.name = "Newway"
                product1.price = 20
                product1.provider = "Newway"
                product1.details = "Product of newway will be given to all of no cost thats free."
                
                let product2 = Product(context: context)
                product2.id = 2
                product2.name = "Rig"
                product2.price = 25
                product2.provider = "Rig"
                product2.details = "Product of Rig will be given to all of no cost thats free."
                
                let product3 = Product(context: context)
                product3.id = 3
                product3.name = "Amazon"
                product3.price = 15
                product3.provider = "Amazon"
                product3.details = "One of the basic pieces of furniture, a chair is a type of seat."
                
                let product4 = Product(context: context)
                product4.id = 4
                product4.name = "Wardrobe"
                product4.price = 50
                product4.provider = "Reliance"
                product4.details = "a large, tall cupboard or recess in which clothes may be hung or stored."
                
                let product5 = Product(context: context)
                product5.id = 5
                product5.name = "Pier-glass"
                product5.price = 25
                product5.provider = "Fressco"
                product5.details = "a large mirror, used originally to fill wall space between windows."
                
                let product6 = Product(context: context)
                product6.id = 6
                product6.name = "Sofa"
                product6.price = 30
                product6.provider = "Markitplace"
                product6.details = "a long upholstered seat with a back and arms, for two or more people."
                
                let product7 = Product(context: context)
                product7.id = 7
                product7.name = "Desk"
                product7.price = 20
                product7.provider = "Walmart"
                product7.details = "a piece of furniture with a flat or sloping surface and typically with drawers, at which one can read, write, or do other work."
                
                let product8 = Product(context: context)
                product8.id = 8
                product8.name = "Phone"
                product8.price = 25
                product8.provider = "Fido"
                product8.details = "a large, comfortable chair with side supports for a person's arms."
                
                
                let product9 = Product(context: context)
                product9.id = 9
                product9.name = "Matress"
                product9.price = 50
                product9.provider = "Sleep"
                product9.details = "a piece of furniture for sleep or rest, typically a framework with a mattress."
                
                let product10 = Product(context: context)
                product10.id = 10
                product10.name = "Coffe table"
                product10.price = 20
                product10.provider = "TimHoten"
                product10.details = "A coffee table is a low table designed to be placed in a sitting area for convenient support of beverages, remote controls, magazines, books, decorative objects, and other small items."
                
                let product11 = Product(context: context)
                product11.id = 11
                product11.name = "Stool"
                product11.price = 10
                product11.provider = "Purolator"
                product11.details = "a seat without a back or arms, typically resting on three or four legs or on a single pedestal."
                
                arrProducts.append(product1)
                arrProducts.append(product2)
                arrProducts.append(product3)
                arrProducts.append(product4)
                arrProducts.append(product5)
                arrProducts.append(product6)
                arrProducts.append(product7)
                arrProducts.append(product8)
                arrProducts.append(product9)
                arrProducts.append(product10)
                arrProducts.append(product11)
            var isProviderExist = false
            for product in arrProducts{
                for provider in arrProviders{
                    if(product.provider == provider.name){
                        isProviderExist = true
                        product.providers = provider
                        break
                    } else{
                        isProviderExist = false
                    }
                }
                if(!isProviderExist){
                    let newProvider = Provider(context: context)
                    newProvider.name = product.provider
                    arrProviders.append(newProvider)
                    product.providers = newProvider
                }
            }

        }
        
        // MARK: - Table view data source

        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return isProduct ? arrProducts.count : arrProviders.count
        }
        
        // method to display the value inside the cell
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            if(isProduct){
                cell.textLabel?.text = arrProducts[indexPath.row].name
                cell.detailTextLabel?.text = arrProducts[indexPath.row].provider
                cell.imageView?.image = nil
            } else {
                cell.textLabel?.text = arrProviders[indexPath.row].name
                cell.detailTextLabel?.text = String(arrProviders[indexPath.row].products?.count ?? 0)
                cell.imageView?.image = UIImage(systemName: "folder")
            }
            
            return cell
        }

        // Override to support editing the table view.
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                if(isProduct){
                    
                    let delProduct = arrProducts[indexPath.row]
                    var count = 0
                    
                    for product in arrProducts{
                        if(product.provider == delProduct.provider){
                            count += 1
                        }
                    }
                    
                    if(count == 1){
                        for provider in arrProviders{
                            if(provider.name == delProduct.provider){
                                deleteProvider(provider: provider)
                                saveProducts()
                                handleLoadProviders()
                            }
                        }
                    }
                    
                    // deleting the selected product
                    deleteProduct(product: arrProducts[indexPath.row])
                    saveProducts()
                    arrProducts.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                } else {
                    let delProvider = arrProviders[indexPath.row]
                    for product in arrProducts{
                        if(product.provider == delProvider.name){
                            deleteProduct(product: product)
                            saveProducts()
                            handleLoadProducts()
                        }
                    }
                    deleteProvider(provider: arrProviders[indexPath.row])
                    saveProducts()
                    arrProviders.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
 
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if(isProduct){
                let pvc = segue.destination as! ProductViewController
                pvc.productList = self.arrProducts
                pvc.providerList = self.arrProviders
                pvc.delegate = self
                if let _ = sender as? UIBarButtonItem {
                    pvc.selectedProduct = Product(context: context)
                }
                else {
                    pvc.productIndex = productIndex
                    if(!isRedirected){
                        pvc.selectedProduct = arrProducts[0]
                        isRedirected = true
                    } else {
                        pvc.selectedProduct = arrProducts[productIndex]
                    }
                     
                }
            } else {
                let ptvc = segue.destination as? ProductTableViewController

                let selectedProvider = arrProviders[providerIndex]

                for product in arrProducts{
                    if(product.provider == selectedProvider.name){
                        ptvc?.arrProviders.append(product.name!)
                    }
                }
            }
        }
        @IBAction func unwindToPPTVC(_ unwindSegue: UIStoryboardSegue) {
            saveProducts()
            tableView.reloadData()
        }
        
        // method to load the products
        func handleLoadProducts(predicate: NSPredicate? = nil){
            let request: NSFetchRequest<Product> = Product.fetchRequest()
            
            if let requestedPredicate = predicate{
                request.predicate = requestedPredicate
            }
        
            do{
                let tempList = try context.fetch(request)
                arrProducts = [Product]()
                for temp in tempList{
                    if(temp.id != 0){
                        arrProducts.append(temp)
                    }
                }
            } catch{
                print("erro while loading products: \(error.localizedDescription)")
            }
            tableView.reloadData()
        }
        
        // method to load the products
        func handleLoadProviders(predicate: NSPredicate? = nil){
            let request: NSFetchRequest<Provider> = Provider.fetchRequest()
            
            if let requestedPredicate = predicate{
                request.predicate = requestedPredicate
            }
        
            do{
                let tempList = try context.fetch(request)
                arrProviders = [Provider]()
                for temp in tempList{
                    if(temp.products?.count != 0){
                        arrProviders.append(temp)
                    }
                }
            } catch{
                print("error while loading providers: \(error.localizedDescription)")
            }
            tableView.reloadData()
        }
        func saveProducts(){
            do{
                try context.save()
            } catch{
                print("error: \(error.localizedDescription)")
            }
        }
        
        func deleteProduct(product: Product){
            context.delete(product)
        }
        

        func deleteProvider(provider: Provider){
            context.delete(provider)
        }
        
        func updateProduct(name: String, id: Int16, provider: String, price: Double, details: String, providers: Provider) {
            let newProduct = Product(context: context)
            newProduct.name = name
            newProduct.id = id
            newProduct.provider = provider
            newProduct.price = price
            newProduct.details = details
            newProduct.providers = providers
            
            saveProducts()
            arrProducts.append(newProduct)
            
            var tempProdList: [Product] = []
            for product in arrProducts{
                if(product.id != 0){
                    tempProdList.append(product)
                }
            }
            arrProducts = tempProdList
            handleLoadProviders()
            tableView.reloadData()
        }
        
        func showSearchBar() {
            searchBar.searchBar.delegate = self
            searchBar.obscuresBackgroundDuringPresentation = false
            searchBar.searchBar.placeholder = "Search"
            navigationItem.searchController = searchBar
            definesPresentationContext = true
            searchBar.searchBar.searchTextField.textColor = .black
        }
        
        @IBAction func showClick(_ sender: UIBarButtonItem) {
            if(isProduct){
                isProduct = false
                title = "Providers"
                sender.title = "Show Products"
                addProduct.isEnabled = false
                tableView.reloadData()
            } else {
                isProduct = true
                title = "Products"
                sender.title = "Show Providers"
                addProduct.isEnabled = true
                tableView.reloadData()
            }
        }
        
        
    }

    extension ProvidersTableViewController: UISearchBarDelegate{
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            // add predicate
            let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
            if(isProduct){
                handleLoadProducts(predicate: predicate)
            } else {
                handleLoadProviders(predicate: predicate)
            }
        }
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            
            if(isProduct){
                handleLoadProducts()
            } else {
                handleLoadProviders()
            }
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchBar.text?.count == 0 {
                if(isProduct){
                    handleLoadProducts()
                } else {
                    handleLoadProviders()
                }
                
                DispatchQueue.main.async {
                    searchBar.resignFirstResponder()
                }
            }
        }
    }
