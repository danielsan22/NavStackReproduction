//
//  FeatureBView.swift
//  NavStackReproduction
//
//  Created by Daniel Sanchez on 30/03/24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct FeatureB: Reducer {
    
    @ObservableState
    struct State {
        var set: SomeData
        
        init(set: SomeData) {
            self.set = set
        }
    }
    
    enum Action: Equatable {
        case someDelegate
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .someDelegate:
                return .none
            }
        }
    }
}

struct FeatureBView: View {
    let store: StoreOf<FeatureB>
    
    var body: some View {
        HStack {
            Text(store.set.string)
        }
    }
}
