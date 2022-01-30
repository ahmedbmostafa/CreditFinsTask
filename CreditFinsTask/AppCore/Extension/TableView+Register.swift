//
//  TableView+Register.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 28/01/2022.
//

import UIKit

extension UITableView {
    func registerNib(identifier: String) {
         let tableNib = UINib(nibName: identifier, bundle: nil)
         self.register(tableNib, forCellReuseIdentifier: identifier )
     }
}
