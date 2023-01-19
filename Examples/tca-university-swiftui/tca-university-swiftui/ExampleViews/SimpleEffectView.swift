//
//  SimpleEffectView.swift
//  TCA-examples
//
//  Created by incetro on 14/10/2021.
//  Copyright © 2021 Incetro Inc. All rights reserved.
//

import TCA
import SwiftUI

// MARK: - SimpleEffectView

public struct SimpleEffectView: View {

    // MARK: - Properties

    /// The store powering the `SimpleEffect` feature
    public let store: StoreOf<SimpleEffectFeature>

    // MARK: - View

    public var body: some View {
        WithViewStore(store) { viewStore in
            Form {
                Section(header: Text(template: Constants.summary).standard) {
                    CounterView(
                        store: store.scope(
                            state: \.counter,
                            action: SimpleEffectAction.counter
                        )
                    )
                    .buttonStyle(BorderlessButtonStyle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Button {
                        viewStore.send(.factButtonTapped)
                    } label: {
                        HStack {
                            Text("Generate fact")
                                .semibold
                                .standard
                            Spacer()
                            Text("🔥").standard
                        }
                    }
                    Button {
                        viewStore.send(.randomFactButtonTapped)
                    } label: {
                        HStack {
                            Text("Random fact")
                                .semibold
                                .standard
                            Spacer()
                            Text("🎲").standard
                        }
                    }
                    if viewStore.isFactRequestInFlight {
                        ProgressView()
                    }
                    viewStore.numberFact.map {
                        Text($0)
                    }
                }
                .textCase(nil)
            }
            .navigationBarTitle("Effect")
        }
    }
}

// MARK: - Constants

extension SimpleEffectView {

    enum Constants {

        static let summary = """
        This screen demonstrates how to use side effects with a feature built with the TCA.

        A side effect is a work item that needs to be performed in the outside world. For example, \
        an API request to an external service over HTTP

        Many things  in our applications can be represented as side effects, such as timers, network requests, \
        database requests, events observing, socket connections debouncing, throttling and delaying, etc.

        This application has two simple side effects:

        • Tapping "Generate fact" will trigger an API request to load a fact about the number
        • Tapping "Random fact" will change current number value and do the same

        Both effects are handled by the reducer, and a full test suite is written to confirm \
        that the effects behave in the way we expect.

        """
    }
}
