//
//  AddNoteViewModel.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 10.12.2022.
//

import Foundation

protocol AddNoteViewModelProtocol {
    var delegate: AddNoteViewModelDelegate? {get set}
    func getNoteTitle() -> String
    func getNoteText() -> String
    
}

protocol AddNoteViewModelDelegate: AnyObject {
    func noteInformationsLoaded()
}

final class AddNoteViewModel: AddNoteViewModelProtocol {
    
    weak var delegate: AddNoteViewModelDelegate?
    weak var delegateNoteList: NoteListViewModelDelegate?
    
    var note: Note?
    
    /*func setNote(note: Note){
        self.note = note
        self.delegate?.noteInformationsLoaded()
    }*/
    
    func getNoteTitle() -> String {
        note?.noteTitle ?? ""
    }
    func getNoteText() -> String {
        note?.noteText ?? ""
    }
    
    
}
