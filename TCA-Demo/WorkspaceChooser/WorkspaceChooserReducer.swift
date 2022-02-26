//
//  WorkspaceChooserReducer.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 24.02.22.
//

import ApiClient
import ComposableArchitecture
import Foundation

let workspaceChooserReducer = Reducer<WorkspaceChooserState, WorkspaceChooserAction, AppEnv>() { state, action, env in
  switch action {
  case .didAppear:
    guard !state.workspaces.isEmpty else { return .init(value: .nextPageRequested) }

  case .reloadPressed:
    state.workspaces = []
    state.workspacesLastFetchingPage = nil
    state.workspacesTotal = nil
    state.showInitialActivityIndicator = true
    return .init(value: .nextPageRequested)

  case .backButtonPressed:
    break  // handled by parent reducer

  case .nextPageRequested:
    let nextPageNum = state.workspacesLastFetchingPage?.advanced(by: 1) ?? 1
    state.workspacesLastFetchingPage = nextPageNum
    state.showReloadButton = false
    state.showInitialActivityIndicator = true

    return env
      .apiProvider
      .publisher(
        on: .index(
          .workspaces(accountId: "\(68)"),
          page: Page(num: nextPageNum, items: 20),
          sortedBy: [SortByField(name: "name", ascending: true)]
        ),
        decodeBodyTo: ApiCollectionResponse<WorkspaceResponse>.self
      )
      .receive(on: env.mainQueue)
      .catchToEffect()
      .map { WorkspaceChooserAction.receivedWorkspacesResponse($0) }

  case let .receivedWorkspacesResponse(.success(workspacesResponse)):
    state.showInitialActivityIndicator = false
    for workspace in workspacesResponse.data {
      state.workspaces.append(workspace)
    }
    state.workspacesTotal = workspacesResponse.meta!.totalCount

  case let .receivedWorkspacesResponse(.failure(apiError)):
    state.showInitialActivityIndicator = false
    state.showReloadButton = true

  case .workspaceSelected:
    break  // handled by parent reducer
  }
  return .none
}

