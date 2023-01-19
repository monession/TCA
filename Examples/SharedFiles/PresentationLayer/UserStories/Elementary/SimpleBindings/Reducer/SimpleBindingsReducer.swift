//
//  SimpleBindingsReducer.swift
//  TCA-examples
//
//  Created by Nikita Lezya on 17/10/2021.
//  Copyright © 2021 Incetro Inc. All rights reserved.
//

import TCA

// MARK: - SimpleBindingsFeature

public struct SimpleBindingsFeature: ReducerProtocol {
    
    public var body: some ReducerProtocol<SimpleBindingsState, SimpleBindingsAction> {
        Scope(state: \.counter, action: /SimpleBindingsAction.counter) {
            CounterFeature()
        }
        Reduce { state, action in
            switch action {
            case .changeText(let text):
                state.text = text
            case .switchToggle(let enabled):
                state.toggleEnabled = enabled
            case .moveSlider(let value):
                state.sliderValue = Double(Int(value))
            case .resetControls:
                state = SimpleBindingsState()
            case .counter(.decrementButtonTapped):
                state.sliderValue = Double(min(state.counter.count, Int(state.sliderValue)))
            case .pickValue(let value):
                state.pickedColor = value
            default:
                break
            }
            return .none
        }
    }
}
