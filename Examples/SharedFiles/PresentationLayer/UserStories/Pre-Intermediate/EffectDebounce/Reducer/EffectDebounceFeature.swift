//
//  EffectDebounceFeature.swift
//  tca-university-swiftui
//
//  Created by Kazakh on 17.04.2023.
//

import OldTCA
import Foundation

// MARK: - EffectDebounceFeature

public struct EffectDebounceFeature: ReducerProtocol {
    
    // MARK: - Identifiers
    
    struct NumberFactRequestID: Hashable {}
    struct NumberFactDebounceID: Hashable {}
    
    // MARK: - Properties
    
    /// NumberFactService instance
    public let numberFactService = NumberFactServiceImplementation()
    
    // MARK: - ReducerProtocol
    
    public var body: some ReducerProtocol<EffectDebounceState, EffectDebounceAction> {
        Scope(state: \.counter, action: /EffectDebounceAction.counter) {
            CounterFeature()
        }
        Reduce { state, action in
            switch action {
            case .generateFact:
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
            case let .numberFactResponse(.success(fact)):
                state.isFactRequestInFlight = false
                state.numberFact = fact
                return .none
            case .numberFactResponse(.failure):
                state.isFactRequestInFlight = false
                return .none
            case .cancelButtonTapped:
                state.isFactRequestInFlight = false
                return .cancel(id: NumberFactRequestID())
            case .counter:
                return Effect(value: .generateFact)
                    .debounce(id: NumberFactDebounceID(), for: 1, scheduler: DispatchQueue.main)
            }
        }
    }
}
