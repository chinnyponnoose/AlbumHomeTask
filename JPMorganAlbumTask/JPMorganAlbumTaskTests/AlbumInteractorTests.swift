//
//  AlbumInteractorTests.swift
//  JPMorganAlbumTaskTests
//
//  Created by Chinny Ponnoose on 31/01/22.
//

import XCTest
@testable import JPMorganAlbumTask

class AlbumInteractorTests: XCTestCase {

    var interactor: AlbumInteractor!
    let albumClient = ClientMock()
    var datastore = AlbumDataStoreMock()
    var presenter = AlbumPresenterMock()

    override func setUp() {
        interactor = AlbumInteractor(client: albumClient)
        interactor.presenter = presenter
        interactor.dataStore = datastore
    }

    class ClientMock: AlbumClient {

        var result: Result<[AlbumModel], NetworkError>?
        override func getAlbumList(from endPoint: String,
                                   completion: @escaping (Result<[AlbumModel], NetworkError>) -> Void) {
            guard let result = result else {
                XCTFail("Didnot supply fake result in Fake  Client")
                return
            }
            completion(result)
        }
    }

    struct StubAlbumListResult {

        static let albums = [AlbumModel(id: 1, userId: 1, title: "A"),
                             AlbumModel(id: 2, userId: 1, title: "B"),
                             AlbumModel(id: 3, userId: 1, title: "C")]
        static let unsortedAlbums = [AlbumModel(id: 1, userId: 1, title: "C"),
                             AlbumModel(id: 2, userId: 1, title: "B"),
                             AlbumModel(id: 3, userId: 1, title: "A")]

        static let errorResult: Result<[AlbumModel], NetworkError>? = .failure(.badURL)
        static let successfulResult: Result<[AlbumModel], NetworkError>? = .success(albums)
        static let unsortedResult: Result<[AlbumModel], NetworkError>? = .success(unsortedAlbums)
    }

    override func tearDown() {
        interactor = nil
    }

    func testFetchDataWithResult() {
        loadAlbumListWithSuccess()
        XCTAssertEqual(presenter.albumAdded,
                       true)
    }

    func testFetchDataForSorting() {
        loadAlbumListWithUnsortedData()
        XCTAssertEqual(presenter.sorted,
                       true)
    }

    func testFetchDataWithNOResult() {
        loadAlbumListithError()
        XCTAssertEqual(datastore.albumAdded, true)
    }

    private func loadAlbumListWithUnsortedData() {
        albumClient.result = StubAlbumListResult.unsortedResult
        interactor.fetchAlbumList()
    }

    private func loadAlbumListWithSuccess() {
        albumClient.result = StubAlbumListResult.successfulResult
        interactor.fetchAlbumList()
    }

    private func loadAlbumListithError() {
        let feedErrorResult = StubAlbumListResult.errorResult
        albumClient.result = feedErrorResult
        interactor.fetchAlbumList()
    }
}

class AlbumPresenterMock: InteractorToPresenterProtocol {
    var shouldShowError = false
    var albumAdded = false
    var sorted = false

    func albumListFetched(list: [AlbumModel]) {
        if list.count > 0 {
            albumAdded = true
            if list[0].title == "A" {
                 sorted = true
            }
        }
    }

    func showErrorMessage(message: String, displayToast: Bool) {
        shouldShowError = true
    }
}

class AlbumDataStoreMock: InteractorToDataStoreProtocol {

    var albumAdded = false
    var newAlbumAdded = false

    func saveAlbums(_ albums: [AlbumModel]) {
        if albums.count > 0 {
            newAlbumAdded = true
        }
    }

    func retrieveAlbumData() -> [AlbumModel]? {
        albumAdded = true
        let albums = [AlbumModel(id: 1, userId: 1, title: "A"),
                             AlbumModel(id: 2, userId: 1, title: "B"),
                             AlbumModel(id: 3, userId: 1, title: "C")]
        return albums
    }
}
