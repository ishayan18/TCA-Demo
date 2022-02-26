//
//  LoginBoxStore.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 24.02.22.
//

import SwiftUI

public class LoginBoxState: ObservableObject {
  public var email: Binding<String>
  public var password: Binding<String>
  public var showPassword: Bool
  public var loginButtonEnabled: Bool

  public init(
    email: Binding<String>,
    password: Binding<String>,
    showPassword: Bool,
    loginButtonEnabled: Bool
  ) {
    self.email = email
    self.password = password
    self.showPassword = showPassword
    self.loginButtonEnabled = loginButtonEnabled
  }
}

public enum LoginBoxAction {
  case loginPressed
  case registerPressed
  case togglePasswordAppearanceIconPressed
}

