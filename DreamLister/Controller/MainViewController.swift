//
//  MainViewController.swift
//  DreamLister
//
//  Created by Luis Santos on 5/24/19.
//  Copyright © 2019 Luis Santos. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var controller: NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        generateTestData()
        attemptFetch()
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
        
    }
    
    func configureCell(cell: ItemCell, indexPath: NSIndexPath){
        
        //update cell
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
        
    }
    
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = controller.sections {
            
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = controller.sections {
            
            return sections.count
        }
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
    
        fetchRequest.sortDescriptors = [dateSort]
        
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        self.controller = controller
        
        do {
            
            try self.controller.performFetch()
            
        } catch {
            
            let error = error as NSError
            print("\(error)")
        }
        

    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
            
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                //Update the cell data
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        }
    }
    
    func generateTestData() {
        
//        let item = Item(context: context)
//        item.title = "MacBook Pro"
//        item.price = 1800
//        item.details = "Can't wait until the september event. Hope they relesase new MBPs"
//
//        let item2 = Item(context: context)
//        item2.title = "Tesla Model S"
//        item2.price = 100000
//        item2.details = "My dream Electric Vehicle"
//
//        let item3 = Item(context: context)
//        item3.title = "Nintendo Switch"
//        item3.price = 300
//        item3.details = "I want to play the new Smash Bros"
        
        //Creating test data
//        let store = Store(context: context)
//        store.name = "Best Buy"
//        let store2 = Store(context: context)
//        store2.name = "Fry's Electronics"
//        let store3 = Store(context: context)
//        store3.name = "Target"
//        let store4 = Store(context: context)
//        store4.name = "Tesla Dealership"
//        let store5 = Store(context: context)
//        store5.name = "Amazon.com"
        
        
        ad.saveContext()
        
    }
    
    


}

