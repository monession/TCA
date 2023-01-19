//
//  MainView.swift
//  tca-examples
//
//  Created by incetro on 12/12/23.
//

import SwiftUI
import TCA

// MARK: - MainView

public struct MainView: View {

    // MARK: - Properties

    let store: StoreOf<MainFeature>

    // MARK: - View

    public var body: some View {
        WithViewStore(store.stateless) { viewStore in
            NavigationView {
                Form {
                    Section(header: Text("👶🏻 Beginner")) {
                        NavigationLink(
                            destination: CounterExampleView(
                                store: store.scope(
                                    state: \.counter,
                                    action: MainAction.counter
                                )
                            )
                        ) {
                            Text("Basics").standard
                        }
                        NavigationLink(
                            destination: DoubleCounterView(
                                store: store.scope(
                                    state: \.doubleCounter,
                                    action: MainAction.doubleCounter
                                )
                            )
                        ) {
                            Text("Double counter").standard
                        }
                        NavigationLink(
                            destination: AnalyzableCounterView(
                                store: store.scope(
                                    state: \.analyzableCounter,
                                    action: MainAction.analyzableCounter
                                )
                            )
                        ) {
                            Text("Analyzable counter").standard
                        }
                        NavigationLink(
                            destination: FibonacciCounterView(
                                store: store.scope(
                                    state: \.fibonacciCounter,
                                    action: MainAction.fibonacciCounter
                                )
                            )
                        ) {
                            Text("Fibonacci counter").standard
                        }
                        NavigationLink(
                            destination: ScramblerView(
                                store: store.scope(
                                    state: \.scrambler,
                                    action: MainAction.scrambler
                                )
                            )
                        ) {
                            Text("Scrambler").standard
                        }
                    }
                    Section(header: Text("💡 Elementary")) {
                        NavigationLink(
                            destination: SimpleOptionalView(
                                store: store.scope(
                                    state: \.simpleOptional,
                                    action: MainAction.simpleOptional
                                )
                            )
                        ) {
                            Text("Simple optional").standard
                        }
                        NavigationLink(
                            destination: SimpleBindingsView(
                                store: store.scope(
                                    state: \.simpleBindings,
                                    action: MainAction.simpleBindings
                                )
                            )
                        ) {
                            Text("Manual bindings").standard
                        }
                        NavigationLink(
                            destination: FlexibleBindingsView(
                                store: store.scope(
                                    state: \.flexibleBindings,
                                    action: MainAction.flexibleBindings
                                )
                            )
                        ) {
                            Text("Automatic bindings").standard
                        }
                        if #available(iOS 15.0, *) {
                            NavigationLink(
                                destination: FocusStateView(
                                    store: store.scope(
                                        state: \.focusState,
                                        action: MainAction.focusState
                                    )
                                )
                            ) {
                                Text("Focus state").standard
                            }
                        }
                        NavigationLink(
                            destination: AlertAndSheetView(
                                store: store.scope(
                                    state: \.alertAndSheet,
                                    action: MainAction.alertAndSheet
                                )
                            )
                        ) {
                            Text("Alert and ActionSheet").standard
                        }
                    }
                    Section(header: Text("🙋🏻‍♂️ Pre Intermediate")) {
                        NavigationLink(
                            destination: SimpleEffectView(
                                store: store.scope(
                                    state: \.simpleEffect,
                                    action: MainAction.simpleEffect
                                )
                            )
                        ) {
                            Text("Effects").standard
                        }
                        NavigationLink(
                            destination: EffectCancellationView(
                                store: store.scope(
                                    state: \.effectCancellation,
                                    action: MainAction.effectCancellation
                                )
                            )
                        ) {
                            Text("Effect cancellation").standard
                        }
                    }
                    Section(header: Text("👨🏻‍💻 Intermediate")) {
                    }
                    Section(header: Text("👨🏻‍🏫 Upper intermediate")) {
                    }
                    Section(header: Text("👨🏻‍🎓 Advanced")) {
                    }
                    Section(header: Text("🥷🏻 Proficient")) {
                    }
                }
                .navigationBarTitle("TCA")
                .onAppear { viewStore.send(.onAppear) }
            }
        }
    }
}

let globalFontSize: CGFloat = 17
