//
//  WorkspaceSelectorView.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 24.02.22.
//

import ComposableArchitecture
import SFSafeSymbols
import SwiftUI

struct WorkspaceChooserView: View {
  let store: Store<WorkspaceChooserState, WorkspaceChooserAction>

  var body: some View {
    WithViewStore(store) { viewStore in
      NavigationView {
        VStack {
          if !viewStore.workspaces.isEmpty {
            List {
              ForEach(viewStore.workspaces, id: \.id) { workspace in
                Button(action: {
                  viewStore.send(.workspaceSelected(id: workspace.id, name: workspace.attributes.name))
                }) {
                  HStack {
                    Text(workspace.attributes.name)

                    Spacer()

                    if workspace.attributes.name == viewStore.state.selectedWorkspaceName {
                      Image(systemSymbol: .checkmark).foregroundColor(.accentColor)
                    }
                  }
                }
              }

              // this should cause pagination calls to automatically be triggered when user scrolls to end of list
              if viewStore.hasMoreWorkspaces {
                ProgressView()
                  .onAppear {
                    viewStore.send(.nextPageRequested)
                  }
              }
            }
            .listStyle(InsetGroupedListStyle())
          }

          if viewStore.showReloadButton {
            Button(action: { viewStore.send(.reloadPressed) }) {
              Label("Reload", systemSymbol: .arrowClockwise)
            }
          }
        }
        .navigationTitle("Workspace Chooser")
        .progressOverlay(type: .indeterminate(running: viewStore.showInitialActivityIndicator, title: nil))
      }
      .navigationBarBackButtonHidden(true)
      .navigationViewStyle(StackNavigationViewStyle())
      .onAppear {
        viewStore.send(.didAppear)
      }
    }
  }
}

#if DEBUG
struct WorkspaceChooserView_Previews: PreviewProvider {
  static let store = Store(
    initialState: .init(),
    reducer: workspaceChooserReducer,
    environment: .mocked
  )

  static var previews: some View {
    WorkspaceChooserView(store: store)
  }
}
#endif


