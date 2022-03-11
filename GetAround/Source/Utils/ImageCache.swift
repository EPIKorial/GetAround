//
//  ImageCache.swift
//  GetAround
//
//  Created by Florian Huet on 11/03/2022.
//

import Foundation
import UIKit
import Alamofire

final class ImageCache {

    private var imagesCash = NSCache<NSString, UIImage>()
    private var queue = [String : [(UIImage?) -> ()]]()
    
    private let DEFAULT_IMAGE = "default"
    
    public func addImage(identifier: String, image: UIImage) {
        self.imagesCash.setObject(image, forKey: identifier as NSString)
    }
    
    public func getImage(by url: String, completion: @escaping (UIImage?) -> () ) {
        if let cachedImage = imagesCash.object(forKey: url as NSString) {
            return completion(cachedImage)
        }
        if self.queue[url] == nil { self.queue[url] =  [(UIImage?) -> ()]() }
        self.queue[url]?.append(completion)
        
        AF.download(url).responseData { response in
            switch response.result {
            case .success(let imgData) :
                let image = UIImage(data: imgData) ?? UIImage(named: self.DEFAULT_IMAGE)
                self.imagesCash.setObject(image!, forKey: url as NSString)
                guard let queue = self.queue[url] else { return }
                for c in queue  { c(image) }
                self.queue[url]?.removeAll()
            case .failure(_):
                guard let queue = self.queue[url] else { return }
                for c in queue  { c(UIImage(named: self.DEFAULT_IMAGE)) }
                self.queue[url]?.removeAll()
            }
        }
    }
}
