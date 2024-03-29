//
//  BasicListAction.swift
//  tca-university-swiftui
//
//  Created by Kazakh on 17.04.2023.
//

import Foundation

// MARK: - BasicListAction

/// All available `BasicList` module actions.
///
/// It's a type that represents all of the actions that can happen in `BasicList` feature,
/// such as user actions, notifications, event sources and more.
///
/// We have some actions in the feature. There are the obvious actions,
/// such as tapping some button, holding another button, or changing a slider value.
/// But there are also some slightly non-obvious ones, such as the action of the user dismissing the alert,
/// and the action that occurs when we receive a response from the fact API request.
public enum BasicListAction: Equatable {
    
    // MARK: - Cases
    
    // This case represents an action to update the existing items in a list
    case updateItems
    
    // This case represents an action to add a random item to a list
    case addRandom
}
