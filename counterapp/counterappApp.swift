//
//  counterappApp.swift
//  counterapp
//
//  Created by Kaito Kitaya on 03.10.24.
//

import SwiftUI
import ComposableArchitecture

@main
struct counterappApp: App {
    var body: some Scene {
        WindowGroup {
            CounterView(
                store: Store(initialState: CounterFeature.State()) {
                    CounterFeature()
                }
            )
        }
    }
}
