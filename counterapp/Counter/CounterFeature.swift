//
//  CounterReducer.swift
//  counterapp
//
//  Created by Kaito Kitaya on 03.10.24.
//

import Foundation
import ComposableArchitecture

private let unit = 1000000000

@Reducer
struct CounterFeature {
    @ObservableState
    struct State: Equatable {
        var count = 0
        var numberFact: String?
    }
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case decrementAsyncButtonTapped
        case decrementAsyncCompleted
        case incrementAsyncButtonTapped
        case incrementAsyncCompleted
        case numberFactButtonTapped
        case numberFactResponse(String)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                return .none
                
            case .incrementButtonTapped:
                state.count += 1
                return .none
                                
            case .decrementAsyncButtonTapped:
                return .run { send in
                    try? await Task.sleep(nanoseconds: UInt64(1 * unit))
                    await send(.decrementAsyncCompleted)
                }
                
            case .decrementAsyncCompleted:
                state.count -= 1
                return .none
                
            case .incrementAsyncButtonTapped:
                return .run { send in
                    try? await Task.sleep(nanoseconds: UInt64(unit))
                    await send(.incrementAsyncCompleted)
                }
                
            case .incrementAsyncCompleted:
                state.count += 1
                return .none
            
            case .numberFactButtonTapped:
              return .run { [count = state.count] send in
                let (data, _) = try await URLSession.shared.data(
                  from: URL(string: "http://numbersapi.com/\(count)/trivia")!
                )
                await send(
                  .numberFactResponse(String(decoding: data, as: UTF8.self))
                )
              }

           case let .numberFactResponse(fact):
            state.numberFact = fact
            return .none

            }
        }
    }
}
