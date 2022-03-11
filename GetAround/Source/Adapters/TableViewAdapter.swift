//
//  TableViewAdapter.swift
//  GetAround
//
//  Created by Florian Huet on 10/03/2022.
//

import Foundation
import UIKit

@objc protocol AdapterDelegate { }

protocol TableViewAdapter {
    init(tableView: UITableView, delegate: AdapterDelegate?)
}
