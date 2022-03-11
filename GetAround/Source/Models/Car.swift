//
//  Car.swift
//  GetAround
//
//  Created by Florian Huet on 10/03/2022.
//

import Foundation

struct Car : Decodable {
    var brand : String?
    var model : String?
    var pictureUrl : String?
    var pricePerDay : Int?
    var rating : Rating?
    var owner : Owner?
    
    enum CodingKeys: String, CodingKey {
        case brand = "brand"
        case model = "model"
        case pictureUrl = "picture_url"
        case pricePerDay = "price_per_day"
        case rating = "rating"
        case owner = "owner"
    }
}
