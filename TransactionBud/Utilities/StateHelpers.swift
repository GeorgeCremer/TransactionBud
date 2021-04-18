//
//  StateHelpers.swift
//  TransactionBud
//
//  Created by George Cremer on 18/04/2021.
//

import Foundation

enum EditButtonStates {
    case done
    case edit

    var title: String {
        switch self {
        case .done:
            return "Done"
        case .edit:
            return "Edit"
        }
    }
}
