//
//  NotesCoreDataUnitTest.swift
//  RawgGamesTests
//
//  Created by Tuba N. Yıldız on 18.12.2022.
//

import XCTest

final class NotesCoreDataUnitTest: XCTestCase {
    var viewModel: NoteListViewModel!
    var addExpectation: XCTestExpectation!
    
    override func setUpWithError() throws {
        viewModel = NoteListViewModel()
        viewModel.delegate = self

        addExpectation = expectation(description: "addExpectation")
    }
   
    func testNoteCount() {
        //viewModel.appendNote(title: "test", text: "unit test")
        //waitForExpectations(timeout: 10)
        //XCTAssertEqual(viewModel.getNoteCount(), 1)
    }

}

extension NotesCoreDataUnitTest: NoteListViewModelDelegate {
    func notesChanged() {
    }
    
    func noteAdded(title: String, text: String) {
        addExpectation.fulfill()
    }
    
    func noteUpdated(note: Note) {
        
    }
    
    
}


