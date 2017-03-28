//
//  NavigationController.swift
//  NavigationBarTransitioning
//
//  Created by Ilter Cengiz on 27/03/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    private var _delegate: UINavigationControllerDelegate?
    override var delegate: UINavigationControllerDelegate? {
        get {
            return self
        }
        set {
            _delegate = newValue
        }
    }
    
    // MARK: - Initializers
    
    convenience init() {
        self.init(navigationBarClass: NavigationBar.self, toolbarClass: nil)
    }
    
    // MARK: - View life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let viewController = topViewController {
            updateNavigationBar(viewController: viewController)
        }
    }
    
}

private extension NavigationController {
    
    func updateNavigationBarIfNeeded(_ context: UIViewControllerTransitionCoordinatorContext) {
        let key = UITransitionContextViewControllerKey.from
        guard let viewController = context.viewController(forKey: key) else {
            return
        }
        if context.isCancelled {
            updateNavigationBar(viewController: viewController)
        }
    }
    
    func updateNavigationBar(viewController: UIViewController) {
        guard
            let navigationBar = self.navigationBar as? NavigationBar,
            let navigationItem = viewController.navigationItem as? NavigationItem
        else {
            return
        }
        navigationBar.updateNavigationBarStyle(navigationItem.navigationBarStyle)
    }
    
}

extension NavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        guard let coordinator = viewController.transitionCoordinator else {
            return
        }
        if coordinator.isInteractive {
            coordinator.animate(alongsideTransition: {
                [weak self] _ in
                self?.updateNavigationBar(viewController: viewController)
            }, completion: nil)
        } else if animated {
            updateNavigationBar(viewController: viewController)
        }
        if #available(iOS 10.0, *) {
            coordinator.notifyWhenInteractionChanges(updateNavigationBarIfNeeded)
        } else {
            coordinator.notifyWhenInteractionEnds(updateNavigationBarIfNeeded)
        }
    }
    
}
