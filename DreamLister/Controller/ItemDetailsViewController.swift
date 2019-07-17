//
//  ItemDetailsViewController.swift
//  DreamLister
//
//  Created by Luis Santos on 5/27/19.
//  Copyright © 2019 Luis Santos. All rights reserved.
//

import UIKit
import CoreData


class ItemDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailField: CustomTextField!
    
    @IBOutlet weak var thumbImg: UIImageView!
    var stores = [Store]()
    var editingItem: Item?
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let topleftItem = self.navigationController?.navigationBar.topItem {
            topleftItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        getStores()
        
        if editingItem != nil {
            
            loadItemData()
        }
  
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        // First checking if we need create or update an existing ITEM object
        var item: Item!
        let picture = Image(context: context)
        picture.image = thumbImg.image

        
        if editingItem == nil {
            item = Item(context: context)
        }else {
            item = editingItem
        }
        
        item.toImage = picture
        
        if let title = titleField.text {
            
            item.title = title
        }
        
        if let price = priceField.text {
            
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailField.text  {
            
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //update when selected
    }

    func getStores() {
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
            
        } catch {
            
            //Handle Errors
        }
    }
    
    func loadItemData () {
        
        if let item = editingItem {
            
            titleField.text = item.title
            priceField.text = String(item.price)
            detailField.text = item.details
            thumbImg.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                
                var index = 0
                repeat {
                    
                    let s = stores[index]
                    if s.name == store.name {
                        
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    
                    index += 1
                    
                } while(index < stores.count)
                
            }
        }
    }
    
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if editingItem != nil {
            context.delete(editingItem!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            thumbImg.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil )
        
    }
    
}
