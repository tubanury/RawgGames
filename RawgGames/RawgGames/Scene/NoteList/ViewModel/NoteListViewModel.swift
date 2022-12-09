//
//  NoteListViewModel.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 9.12.2022.
//

import Foundation

protocol NoteListViewModelProtocol {
    var delegate: NoteListViewModelDelegate? {get set}
    func getNoteCount() -> Int
}

protocol NoteListViewModelDelegate: AnyObject {
    func notesLoaded()
}

class NoteListViewModel: NoteListViewModelProtocol {
    
    weak var delegate: NoteListViewModelDelegate?
    private var notes: [Note]?
    
    func getNotes() -> [Note]? {
        self.notes
    }
    func getNote(at index: Int) -> Note? {
       notes?[index]
    }
    func getNoteCount() -> Int {
        notes?.count ?? 0
    }
   
}
