//
//  GameDetailViewModel.swift
//  RawgGamesTests
//
//  Created by Tuba N. Yıldız on 17.12.2022.
//

import XCTest

final class GameDetailViewModelUnitTest: XCTestCase {
    var viewModel: GameDetailViewModel!
    var fetchExpectation: XCTestExpectation!
    
    
    override func setUpWithError() throws {
        viewModel = GameDetailViewModel()
        viewModel.delegate = self
        fetchExpectation = expectation(description: "fetchGameDetail")
    }
    
    func testGetGameName() throws {
        XCTAssertEqual(viewModel.getGameName(), "")
        
        //When
        viewModel.fetchGameDetail(id: 3498)
        waitForExpectations(timeout: 10)
        
        //Then
        XCTAssertEqual(viewModel.getGameName(), "Grand Theft Auto V")
    }
    
    func testGetGameReleaseYear() throws {
        XCTAssertEqual(viewModel.getGameReleaseYear(), "Unknown")
        viewModel.fetchGameDetail(id: 3498)
        waitForExpectations(timeout: 10)
        XCTAssertEqual(viewModel.getGameReleaseYear(), "2013")
    }
    func testGetGameImageURL() throws {
        
        XCTAssertEqual(viewModel.getGameImageURL(), URL(string: ""))
        viewModel.fetchGameDetail(id: 3498)
        waitForExpectations(timeout: 10)
        XCTAssertEqual(viewModel.getGameImageURL(), URL(string: "https://media.rawg.io/media/screenshots/5f5/5f5a38a222252d996b18962806eed707.jpg"))
    }
    func testGetGameIconImageUrl() throws {
        XCTAssertEqual(viewModel.getGameIconImageUrl(), URL(string: ""))
        viewModel.fetchGameDetail(id: 3498)
        waitForExpectations(timeout: 10)
        XCTAssertEqual(viewModel.getGameIconImageUrl(), URL(string: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg"))
    }
    func testGetGameRating() throws {
        XCTAssertEqual(viewModel.getGameRating(), 0)
        viewModel.fetchGameDetail(id: 3498)
        waitForExpectations(timeout: 10)
        XCTAssertEqual(viewModel.getGameRating(), 4.47)
    }
   
}

extension GameDetailViewModelUnitTest: GameDetailViewModelDelegate {
    func gameLoaded() {
        fetchExpectation.fulfill()
    }
    
    func similarGamesLoaded() {}
    
}
