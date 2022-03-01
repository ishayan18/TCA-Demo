//
//  KeychainStorage.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 25.02.22.
//

import Foundation
import SwiftyUserDefaults
import Valet

/// A convenience access wrapper to thesecure iOS keychain. Use this to store sensible data instead of the UserDefaults.
final class KeychainStorage {
  /// The collection of keys for objects stored to the keychain.
  enum CodableKey: String {
    /// The currently signed in users access token. Type: `String`
    case accessToken

    /// The currently signed in users related account ID. Type: `String`
    case accountId

    /// The currently selected workspace ID. Type: `String`
    case workspaceId

  }

  /// The standard object to be used in the app.
  static let standard: KeychainStorage = .init(
    identifier: Bundle.main.bundleIdentifier!,
    // this ensures that when app was uninstalled before, the keychain contents are reset (doesn't happen by default)
    removeAllObjects: Defaults.isFirstStart,  // AnyLint.skipHere: EnvUserDefaults
    afterRemoval: { Defaults.isFirstStart = false }
  )

  #if DEBUG
    /// A keychain storage for testing purposes only. This storage resets all of its data each time it's initialized to start clean between running test suites.
    /// Extra calls to `removeAll()` are still needed between single tests as this holds a strong reference – put them in `setUp()`.
    static let test: KeychainStorage = .init(
      identifier: "com.TCA.demo.tests",
      removeAllObjects: true,
      afterRemoval: { print("Automatically removed all objects from testing keychain storage.") }
    )
  #endif

  private let valet: Valet

  /// Returns `true` if the user is signed in or else returns `false`.
  var hasActiveSession: Bool {
    containsCodable(for: .accessToken)
  }

  private init(
    identifier: String,
    removeAllObjects: Bool,
    afterRemoval: () -> Void
  ) {
    let identifier = Identifier(nonEmpty: identifier)!
    self.valet = Valet.valet(with: identifier, accessibility: .afterFirstUnlock)

    if removeAllObjects {
      try! valet.removeAllObjects()
      afterRemoval()
    }
  }

  /// Returns the decoded persisted data found for the given key in the keychain or `nil`.
  func codable<T: Codable>(for key: CodableKey) -> T? {
    guard try! valet.containsCodable(forKey: key.rawValue) else { return nil }
    return try? valet.codable(forKey: key.rawValue)
  }

  /// Securely persists the encoded presentation of the given value for the given key in the keychain.
  func setCodable<T: Codable>(_ value: T, for key: CodableKey) {
    try! valet.setCodable(value, forKey: key.rawValue)
  }

  /// Returns `true` if any persisted data is found for the given key in the keychain or `false`.
  func containsCodable(for key: CodableKey) -> Bool {
    try! valet.containsCodable(forKey: key.rawValue)
  }

  /// Removes all objects from the store.
  func removeAll() {
    try! valet.removeAllObjects()
  }

  /// Removes object for the key from the store.
  func removeObject(forKey key: CodableKey) {
    try! valet.removeObject(forKey: key.rawValue)
  }
}

