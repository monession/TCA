//
//  FlexibleBindingsState.swift
//  TCA-examples
//
//  Created by Nikita Lezya on 29/10/2021.
//  Copyright © 2021 Incetro Inc. All rights reserved.
//

import Foundation
import SwiftUI
import TCA

// MARK: - FlexibleBindingsState

/// `FlexibleBindings` module state
///
/// Basically, `FlexibleBindingsState` is a type that describes the data
/// `FlexibleBindings` feature needs to perform its logic and render its UI.
public struct FlexibleBindingsState: Equatable {

    // MARK: - PickableColor

    /// Tint color variants
    public enum PickableColor: String, CaseIterable {
        
        // MARK: - Cases

        case red
        case green
        case blue
        case orange
        case purple
        
        // MARK: - Properties

        var color: Color {
            switch self {
            case .red:
                return .red
            case .green:
                return .green
            case .blue:
                return .blue
            case .orange:
                return .orange
            case .purple:
                return .purple
            }
        }
    }

    // MARK: - Properties

    /// Tint color variants
    public let colors = PickableColor.allCases

    /// Current tint color for all controls
    @BindableState public var pickedColor = PickableColor.red

    /// Currently inputed text
    @BindableState public var text = ""

    /// True if controls can be touched
    @BindableState public var toggleEnabled = false

    /// Current slider value
    @BindableState public var sliderValue = 0.0

    /// Max slider value
    public var counter = CounterState(count: 13)
}
