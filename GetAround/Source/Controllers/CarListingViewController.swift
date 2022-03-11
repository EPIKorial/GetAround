//
//  ViewController.swift
//  GetAround
//
//  Created by Florian Huet on 10/03/2022.
//

import UIKit

class CarListingViewController: UIViewController {

    @IBOutlet weak var carListTableView: UITableView!
    
    fileprivate lazy var adapter: CarListAdapter = { [unowned self] in
        return CarListAdapter(tableView: self.carListTableView, delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        CarService.shared.fetchCarList { response in
            switch response.result {
            case .success(let cars) :
                self.adapter.reloadData(cars)
            case .failure(_):
                //TO DO : Error handling
                break
            }
        }
    }
}

extension CarListingViewController : CarListingAdapterDelegate {
    func cellGotClicked(row: Int) {
        
    }
}

