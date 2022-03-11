//
//  Rating.swift
//  GetAround
//
//  Created by Florian Huet on 10/03/2022.
//

import Foundation

struct Rating : Decodable {
    var average : Float?
    var count : Int?
    
    enum CodingKeys: String, CodingKey {
        case average = "average"
        case count = "count"
    }
}
