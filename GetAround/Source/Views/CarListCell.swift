//
//  CarListCell.swift
//  GetAround
//
//  Created by Florian Huet on 10/03/2022.
//

import UIKit

final class CarListCell : UITableViewCell {
    
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carRentingPriceLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var starProgressView: UIProgressView!
    @IBOutlet weak var ratingNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hideLoader()
        
        starProgressView.contentScaleFactor = 10
        starProgressView.progressTintColor = .yellow
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setup(_ car: Car?) {
        guard let brand = car?.brand,
              let model = car?.model,
              let price = car?.pricePerDay,
              let ratingsAverage = car?.rating?.average,
              let ratingsNumber = car?.rating?.count else { return }
        ratingNumberLabel.text = "\(ratingsNumber)"
        carNameLabel.text = "\(brand) \(model)"
        carRentingPriceLabel.text = "\(price)€/j"
        
        let ratingNewValue : Float = Float(ratingsAverage * Float(Float(1) / Float(5)))
        starProgressView.setProgress(ratingNewValue, animated: true)
        
        displayLoader()
        
        guard let imgUrl = car?.pictureUrl else { return hideLoader() }
        
        CarService.shared.getImageByUrl(imgUrl) { img in
            DispatchQueue.main.async{
                self.carImageView.image = img
                self.hideLoader()
            }
        }
    }
    
    func displayLoader() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
}
