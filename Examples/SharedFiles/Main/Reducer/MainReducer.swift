//
//  MainReducer.swift
//  tca-examples
//
//  Created by incetro on 12/12/23.
//

// MARK: - Reducer

/// A `Main` module reducer
///
/// It's a function that describes how to evolve the current `MainState` to the next state given an action.
/// The `MainReducer` is also responsible for returning any effects that should be run, such as API requests,
/// which can be done by returning an `Effect` value
///
/// - Note: The thread on which effects output is important. An effect's output is immediately sent
///   back into the store, and `Store` is not thread safe. This means all effects must receive
///   values on the same thread, **and** if the `Store` is being used to drive UI then all output
///   must be on the main thread. You can use the `Publisher` method `receive(on:)` for make the
///   effect output its values on the thread of your choice.
//public let mainReducer = MainReducer.combine(
//    .init { state, action, _ in
//        switch action {
//        case .onAppear:
//            state = .init()
//        default:
//            break
//        }
//        return .none
//    }
//)
