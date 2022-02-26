//
//  AppStore.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 24.02.22.
//

import Foundation

struct AppState: Equatable {
  var loginState: LoginState?
  var homeState: HomeState?
  var workspaceChooserState: WorkspaceChooserState?
}

enum AppAction: Equatable {
  case didAppear
  case login(action: LoginAction)
  case home(action: HomeAction)
  case workspaceChooser(action: WorkspaceChooserAction)
}

