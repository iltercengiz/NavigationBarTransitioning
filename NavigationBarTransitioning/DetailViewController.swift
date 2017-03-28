//
//  DetailViewController.swift
//  NavigationBarTransitioning
//
//  Created by Ilter Cengiz on 27/03/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let navigationItem = self.navigationItem as? NavigationItem {
            navigationItem.navigationBarStyle = .hiddenBarStyle
        }
    }
    
}
