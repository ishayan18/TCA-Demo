import Foundation

extension Data {
  init(
    mockedJson: MockedJson
  ) throws {
    guard
      let jsonFileUrl = Bundle(for: LoginTests.self)
        .url(
          forResource: mockedJson.rawValue.firstUppercased,
          withExtension: "json"
        )
    else {
      // AnyLint.skipHere: SingleLineGuard
      fatalError("Reading mocked JSON data failed. File expected at: \(mockedJson.rawValue.firstUppercased).json")
    }

    self = try Data(contentsOf: jsonFileUrl)
  }
}

import Foundation

extension StringProtocol {
  /// Returns a variation with the first character uppercased.
  public var firstUppercased: String { prefix(1).uppercased() + dropFirst() }

  /// Returns a variation with the first character capitalized.
  public var firstCapitalized: String { prefix(1).capitalized + dropFirst() }

  /// Returns a variation with the first character lowercased.
  public var firstLowercased: String { prefix(1).lowercased() + dropFirst() }
}
