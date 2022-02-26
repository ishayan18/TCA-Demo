//
//  ApiResponseExt.swift
//  TCA-DemoTests
//
//  Created by Shayan Ali on 26.02.22.
//

import Foundation
import Microya
import ApiClient

extension ApiResponse {
  init(
    mockedJson: MockedJson
  ) {
    do {
      let mockedData = try Data(mockedJson: mockedJson)
      self = try JSONDecoder.papershiftApi.decode(Self.self, from: mockedData)
    }
    catch {
      fatalError("Mocked JSON data could not be converted to type \(Self.self). Error: \(error)")
    }
  }
}
