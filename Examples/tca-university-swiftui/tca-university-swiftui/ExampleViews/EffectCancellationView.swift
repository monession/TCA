//
//  EffectCancellationView.swift
//  TCA-examples
//
//  Created by incetro on 15/10/2021.
//  Copyright © 2021 Incetro Inc. All rights reserved.
//

import TCA
import SwiftUI

// MARK: - EffectCancellationView

public struct EffectCancellationView: View {

    // MARK: - Properties

    /// The store powering the `EffectCancellation` feature
    public let store: StoreOf<EffectCancellationFeature>

    // MARK: - View

    public var body: some View {
        WithViewStore(store) { viewStore in
            Form {
                Section(header: Text(template: Constants.summary).standard) {
                    CounterView(
                        store: store.scope(
                            state: \.counter,
                            action: EffectCancellationAction.counter
                        )
                    )
                    .buttonStyle(BorderlessButtonStyle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    if viewStore.isFactRequestInFlight {
                        Button {
                            viewStore.send(.cancelButtonTapped)
                        } label: {
                            HStack {
                                Text("Cancel")
                                    .semibold
                                    .standard
                                Spacer()
                                ActivityIndicator()
                            }
                        }
                    } else {
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
                        ActivityIndicator()
                    }
                    viewStore.numberFact.map { Text($0) }
                }
                .textCase(nil)
            }
            .navigationBarTitle("Effect cancellation")
        }
    }
}

// MARK: - Constants

extension EffectCancellationView {

    enum Constants {

        static let summary = """
        This screen demonstrates how to cancel side effects with a feature built with the TCA.

        Current example has several simple side effects:

        • Tapping "Generate fact" will trigger an API request to load a fact about the number
        • Tapping "Random fact" will cancel existing API request, change current number value and request a new fact about the number
        • Tapping "Cancel" will cancel current API request
        • Tapping "+/-" will cancel current API request if it is running and send a new one (if a request is in a flight)

        All effects are handled by the reducer, and a full test suite is written to confirm \
        that the effects behave in the way we expect.

        """
    }
}
