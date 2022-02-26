import SwiftUI
import SFSafeSymbols

public struct LoginBoxView: View {
  public var state: LoginBoxState
  public var actionHandler: (LoginBoxAction) -> Void
  @FocusState private var focus: FocusableField?

  public init(
    state: LoginBoxState,
    actionHandler: @escaping (LoginBoxAction) -> Void
  ) {
    self.state = state
    self.actionHandler = actionHandler
  }

  public var body: some View {
    VStack(spacing: Spacing.extraLarge) {
      Text("TCA Demo App")
        .foregroundColor(Color.white)
        .fontWeight(.heavy)
        .font(.system(size: 30))

      VStack(spacing: Margin.component) {
        TextField("email", text: state.email)
          .focused($focus, equals: .email)
          .padding(
            EdgeInsets(top: Padding.normal, leading: Padding.large, bottom: Padding.normal, trailing: Padding.large)
          )
          .background(
            RoundedRectangle(cornerRadius: 100)
              .stroke(Color.white, lineWidth: 2)

          )
          .onSubmit {
            validateViewsInput(state: state)
          }

        HStack {
          if state.showPassword {
            TextField("password", text: state.password)
              .focused($focus, equals: .password)
              .padding(
                EdgeInsets(top: Padding.normal, leading: Padding.large, bottom: Padding.normal, trailing: Padding.large)
              )
          }
          else {
            SecureField("password", text: state.password)
              .focused($focus, equals: .password)
              .padding(
                EdgeInsets(top: Padding.normal, leading: Padding.large, bottom: Padding.normal, trailing: Padding.large)
              )
          }

          Button(action: forward(LoginBoxAction.togglePasswordAppearanceIconPressed, to: actionHandler)) {
            Image(systemSymbol: state.showPassword ? .eyeSlashFill : .eyeFill)
              .padding(.trailing, Padding.normal)
          }
        }
        .onSubmit {
          validateViewsInput(state: state)
        }
        .background(
          RoundedRectangle(cornerRadius: 100)
          .stroke(Color.white, lineWidth: 2)
        )

        Button("Login", action: forward(.loginPressed, to: actionHandler))
          .opacity(state.loginButtonEnabled ? 1 : 0.5)
          .disabled(!state.loginButtonEnabled)
          .foregroundColor(Color.white)
          .frame(width: 150, height: 50)
          .background(
            RoundedRectangle(cornerRadius: 25)
            .stroke(Color.white, lineWidth: 2)
          )
      }
    }
    .padding()
  }

  private func validateViewsInput(state: LoginBoxState) {
    if state.email.wrappedValue.isEmpty {
      focus = .email
    }
    else if state.password.wrappedValue.isEmpty {
      focus = .password
    }
    else {
      focus = nil
    }
  }
}

#if DEBUG
  struct LoginBoxView_Previews: PreviewProvider {
    static let state = LoginBoxState(
      email: .constant("harry@hogwarts.co.uk"),
      password: .constant("password"),
      showPassword: false,
      loginButtonEnabled: true
    )

    static var previews: some View {
      LoginBoxView(state: state, actionHandler: { _ in })
        .frame(width: 326)
    }
  }
#endif
