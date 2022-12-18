//
//  AddNoteViewModel.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 10.12.2022.
//

import Foundation

protocol AddNoteViewModelProtocol {
    func getNoteTitle() -> String?
    func getNoteText() -> String?
    
}

final class AddNoteViewModel: AddNoteViewModelProtocol {
    
    weak var delegateNoteList: NoteListViewModelDelegate?
    
    var note: Note?
    
    func getNoteTitle() -> String? {
        note?.noteTitle
    }
    func getNoteText() -> String? {
        note?.noteText
    }
    
    
}
