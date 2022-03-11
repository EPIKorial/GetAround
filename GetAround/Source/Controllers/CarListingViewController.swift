//
//  ViewController.swift
//  GetAround
//
//  Created by Florian Huet on 10/03/2022.
//

import UIKit

class CarListingViewController: UIViewController {

    @IBOutlet weak var carListTableView: UITableView!
    
    fileprivate var cars : [Car] = []
    
    fileprivate lazy var adapter: CarListAdapter = { [unowned self] in
        return CarListAdapter(tableView: self.carListTableView, delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        CarService.shared.fetchCarList { response in
            switch response.result {
            case .success(let cars) :
                self.cars = cars
                self.adapter.reloadData(cars)
            case .failure(_):
                break
            }
        }
    }
}

extension CarListingViewController : CarListingAdapterDelegate {
    func cellGotClicked(row: Int) {
        let detailsViewController = CarDetailsViewController()
        detailsViewController.car = cars[row]
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

