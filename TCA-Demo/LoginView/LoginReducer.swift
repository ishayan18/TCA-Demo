//
//  LoginReducer.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 24.02.22.
//

import ComposableArchitecture
import Foundation
import ApiClient

let loginReducer = Reducer<LoginState, LoginAction, AppEnv>() { state, action, env in
        switch action {
        case let .emailTextChanged(email):
          state.email = email
          return .init(value: .loginButtonEnablingUpdateRequested)

        case let .passwordTextChanged(password):
          state.password = password
          return .init(value: .loginButtonEnablingUpdateRequested)

        case .loginButtonEnablingUpdateRequested:
          state.loginButtonEnabled =
            !state.email.isBlank && !state.password.isBlank && !state.showLoginActivityIndicator

        case .loginBox(action: .loginPressed):
          return .init(value: .loginRequested(email: state.email, password: state.password))

        case .loginBox(action: .registerPressed):
          break  // handled by parent reducer

        case .loginBox(action: .togglePasswordAppearanceIconPressed):
          state.showPassword.toggle()

        case let .loginRequested(email, password):
          state.showLoginActivityIndicator = true
          return .merge(
            .init(value: .loginButtonEnablingUpdateRequested),
            env
              .apiProvider
              .publisher(
                on: .signIn(body: .init(.init(email: email, password: password))),
                decodeBodyTo: ApiResponse<AuthTokenResponse>.self
              )
              .receive(on: env.mainQueue)
              .catchToEffect()
              .map { LoginAction.receivedLoginResponse($0) }
          )

        case let .receivedLoginResponse(.success(authTokenResponse)):
          assert(
            authTokenResponse.data.attributes.tokenType == "Bearer",
            "Received unexpected token type upon login: '\(authTokenResponse.data.attributes.tokenType)'"
          )
          env.keychainStorage.setCodable(authTokenResponse.data.attributes.accessToken, for: .accessToken)
          return .init(value: .loginSuccessfullyCompleted)

        case let .receivedLoginResponse(.failure(apiError)):
          state.showLoginActivityIndicator = false
          state.errorMessage = apiError.localizedDescription
          return .init(value: .loginButtonEnablingUpdateRequested)

        case .loginSuccessfullyCompleted:
          state.showLoginActivityIndicator = false

        }
  return .none
      }

