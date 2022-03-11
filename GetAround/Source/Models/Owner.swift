//
//  Owner.swift
//  GetAround
//
//  Created by Florian Huet on 10/03/2022.
//

import Foundation

struct Owner : Decodable {
    var name : String?
    var pictureUrl : String?
    var rating : Rating?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case pictureUrl = "picture_url"
        case rating = "rating"
    }
}
