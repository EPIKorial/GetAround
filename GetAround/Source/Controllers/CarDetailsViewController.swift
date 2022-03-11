//
//  CarDetailsViewController.swift
//  GetAround
//
//  Created by Florian Huet on 10/03/2022.
//

import UIKit

class CarDetailsViewController : UIViewController {
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var carPriceLabel: UILabel!
    @IBOutlet weak var carRatingProgressView: UIProgressView!
    @IBOutlet weak var carRatingLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerRatingProgressView: UIProgressView!
    @IBOutlet weak var carPictureIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ownerPictureIndicator: UIActivityIndicatorView!
    
    var car : Car?
    
    fileprivate let OWNER_TEXT = "Owner"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        carRatingProgressView.contentScaleFactor = 10
        carRatingProgressView.progressTintColor = .yellow
        ownerRatingProgressView.contentScaleFactor = 10
        ownerRatingProgressView.progressTintColor = .yellow
        
        carNameLabel.font = UIFont.systemFont(ofSize: 20.0)
        carPriceLabel.font = UIFont.systemFont(ofSize: 20.0)
        carRatingLabel.font = UIFont.systemFont(ofSize: 10.0)
        ownerLabel.font = UIFont.systemFont(ofSize: 12.0)
        ownerNameLabel.font = UIFont.systemFont(ofSize: 12.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let brand = car?.brand,
              let model = car?.model,
              let price = car?.pricePerDay,
              let ownerName = car?.owner?.name else { return }
        carNameLabel.text = "\(brand) \(model)"
        carPriceLabel.text = "\(price)€/j"
        ownerLabel.text = OWNER_TEXT
        ownerNameLabel.text = ownerName
        setupCarRating()
        setupOwnerRating()
        setupCarPicture()
        setupOwnerPicture()
    }
    
    func setupCarRating() {
        guard let ratingsAverage = car?.rating?.average,
              let ratingsNumber = car?.rating?.count else { return }
        let ratingNewValue : Float = Float(ratingsAverage * Float(Float(1) / Float(5)))
        carRatingProgressView.setProgress(ratingNewValue, animated: true)
        carRatingLabel.text = "\(ratingsNumber)"
    }
    
    func setupOwnerRating() {
        guard let ratingsAverage = car?.owner?.rating?.average else { return }
        let ratingNewValue : Float = Float(ratingsAverage * Float(Float(1) / Float(5)))
        ownerRatingProgressView.setProgress(ratingNewValue, animated: true)
    }
    
    func setupCarPicture() {
        displayCarPictureLoader()
        
        guard let imgUrl = car?.pictureUrl else { return hideCarPictureLoader() }
        
        CarService.shared.getImageByUrl(imgUrl) { img in
            DispatchQueue.main.async{
                self.carImageView.image = img
                self.hideCarPictureLoader()
            }
        }
    }
    
    func setupOwnerPicture() {
        displayOwnerPictureLoader()
        
        guard let imgUrl = car?.owner?.pictureUrl else { return hideOwnerPictureLoader() }
        
        CarService.shared.getImageByUrl(imgUrl) { img in
            DispatchQueue.main.async{
                self.ownerImageView.image = img
                self.hideOwnerPictureLoader()
            }
        }
    }
    
    func displayCarPictureLoader() {
        self.carPictureIndicator.isHidden = false
        self.carPictureIndicator.startAnimating()
    }
    
    func hideCarPictureLoader() {
        self.carPictureIndicator.stopAnimating()
        self.carPictureIndicator.isHidden = true
    }
    
    func displayOwnerPictureLoader() {
        self.ownerPictureIndicator.isHidden = false
        self.ownerPictureIndicator.startAnimating()
    }
    
    func hideOwnerPictureLoader() {
        self.ownerPictureIndicator.stopAnimating()
        self.ownerPictureIndicator.isHidden = true
    }
}
