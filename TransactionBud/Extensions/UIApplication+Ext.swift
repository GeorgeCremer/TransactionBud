//
//  UIApplication+Ext.swift
//  TransactionBud
//
//  Created by George Cremer on 18/04/2021.
//

import UIKit

extension UIApplication {
    static var topSafeAreaHeight: CGFloat {
        var topSafeAreaHeight: CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows[0]
            topSafeAreaHeight = window.safeAreaInsets.top
        }
        return topSafeAreaHeight
    }

    static var bottomSafeAreaHeight: CGFloat {
        var bottomSafeAreaHeight: CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows[0]
            bottomSafeAreaHeight = window.safeAreaInsets.bottom
        }
        return bottomSafeAreaHeight
    }
}
