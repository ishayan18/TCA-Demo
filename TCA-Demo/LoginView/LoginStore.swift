//
//  LoginStore.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 24.02.22.
//

import ApiClient
import Foundation
import Microya

struct LoginState: Equatable {
  var email: String = ""
  var password: String = ""
  var showPassword: Bool = false
  var loginButtonEnabled: Bool = false
  var showLoginActivityIndicator: Bool = false
  var errorMessage: String?
}

enum LoginAction: Equatable {
  case emailTextChanged(String)
  case passwordTextChanged(String)
  case loginBox(action: LoginBoxAction)
  case loginButtonEnablingUpdateRequested
  case loginRequested(email: String, password: String)
  case receivedLoginResponse(Result<ApiResponse<AuthTokenResponse>, ApiError<PapershiftError>>)
  case loginSuccessfullyCompleted
}
