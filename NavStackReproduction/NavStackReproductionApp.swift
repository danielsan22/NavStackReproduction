//
//  NavStackReproductionApp.swift
//  NavStackReproduction
//
//  Created by Daniel Sanchez on 29/03/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct NavStackReproductionApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(
                    initialState: RootFeature.State(),
                    reducer: { RootFeature()._printChanges() }
                )
            )
        }
    }
}
