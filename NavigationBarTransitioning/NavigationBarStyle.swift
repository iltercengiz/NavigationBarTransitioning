//
//  NavigationBarStyle.swift
//  NavigationBarTransitioning
//
//  Created by Ilter Cengiz on 27/03/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import UIKit

protocol NavigationBarStyling {
    var navigationBarStyle: NavigationBarStyle { get set }
}

struct NavigationBarStyle {
    
    let barStyle: UIBarStyle
    let isTranslucent: Bool
    let tintColor: UIColor
    let barTintColor: UIColor
    let backgroundImage: UIImage
    let shadowImage: UIImage?
    
    init(barStyle: UIBarStyle, isTranslucent: Bool, tintColor: UIColor, barTintColor: UIColor?, backgroundImage: UIImage, shadowImage: UIImage?) {
        self.barStyle = barStyle
        self.isTranslucent = isTranslucent
        self.tintColor = tintColor
        self.barTintColor = barTintColor ?? .clear
        self.backgroundImage = backgroundImage
        self.shadowImage = shadowImage
    }
    
    static let defaultBarStyle = NavigationBarStyle(barStyle: .default,
                                                    isTranslucent: false,
                                                    tintColor: UIColor.black,
                                                    barTintColor: UIColor.lightGray,
                                                    backgroundImage: UIImage(),
                                                    shadowImage: nil)
    
    static let hiddenBarStyle = NavigationBarStyle(barStyle: .default,
                                                   isTranslucent: true,
                                                   tintColor: UIColor.black,
                                                   barTintColor: nil,
                                                   backgroundImage: UIImage(),
                                                   shadowImage: UIImage())
    
}
