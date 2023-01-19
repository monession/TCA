//
//  SimpleEffectState.swift
//  TCA-examples
//
//  Created by incetro on 14/10/2021.
//  Copyright © 2021 Incetro Inc. All rights reserved.
//

import Foundation

// MARK: - SimpleEffectState

/// `SimpleEffect` module state
///
/// Basically, `SimpleEffectState` is a type that describes the data
/// `SimpleEffect` feature needs to perform its logic and render its UI.
public struct SimpleEffectState: Equatable {

    // MARK: - Properties

    /// CounterState instance
    public var counter = CounterState()

    /// True if a request is being in flight
    public var isFactRequestInFlight = false

    /// Last obtained fact
    public var numberFact: String?
}
