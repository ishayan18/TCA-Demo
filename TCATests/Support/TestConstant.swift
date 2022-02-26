//
//  TestConstant.swift
//  TCA-DemoTests
//
//  Created by Shayan Ali on 26.02.22.
//

import Foundation
import ComposableArchitecture
import UIKit

enum TestContants {

  /// The test user email address.
  static let email: String = "sa_test@papershift.com"

  /// The test user password for login.
  static let password: String = "shayan123"

  /// The delay to put on API requests returning a result.
  static let requestDelay: DispatchQueue.SchedulerTimeType.Stride = .milliseconds(300)

  /// The test scheduler to control time in tests.
  static let scheduler: TestScheduler = DispatchQueue.test

  /// The default screen size for test screen snapshots.
  static let screenSize: CGSize = .init(width: 1080, height: 810)

  /// The test users related accounts ID.
  static let accountId: String = "68"
}

