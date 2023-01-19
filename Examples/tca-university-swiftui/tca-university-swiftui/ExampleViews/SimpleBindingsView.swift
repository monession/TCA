//
//  SimpleBindingsView.swift
//  TCA-examples
//
//  Created by Nikita Lezya on 17/10/2021.
//  Copyright © 2021 Incetro Inc. All rights reserved.
//

import TCA
import SwiftUI

// MARK: - SimpleBindingsView

public struct SimpleBindingsView: View {

    // MARK: - Properties

    /// The store powering the `SimpleBindings` feature
    public let store: StoreOf<SimpleBindingsFeature>

    // MARK: - View

    public var body: some View {
        WithViewStore(store) { viewStore in
            Form {
                Section(header: Text(template: Constants.summary).standard) {

                    Picker(
                        "",
                        selection: viewStore.binding(
                            get: \.pickedColor,
                            send: SimpleBindingsAction.pickValue
                        )
                    ) {
                        ForEach(viewStore.colors, id: \.self) {
                            Text($0.rawValue.capitalized).tag($0.color)
                        }
                    }
                    .pickerStyle(.segmented)
                    .disabled(viewStore.toggleEnabled)

                    TextField(
                        "Enter your text",
                        text: viewStore.binding(
                            get: \.text,
                            send: SimpleBindingsAction.changeText
                        )
                    )
                    .disabled(viewStore.toggleEnabled)
                    .standard

                    Toggle(isOn: viewStore.binding(
                        get: \.toggleEnabled,
                        send: SimpleBindingsAction.switchToggle)
                    ) {
                        Text("Disable other controls").standard
                    }
                    .toggleStyle(SwitchToggleStyle(tint: viewStore.pickedColor.color))

                    HStack {
                        Text("This counter changes slider's max value").standard
                        Spacer()
                        CounterView(
                            store: store.scope(
                                state: \.counter,
                                action: SimpleBindingsAction.counter
                            )
                        )
                        .buttonStyle(BorderlessButtonStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                    }
                    .disabled(viewStore.toggleEnabled)

                    HStack {
                        Text("Slider value: \(Int(viewStore.sliderValue))").standard
                        Spacer(minLength: Constants.interspacing)
                        Slider(
                            value: viewStore.binding(
                                get: \.sliderValue,
                                send: SimpleBindingsAction.moveSlider
                            ),
                            in: 0...Double(viewStore.counter.count),
                            step: 1
                        )
                        .disabled(viewStore.toggleEnabled)
                    }

                    Button("Reset all controls") {
                        viewStore.send(.resetControls)
                    }
                    .standard
                }
                .textCase(nil)
            }
            .accentColor(viewStore.pickedColor.color)
        }
        .navigationBarTitle("Simple Bindings")
    }
}

// MARK: - Constants

extension SimpleBindingsView {

    enum Constants {

        static let interspacing: CGFloat = 16

        static let summary = """
        This screen demonstrates how simple bindings between views and state can be achieved with the TCA.

        Any view change updates the state and consequently the state affects other views if they bound to that state.

        • Changing a picker value updates accentColor of all views
        • TextField and Slider are just bound to the state
        • SwitchToggle is responsible for disabling all other controls excluding Reset button
        • Counter affects the maximum available value of the Slider
        • Reset Button resets state to the default value

        """
    }
}
