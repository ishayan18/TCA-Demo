//
//  WorkspaceSelectorStore.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 24.02.22.
//

import ApiClient
import ComposableArchitecture
import Foundation
import Microya

struct WorkspaceChooserState: Equatable {
  var workspaces: IdentifiedArrayOf<Resource<WorkspaceResponse>> = []

  var showInitialActivityIndicator: Bool = false
  var showReloadButton: Bool = false

  var workspacesLastFetchingPage: Int?
  var workspacesTotal: Int?
  var selectedWorkspaceName: String?

  var hasMoreWorkspaces: Bool {
    guard let workspacesTotal = workspacesTotal else { return false }
    return workspacesTotal > workspaces.count
  }
}

enum WorkspaceChooserAction: Equatable {
  case didAppear
  case reloadPressed
  case backButtonPressed
  case workspaceSelected(id: String, name: String)
  case nextPageRequested
  case receivedWorkspacesResponse(Result<ApiCollectionResponse<WorkspaceResponse>, ApiError<PapershiftError>>)
}

