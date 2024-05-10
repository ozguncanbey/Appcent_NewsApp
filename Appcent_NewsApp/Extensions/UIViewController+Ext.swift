//
//  UIViewController+Ext.swift
//  Appcent_NewsApp
//
//  Created by Özgün Can Beydili on 10.05.2024.
//

import UIKit

extension UIViewController {
    /// If condition true, first view is visible, otherwise second view is visible
    static func toggleViews(condition: Bool, firstView: UIView, secondView: UIView) {
        if condition {
            firstView.isHidden = false
            secondView.isHidden = true
        } else {
            firstView.isHidden = true
            secondView.isHidden = false
        }
    }
}
