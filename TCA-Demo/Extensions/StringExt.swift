//
//  StringExt.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 24.02.22.
//

import Foundation

extension String {
  /// - Returns: `true` if contains any cahracters other than whitespace or newline characters, else `no`.
  public var isBlank: Bool { stripped().isEmpty }

  /// - Returns: The string stripped by whitespace and newline characters from beginning and end.
  public func stripped() -> String { trimmingCharacters(in: .whitespacesAndNewlines) }
}
