//
//  XIBUtils.swift
//  GetAround
//
//  Created by Florian Huet on 10/03/2022.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

extension UIViewController {
    class func fromNib<T: UIViewController>() -> T {
        return self.init(nibName: String(describing: self), bundle: nil) as! T
    }
}
