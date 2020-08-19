//
//  UIImageView+Extension.swift
//  Album
//
//  Created by Venkatesh, Bharath Raj on 17/08/20.
//  Copyright © 2020 Venkatesh, Bharath Raj. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

extension UIImageView {
    
    func setup(with imageUrl: String, placeholderImage: UIImage?) {
        if let url = URL(string: imageUrl) {
            self.af_setImage(withURL: url, placeholderImage: placeholderImage, imageTransition: .crossDissolve(0.2)) { response in
                if let error = response.error {
                    NSLog("Error loading image URL: \(error.localizedDescription)")
                }
            }
        }
        else {
            self.image = placeholderImage
        }
    }
}
