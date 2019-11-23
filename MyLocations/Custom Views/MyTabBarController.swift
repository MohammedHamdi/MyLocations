//
//  MyTabBarController.swift
//  MyLocations
//
//  Created by Mohammed Hamdi on 11/19/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return nil
    }
}
