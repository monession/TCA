//
//  SimpleBindingsAction.swift
//  TCA-examples
//
//  Created by Nikita Lezya on 17/10/2021.
//  Copyright © 2021 Incetro Inc. All rights reserved.
//

import Foundation
import OldTCA

// MARK: - SimpleBindingsAction

/// All available `SimpleBindings` module actions.
///
/// It's a type that represents all of the actions that can happen in `SimpleBindings` feature,
/// such as user actions, notifications, event sources and more.
///
/// We have some actions in the feature. There are the obvious actions,
/// such as tapping some button, holding another button, or changing a slider value.
/// But there are also some slightly non-obvious ones, such as the action of the user dismissing the alert,
/// and the action that occurs when we receive a response from the fact API request.
public enum SimpleBindingsAction: Equatable {
    
    // MARK: - Cases
    
    /// Setter for `pickedColor` property binding
    case pickValue(SimpleBindingsState.PickableColor)
    
    /// Setter for `text` property binding
    case changeText(String)
    
    /// Setter for `toggleEnabled` property binding
    case switchToggle(Bool)
    
    /// Reset all controls
    case resetControls
    
    /// Setter for `sliderValue` property binding
    case moveSlider(Double)
    
    // MARK: - Children
    
    /// Child action for `Counter` module.
    ///
    /// It's necessary as we use `Scope` builder in current module's reducer.
    /// In short, the `counter` case means that every action in `Counter` module
    /// will be sent to current module through it
    case counter(CounterAction)
}
