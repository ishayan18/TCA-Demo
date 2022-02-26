//
//  TCA_DemoApp.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 24.02.22.
//

import SwiftUI
import ComposableArchitecture
import Microya
import ApiClient

@main
struct TCA_DemoApp: App {
  let store: Store<AppState, AppAction>
  let env: AppEnv
  
  init() {
    let apiProviderPlugins: [Plugin<PapershiftEndpoint>] = {
      let plugins: [Plugin<PapershiftEndpoint>] = [
        TokenAuthPlugin {
          KeychainStorage.standard.codable(for: .accessToken)
        },
        NetworkRequestModifier()
      ]
      return plugins
    }()

    self.env = AppEnv(
      mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
      apiProvider: ApiProvider<PapershiftEndpoint>(
        baseUrl: ServerUrls.stagingServerBaseUrl,
        plugins: apiProviderPlugins
      ),
      keychainStorage: .standard
    )
    self.store = Store(
      initialState: AppState(),
      reducer: appReducer.debugActions(actionFormat: .labelsOnly),
      environment: self.env
    )
  }

    var body: some Scene {
        WindowGroup {
         AppView(store: store)
        }
    }
}
