//
//  ItemDetailsViewController.swift
//  DreamLister
//
//  Created by Luis Santos on 5/27/19.
//  Copyright © 2019 Luis Santos. All rights reserved.
//

import UIKit


class ItemDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let topleftItem = self.navigationController?.navigationBar.topItem {
            topleftItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
  
    }


}
