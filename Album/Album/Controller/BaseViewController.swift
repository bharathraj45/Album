//
//  BaseViewController.swift
//  Album
//
//  Created by Venkatesh, Bharath Raj on 17/08/20.
//  Copyright © 2020 Venkatesh, Bharath Raj. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    func setNavigationBarTitle(title: String) {
        navigationItem.title = title
    }
    
    func showSimpleAlert(title: String?, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: completion) )
        self.present(alert, animated: true, completion: nil)
    }
}
