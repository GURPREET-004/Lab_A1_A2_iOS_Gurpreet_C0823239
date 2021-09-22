//
//  ProductViewController.swift
//  Lab_A1_A2_iOS_ Gurpreet_c0823239
//
//  Created by Mac on 2021-09-21.
//

import UIKit
import CoreData

class ProductViewController: UIViewController {
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var txtProvider: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    var productList = [Product]()
    var providerList = [Provider]()
    var selectedProduct : Product?
    var productIndex = 0
    var existingProvider = ""
    weak var delegate : ProvidersTableViewController?
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Life cycle method view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.text = selectedProduct?.name
        txtID.text = String(selectedProduct?.id ?? 0)
        txtProvider.text = selectedProduct?.provider
        txtPrice.text = String(selectedProduct?.price ?? 0.0)
        txtDescription.text = selectedProduct?.details
        
        existingProvider = txtProvider.text ?? ""
        
        if(txtID.text == String(0)){
            txtID.text = ""
        }
        if(txtPrice.text == String(0.0)){
            txtPrice.text = ""
        }
        
        if(txtName.text != ""){
            txtName.isEnabled = false
            txtID.isEnabled = false
        }
    }
    
    @IBAction func clickSave(_ sender: UIButton) {
        if shouldPerformSegue(withIdentifier: "toThePPTVC", sender: self){
           if(!txtName.isEnabled){
                self.navigationController?.popViewController(animated: true)
            } else {
                performSegue(withIdentifier: "toThePPTVC", sender: self)
            }
        }
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let pptvc = segue.destination as! ProvidersTableViewController
        pptvc.arrProducts = self.productList
        pptvc.arrProviders = self.providerList
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return validateData()
    }
    
    func validateData() -> Bool{
        if(txtName.text == "" || txtID.text == "" || txtProvider.text == "" || txtPrice.text == "" || txtDescription.text == ""){
            return false
        } else {
            if(!txtName.isEnabled){
                var providerCount = 0
                var isProviderExist = false
                for product in productList{
                    
                    if(existingProvider == product.provider){
                        providerCount += 1
                    }
                    
                    if(product.name == txtName.text!){
                        delegate?.deleteProduct(product: product)
                        delegate?.saveProducts()
                        productList.remove(at: productIndex)
                        
                        var newProvider = Provider(context: context)
                        for provider in providerList{
                            if(provider.name == txtProvider.text!){
                                newProvider = provider
                                isProviderExist = true
                            }
                        }
                        
                        if(!isProviderExist){
                            newProvider.name = txtProvider.text
                            self.providerList.append(newProvider)
                        }
                        
                        delegate?.updateProduct(name: txtName.text!, id: Int16(txtID.text!)!, provider: txtProvider.text!, price: Double(txtPrice.text!)!, details: txtDescription.text!, providers: newProvider)
                    }
                    
                }
                
                if(providerCount == 1 && existingProvider != txtProvider.text!){
                    for provider in providerList {
                        if(provider.name == existingProvider){
                            delegate?.deleteProvider(provider: provider)
                            delegate?.saveProducts()
                        }
                    }
                }
                
            } else {
                var isProviderExist = false
                let newProduct = Product(context: self.context)
                newProduct.name = txtName.text
                if let id = txtID.text{
                    newProduct.id = Int16(id)!
                }
                newProduct.provider = txtProvider.text
                newProduct.price = Double(txtPrice.text!)!
           
                newProduct.details = txtDescription.text
                self.productList.append(newProduct)
                for provider in self.providerList{
                    if(newProduct.provider == provider.name){
                        isProviderExist = true
                        newProduct.providers = provider
                        break
                    }
                }
                if(!isProviderExist){
                    let newProvider = Provider(context: context)
                    newProvider.name = newProduct.provider
                    self.providerList.append(newProvider)
                    newProduct.providers = newProvider
                }
            }
        }
        return true
    }
    
}

