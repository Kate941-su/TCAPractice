//
//  ContentView.swift
//  counterapp
//
//  Created by Kaito Kitaya on 03.10.24.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    
    let store: StoreOf<CounterFeature>
    
    var body: some View {
      Form {
        Section {
          Text("\(store.count)")
            Button("Decrement") { store.send(.decrementButtonTapped) }
            Button("Increment") { store.send(.incrementButtonTapped) }
            Button("Decrement(Async)") {store.send(.decrementAsyncButtonTapped)}
            Button("Increment(Async)") {store.send(.incrementAsyncButtonTapped)}
        }

        Section {
          Button("Number fact") { store.send(.numberFactButtonTapped) }
        }
        
        if let fact = store.numberFact {
          Text(fact)
        }
      }
    }
}

//#Preview {
//    CounterView(store: Store(
//        initialState: CounterFeature.State(),
//        reducer: CounterFeature())
//    )
//}
