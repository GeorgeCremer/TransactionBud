//
//  String+Ext.swift
//  TransactionBud
//
//  Created by George Cremer on 18/04/2021.
//

import Foundation

extension String {
    func getCurrencySymbol() -> String? {
        let locale = NSLocale(localeIdentifier: self)
        return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: self)
    }
}
