//
//  NavigationController.swift
//  NavigationBarTransitioning
//
//  Created by Ilter Cengiz on 27/03/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    fileprivate var _delegate: UINavigationControllerDelegate?
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
        // Call the delegate function if there's any external delegate assigned
        _delegate?.navigationController?(navigationController,
                                         willShow: viewController,
                                         animated: animated)
        
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
    
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        // Call the delegate function if there's any external delegate assigned
        _delegate?.navigationController?(navigationController,
                                         didShow: viewController,
                                         animated: animated)
    }
    
    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        // Call the delegate function if there's any external delegate assigned
        if let orientationMask = _delegate?.navigationControllerSupportedInterfaceOrientations?(navigationController) {
            return orientationMask
        }
        return .all
    }
    
    func navigationControllerPreferredInterfaceOrientationForPresentation(_ navigationController: UINavigationController) -> UIInterfaceOrientation {
        // Call the delegate function if there's any external delegate assigned
        if let orientation = _delegate?.navigationControllerPreferredInterfaceOrientationForPresentation?(navigationController) {
            return orientation
        }
        return .unknown
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        // Call the delegate function if there's any external delegate assigned
        return _delegate?.navigationController?(navigationController,
                                                interactionControllerFor: animationController)
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // Call the delegate function if there's any external delegate assigned
        return _delegate?.navigationController?(navigationController,
                                                animationControllerFor: operation,
                                                from: fromVC,
                                                to: toVC)
    }
    
}
