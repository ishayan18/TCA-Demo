//
//  HomeView.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 24.02.22.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
  let store: Store<HomeState, HomeAction>

  var body: some View {
    WithViewStore(store) { viewStore in
      Button("Logout") {
        viewStore.send(.logoutPressed)
      }
    }
  }
}
