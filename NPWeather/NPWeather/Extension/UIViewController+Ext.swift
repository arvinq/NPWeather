//
//  UIViewController+Ext.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/3/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /**
     * Show alert using the passed title and message. Mainly used for errors encountered in network call
     *
     * - Parameters:
     *   - title: Title of the alert message
     *   - message: Information message showing the reason for the alert
     *   - buttonTitle: Title of the button to dismiss alert
     */
    func presentAlert(withTitle title: String, andMessage message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: buttonTitle, style: .cancel)
            
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)
        }
    }
    
    /**
     * Helper method to add child view controller to self (parent view controller)
     *
     * - Parameters:
     *   - childViewController: view controller to add
     *   - containerView: view of the parent view controller
     */
    func add(childViewController: UIViewController, to containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }
}
