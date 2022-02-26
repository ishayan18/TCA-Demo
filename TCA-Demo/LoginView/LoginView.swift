//
//  ContentView.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 24.02.22.
//

import ComposableArchitecture
import SwiftUI
import SFSafeSymbols

struct LoginView: View {
  let store: Store<LoginState, LoginAction>

  @Environment(\.presentationMode)
  var presentationMode: Binding<PresentationMode>

  init(
    store: Store<LoginState, LoginAction>
  ) {
    self.store = store
  }

  var body: some View {
    ZStack {
      WithViewStore(store) { viewStore in
          LoginBoxView(
            state: .init(
              email:
                viewStore.binding(
                get: \.email,
                send: LoginAction.emailTextChanged
              ),
              password: viewStore.binding(
                get: { $0.password },
                send: LoginAction.passwordTextChanged
              ),
              showPassword: viewStore.showPassword,
              loginButtonEnabled: viewStore.loginButtonEnabled
            ),
            actionHandler: { viewStore.send(.loginBox(action: $0)) }
          )
          .onSubmit {
            if viewStore.loginButtonEnabled {
              viewStore.send(.loginBox(action: .loginPressed))
            }
          }
          .progressOverlay(type: .indeterminate(running: viewStore.showLoginActivityIndicator, title: nil))
        .ignoresSafeArea(.container, edges: .all)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.red)

  }
}

#if DEBUG
  struct LoginView_Previews: PreviewProvider {
    static let store = Store(
      initialState: .init(),
      reducer: loginReducer,
      environment: .mocked
    )

    static var previews: some View {
      LoginView(store: store)
    }
  }
#endif

