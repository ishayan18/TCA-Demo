//
//  HomeReducer.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 24.02.22.
//

import ComposableArchitecture

let homeReducer = Reducer<HomeState, HomeAction, AppEnv>() { state, action, env in
  switch action {
  case .logoutPressed: //handled by parent reducer
    return .none
  }
}
