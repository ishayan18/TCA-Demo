//
//  NetworkRequestModifier.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 25.02.22.
//

import Foundation
import Microya

final class NetworkRequestModifier<EndpointType: Endpoint>: Plugin<EndpointType> {
  override func modifyRequest(
    _ request: inout URLRequest,
    endpoint: EndpointType
  ) {
    request.timeoutInterval = 20
  }
}

