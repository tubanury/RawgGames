//
//  GameListViewModelUnitTest.swift
//  RawgGamesTests
//
//  Created by Tuba N. Yıldız on 17.12.2022.
//

import XCTest

final class GameListViewModelUnitTest: XCTestCase {

    var viewModel: GameListViewModel!
    var fetchExpectetiton: XCTestExpectation!
    var sortExpectetion: XCTestExpectation!

    
    override func setUpWithError() throws {
        viewModel = GameListViewModel()
        viewModel.delegate = self
        fetchExpectetiton = expectation(description: "fetchGames")
        sortExpectetion = expectation(description: "sortGames")

        
    }
    override class func tearDown() {

    }
    
    func testGetGameCount() throws {
        //given
        XCTAssertEqual(viewModel.getGameCount(), 0)
        
        //when
        viewModel.fetchGames()
        waitForExpectations(timeout: 10)

        //then
        XCTAssertEqual(viewModel.getGameCount(), 20)
        
    }
    
    func testGetGameIndexZero(){
        XCTAssertNil(viewModel.getGame(at: 0))
        
        viewModel.fetchGames()
        waitForExpectations(timeout: 10)
        
        let gameAtZero = viewModel.getGame(at: 0)
        XCTAssertEqual(gameAtZero?.id, 3498)
        XCTAssertEqual(gameAtZero?.name, "Grand Theft Auto V")

    }
    
    func testSortGames(){
        
        viewModel.fetchGames()
        wait(for: [fetchExpectetiton], timeout: 10)

        viewModel.sortGames(by: 0)
       
        wait(for: [sortExpectetion], timeout: 10)

        XCTAssertEqual(viewModel.getGame(at: 0)?.id, 3328)
    }
    
}

extension GameListViewModelUnitTest: GameListViewModelDelegate {
    func gamesFailed() {}
    
    func gamesLoaded() {
        fetchExpectetiton.fulfill()

    }
    func gamesSorted() {
        sortExpectetion.fulfill()
    }
}
