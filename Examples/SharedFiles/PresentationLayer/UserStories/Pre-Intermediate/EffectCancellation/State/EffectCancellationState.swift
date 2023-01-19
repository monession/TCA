//
//  EffectCancellationState.swift
//  TCA-examples
//
//  Created by incetro on 15/10/2021.
//  Copyright © 2021 Incetro Inc. All rights reserved.
//

import Foundation

// MARK: - EffectCancellationState

/// `EffectCancellation` module state
///
/// Basically, `EffectCancellationState` is a type that describes the data
/// `EffectCancellation` feature needs to perform its logic and render its UI.
public struct EffectCancellationState: Equatable {

    // MARK: - Properties

    /// CounterState instance
    public var counter = CounterState()

    /// True if a request is being in flight
    public var isFactRequestInFlight = false

    /// Last obtained fact
    public var numberFact: String?
}
