//
//  SimpleEffectReducer.swift
//  TCA-examples
//
//  Created by incetro on 14/10/2021.
//  Copyright © 2021 Incetro Inc. All rights reserved.
//

import TCA
import Darwin

// MARK: - SimpleOptionalFeature

public struct SimpleEffectFeature: ReducerProtocol {
    
    // MARK: - Properties
    
    /// NumberFactService instance
    public let numberFactService = NumberFactServiceImplementation()
    
    // MARK: - ReducerProtocol
    
    public var body: some ReducerProtocol<SimpleEffectState, SimpleEffectAction> {
        Scope(state: \.counter, action: /SimpleEffectAction.counter) {
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
            case .randomFactButtonTapped:
                state.counter.count = Int(arc4random() % 100)
                return Effect(value: .factButtonTapped)
            case let .numberFactResponse(.success(fact)):
                state.isFactRequestInFlight = false
                state.numberFact = fact
                return .none
            case .numberFactResponse(.failure):
                state.isFactRequestInFlight = false
                return .none
            default:
                return .none
            }
        }
    }
}
