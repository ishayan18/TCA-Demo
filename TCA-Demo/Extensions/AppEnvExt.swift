//
//  AppEnvExt.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 24.02.22.
//

import Foundation
import ComposableArchitecture

#if DEBUG
  extension AppEnv {
    static var mocked: Self {
      .init(
        mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
        apiProvider: .mocked,
        keychainStorage: .standard
      )
    }
  }
#endif

