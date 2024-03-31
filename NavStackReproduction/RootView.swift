
import SwiftUI
import ComposableArchitecture

@Reducer
struct RootFeature {
    
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
        var cardsSets = MainFeature.State()
    }
    
    enum Action {
        case path(StackAction<Path.State, Path.Action>)
        case cardSets(MainFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            case .path:
                return .none
            case .cardSets:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
    }
    
    @Reducer
    struct Path: Reducer {
        
        @ObservableState
        enum State {
            case featureB(FeatureB.State)
        }
        
        enum Action {
            case featureB(FeatureB.Action)
        }
        
        var body: some ReducerOf<Self> {
            Scope(state: \.featureB, action: \.featureB) {
                FeatureB()
            }
        }
    }
}

struct RootView: View {
    @Bindable var store: StoreOf<RootFeature>
    
    var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path),
            root: {
                /* Does not work, will not update state and view will not even load new data
                when printing chagnes on the store, the console will only print the .onTask action to load info
                 but the subsequent changes won't happen.
                 */
                MainFeatureView(store: store.scope(state: \.cardsSets, action: \.cardSets))
                // Does work, but won't be able to comunicate back to the root view for navigation.(or at least not sure how to do it
                // since the state is totaly new instead of being part of the RootFeature's reducer)
//                MainFeatureView(
//                    store: Store(
//                        initialState: MainFeature.State(),
//                        reducer: { MainFeature() }
//                    )
//                )
            },
            destination: { store in
                switch store.state {
                case .featureB:
                    if let store = store.scope(state: \.featureB, action: \.featureB) {
                        FeatureBView(store: store)
                    }
                }
            }
        )
    }
}
