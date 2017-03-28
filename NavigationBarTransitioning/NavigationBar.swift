//
//  NavigationBar.swift
//  NavigationBarTransitioning
//
//  Created by Ilter Cengiz on 27/03/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import UIKit

class NavigationBar: UINavigationBar {
    
}

extension NavigationBar {
    
    func updateNavigationBarStyle(_ style: NavigationBarStyle) {
        barStyle = style.barStyle
        isTranslucent = style.isTranslucent
        barTintColor = style.barTintColor
        tintColor = style.tintColor
        setBackgroundImage(style.backgroundImage, for: .default)
        shadowImage = style.shadowImage
    }
    
}
