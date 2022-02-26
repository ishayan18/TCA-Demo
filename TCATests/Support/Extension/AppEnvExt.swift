//
//  AppEnvExt.swift
//  TCA-DemoTests
//
//  Created by Shayan Ali on 26.02.22.
//

@testable import TCA_Demo
import Foundation

extension AppEnv {
  static let test: Self = .init(
    mainQueue: TestContants.scheduler.eraseToAnyScheduler(),
    apiProvider: .test,
    keychainStorage: .test
  )
}

