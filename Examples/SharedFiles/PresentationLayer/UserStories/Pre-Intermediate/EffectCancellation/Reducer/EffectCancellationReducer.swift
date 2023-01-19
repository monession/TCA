//
//  EffectCancellationReducer.swift
//  TCA-examples
//
//  Created by incetro on 15/10/2021.
//  Copyright © 2021 Incetro Inc. All rights reserved.
//

import TCA
import Foundation

// MARK: - EffectCancellationFeature

public struct EffectCancellationFeature: ReducerProtocol {
    
    // MARK: - Identifiars
    
    private struct NumberFactRequestID: Hashable {}
    
    // MARK: - Properties
    
    /// NumberFactService instance
    public let numberFactService = NumberFactServiceImplementation()
    
    // MARK: - ReducerProtocol
    
    public var body: some ReducerProtocol<EffectCancellationState, EffectCancellationAction> {
        Scope(state: \.counter, action: /EffectCancellationAction.counter) {
            CounterFeature()
        }
        Reduce { state, action in
            switch action {
            case .factButtonTapped:
                state.numberFact = nil
                state.isFactRequestInFlight = true
                return .task { [count = state.counter.count] in
                    await .numberFactResponse(
                        TaskResult {
                            try await numberFactService.generateFact(number: count)
                        }
                    )
                }
                .cancellable(id: NumberFactRequestID(), cancelInFlight: true)
            case .randomFactButtonTapped:
                state.counter.count = Int(arc4random() % 100)
                return .concatenate(
                    .cancel(id: NumberFactRequestID()),
                    .init(value: EffectCancellationAction.factButtonTapped)
                )
            case let .numberFactResponse(.success(fact)):
                state.isFactRequestInFlight = false
                state.numberFact = fact
            case .numberFactResponse(.failure):
                state.isFactRequestInFlight = false
            case .cancelButtonTapped:
                state.isFactRequestInFlight = false
                return .cancel(id: NumberFactRequestID())
            case .counter:
                guard state.isFactRequestInFlight else { return .none }
                return .concatenate(
                    .cancel(id: NumberFactRequestID()),
                    .init(value: .factButtonTapped)
                )
            }
            return .none
        }
    }
}
