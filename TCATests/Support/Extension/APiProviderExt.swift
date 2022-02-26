//
//  APiProviderExt.swift
//  TCA-DemoTests
//
//  Created by Shayan Ali on 26.02.22.
//

import ApiClient
import Foundation
import Microya
@testable import TCA_Demo

extension ApiProvider {
  static var test: ApiProvider<PapershiftEndpoint> {
    ApiProvider<PapershiftEndpoint>(
      baseUrl: URL(string: "https://papershift-web.herokuapp.com/api/v3")!,
      mockingBehavior: .init(
        delay: TestContants.requestDelay,
        scheduler: TestContants.scheduler.eraseToAnyScheduler(),
        mockedResponseProvider: { endpoint in
          switch endpoint {
          case .signIn:
            return endpoint.mock(status: .ok, mockedJson: .signInSuccess)

          case .index(.workspaces, _, _, _, _):
            return endpoint.mock(status: .ok, mockedJson: .workspacesPage1)

          default:
            return nil
          }
        }
      )
    )
  }
}

