//
//  LoginTests.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 26.02.22.
//

@testable import TCA_Demo
import ComposableArchitecture
import XCTest
import ApiClient
import SnapshotTesting
import SwiftUI

class LoginTests: XCTestCase {
  override func setUp() {
    UserDefaults.test.removeAll()
    KeychainStorage.test.removeAll()
  }

  func testSuccessfulLogin() {
    let store = TestStore(
      initialState: .init(),
      reducer: loginReducer,
      environment: .test
    )

    store.send(.emailTextChanged(TestContants.email)) {
      $0.email = TestContants.email
    }
    store.receive(.loginButtonEnablingUpdateRequested)

    store.send(.loginBox(action: .togglePasswordAppearanceIconPressed)) {
      $0.showPassword = true
    }

    store.send(.passwordTextChanged(TestContants.password)) {
      $0.password = TestContants.password
    }
    store.receive(.loginButtonEnablingUpdateRequested) {
      $0.loginButtonEnabled = true
    }

    store.send(.loginBox(action: .loginPressed))
    store.receive(.loginRequested(email: TestContants.email, password: TestContants.password)) {
      $0.showLoginActivityIndicator = true
    }
    store.receive(.loginButtonEnablingUpdateRequested) {
      $0.loginButtonEnabled = false
    }

    TestContants.scheduler.advance(by: TestContants.requestDelay)
    store.receive(.receivedLoginResponse(.success(.init(mockedJson: .signInSuccess))))

    store.receive(.loginSuccessfullyCompleted) {
      $0.showLoginActivityIndicator = false
    }
  }


  func testRenderingState() {
    var state = LoginState()

    func loginView(state: LoginState) -> some View {
      NavigationView {
        LoginView(store: .init(initialState: state, reducer: .empty, environment: AppEnv.test))
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .navigationBarHidden(true)
    }

    assertScreenshot(variant: "Initial", view: loginView(state: state))

    state.email = TestContants.email
    state.password = TestContants.password
    state.loginButtonEnabled = true
    assertScreenshot(variant: "Credentials", view: loginView(state: state))

    state.showPassword = true
    assertScreenshot(variant: "Credentials+ShowPassword", view: loginView(state: state))

    state.showPassword = false
    state.loginButtonEnabled = false
    state.showLoginActivityIndicator = true
    assertScreenshot(variant: "Credentials+OngoingRequest", view: loginView(state: state))
  }
}

