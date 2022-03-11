//
//  CarListAdapter.swift
//  GetAround
//
//  Created by Florian Huet on 10/03/2022.
//

import UIKit

protocol CarListingAdapterDelegate : AdapterDelegate {
    func cellGotClicked(row: Int)
}

class CarListAdapter : NSObject, TableViewAdapter {
    
    weak var tableView: UITableView!
    weak var delegate: CarListingAdapterDelegate?
    
    fileprivate var cars : [Car]? {
        didSet { tableView.reloadData() }
    }
   
    required init(tableView: UITableView, delegate: AdapterDelegate?) {
        super.init()
        
        self.delegate = delegate as? CarListingAdapterDelegate
        self.tableView = tableView
        
        tableView.dataSource = self

        let carListCell = UINib(nibName: "CarListCell",
                                  bundle: nil)
        self.tableView.register(carListCell,
                                forCellReuseIdentifier: "CarListCell")
    }
    
    func reloadData(_ cars : [Car]) {
        self.cars = cars
    }
}

extension CarListAdapter : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.cellGotClicked(row: indexPath.row)
    }
}

extension CarListAdapter : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let carCell : CarListCell = tableView.dequeueReusableCell(withIdentifier: String(describing: CarListCell.self), for: indexPath) as? CarListCell {
            carCell.setup(cars?[indexPath.row])
            return carCell
        }
        return UITableViewCell()
    }
}
