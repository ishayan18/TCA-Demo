//
//  AppReducer.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 24.02.22.
//

import ComposableArchitecture
import ApiClient
import Microya
import Foundation

struct AppEnv {
  let mainQueue: AnySchedulerOf<DispatchQueue>
  let apiProvider: ApiProvider<PapershiftEndpoint>
  let keychainStorage: KeychainStorage
}

let appReducer = Reducer.combine(
  loginReducer
    .optional()
    .pullback(
      state: \AppState.loginState,
      action: /AppAction.login(action:),
      environment: { $0 }
    ),
  workspaceChooserReducer
    .optional()
    .pullback(
      state: \AppState.workspaceChooserState,
      action: /AppAction.workspaceChooser(action:),
      environment: { $0 }
    ),
  homeReducer
    .optional()
    .pullback(
      state: \AppState.homeState,
      action: /AppAction.home(action:),
      environment: { $0 }
    ),
  Reducer<AppState, AppAction, AppEnv>() { state, action, env in
    switch action {
    case .didAppear:
      if env.keychainStorage.hasActiveSession {
        if env.keychainStorage.containsCodable(for: .workspaceId) {
          state.homeState = .init()
          state.workspaceChooserState = nil
        }
        else {
          state.homeState = nil
          state.workspaceChooserState = .init()
        }
      } else {
        state.loginState = .init()
        state.homeState = nil
        state.workspaceChooserState = nil
      }
      return .none

    case .login(action: .loginSuccessfullyCompleted):
      state.homeState = nil
      state.loginState = nil
      state.workspaceChooserState = .init()
      return .none

    case let .workspaceChooser(.workspaceSelected(id, name)):
      env.keychainStorage.setCodable(id, for: .workspaceId)
      return .init(value: .didAppear)

    case .home(action: .logoutPressed):
      env.keychainStorage.removeAll()
      return .init(value: .didAppear)

    case .login, .workspaceChooser:
      break  // handled by child reducers
    }
    return .none
  }
)
