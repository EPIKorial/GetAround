//
//  CarServices.swift
//  GetAround
//
//  Created by Florian Huet on 10/03/2022.
//

import Foundation
import Alamofire

class CarService {
    fileprivate static var service: CarService! = nil
    
    private init() {
        if let path = Bundle.main.path(forResource: INFO_FILE_NAME, ofType: INFO_FILE_TYPE) {
            resourceFileDictionary = NSDictionary(contentsOfFile: path)
        }
    }
    
    static var shared: CarService {
        return service == nil ? CarService() : service
    }
    
    private var resourceFileDictionary : NSDictionary?
    private let INFO_FILE_NAME = "Info"
    private let INFO_FILE_TYPE = "plist"
    private let ENDPOINT_URL_PATH = "EndpointUrl"
    
    private let imageCache = ImageCache()
}

extension CarService {
    func fetchCarList(closure: @escaping (AFDataResponse<[Car]>) -> ()) {
        guard let url = resourceFileDictionary?[ENDPOINT_URL_PATH] as? String else { return }
        AF.request(url).responseDecodable(of: [Car].self) { response in
            closure(response)
        }
    }
    
    func getImageByUrl(_ url: String, closure: @escaping (UIImage?) -> ()) {
        imageCache.getImage(by: url) { img in
            closure(img)
        }
    }
}
