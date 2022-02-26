//
//  Storage.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 25.02.22.
//

import Foundation

final public class Storage {
  var hasActiveSession: Bool = false
  var hasSelectedWorkspace: Bool = false
  let workspaces: [String] = ["Design", "Engineer", "Organization"]

  /// The standard object to be used in the app.
  static let standard: Storage = .init()
}
