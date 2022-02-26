//
//  AppView.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 24.02.22.
//

import ComposableArchitecture
import SwiftUI

struct AppView: View {
  let store: Store<AppState, AppAction>

  var body: some View {
    WithViewStore(store) { viewStore in
      Group {
        IfLetStore(
          store.scope(
            state: { $0.loginState },
            action: AppAction.login(action:)
          ),
          then: LoginView.init(store:)
        )

        IfLetStore(
          store.scope(
            state: { $0.workspaceChooserState },
            action: AppAction.workspaceChooser(action:)
          ),
          then: WorkspaceChooserView.init(store:)
        )

        IfLetStore(
          store.scope(
            state: { $0.homeState },
            action: AppAction.home(action:)
          ),
          then: HomeView.init(store:)
        )
      }
      .onAppear {
        viewStore.send(.didAppear)
      }
    }
  }
}

#if DEBUG
  struct AppView_Previews: PreviewProvider {
    static let store = Store(
      initialState: AppState(),
      reducer: appReducer,
      environment: .mocked
    )

    static var previews: some View {
      AppView(store: store)
    }
  }
#endif

