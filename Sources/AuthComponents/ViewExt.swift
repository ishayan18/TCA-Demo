import SwiftUI

extension View {
  /// Calls the `actionHandler` with the given `action` case. Main purpose is to make the code more readable.
  func forward<ActionType>(_ action: ActionType, to actionHandler: @escaping (ActionType) -> Void) -> (() -> Void) {
    { actionHandler(action) }
  }

}
