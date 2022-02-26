//
//  DefaultKeysExt.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 25.02.22.
//

import Foundation
import SwiftyUserDefaults

/// Extension to provide the keys for convenient access in the UserDefaults. Don't add any sensitive information here, use `KeychainStorage` instead.
extension DefaultsKeys {
  /// Specifies if the current session is the first time the app was started after installing it.
  var isFirstStart: DefaultsKey<Bool> { .init("isFirstStart", defaultValue: true) }
}

