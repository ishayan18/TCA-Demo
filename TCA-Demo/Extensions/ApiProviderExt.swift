//
//  ApiProviderExt.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 25.02.22.
//

import ApiClient
import Combine
import Foundation
import Microya

extension ApiProvider {
  #if DEBUG
    static var mocked: ApiProvider<PapershiftEndpoint> {
      ApiProvider<PapershiftEndpoint>(baseUrl: URL(string: "https://papershift-web.herokuapp.com/api/v3")!)
    }
  #endif
}

extension ApiProvider where EndpointType == PapershiftEndpoint {
  /// Fetches all resource of the given index endpoint, paginates through them if needed and returns the full list.
  func fullyPaginatedIndexPublisher<ResultType: Decodable>(
    _ indexEndpoint: EndpointType.IndexEndpoint,
    filters: [QueryFilter] = [],
    sortedBy: [SortByField] = [],
    includes: [String] = []
  ) -> AnyPublisher<[Resource<ResultType>], ApiError<EndpointType.ClientErrorType>> {
    // implementation inspired by: https://www.donnywals.com/recursively-execute-a-paginated-network-call-with-combine/
    let pageNumPublisher = CurrentValueSubject<Int, Never>(1)
    return
      pageNumPublisher
      .flatMap { pageNum in
        self.publisher(
          on: .index(indexEndpoint, page: Page(num: pageNum), filters: filters, sortedBy: sortedBy, includes: includes),
          decodeBodyTo: ApiCollectionResponse<ResultType>.self
        )
      }
      .handleEvents(
        receiveOutput: { (apiResponse: ApiCollectionResponse<ResultType>) in
          if apiResponse.meta!.totalPages > apiResponse.meta!.currentPage {
            pageNumPublisher.send(apiResponse.meta!.currentPage + 1)
          }
          else {
            pageNumPublisher.send(completion: .finished)
          }
        }
      )
      .reduce([Resource<ResultType>]()) { allResources, apiResponse in
        return allResources + apiResponse.data
      }
      .eraseToAnyPublisher()
  }
}

