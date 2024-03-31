//
//  SetListView.swift
//  NavStackReproduction
//
//  Created by Daniel Sanchez on 29/03/24.
//

import SwiftUI
import ComposableArchitecture

struct SomeData: Identifiable, Equatable {
    var id = UUID()
    var string: String
}

@Reducer
struct MainFeature: Reducer {
    @ObservableState
    struct State {
        var cardsSets: [SomeData] = []
    }
    
    enum Action: Equatable {
        case onTask
        case onLoad(data: [SomeData])
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onTask:
                return .send(.onLoad(data: [.init(string: "some"), .init(string: "data"), .init(string: "array")]))
            case let .onLoad(data):
                state.cardsSets = data
                return .none
            }
        }
    }
}

struct MainFeatureView: View {
    let store: StoreOf<MainFeature>
    
    var body: some View {
        List {
            Text("Sample Text")
            ForEach(store.cardsSets) { text in
                Text(text.string)
            }
        }
        .onAppear {
            store.send(.onTask)
        }
    }
}
