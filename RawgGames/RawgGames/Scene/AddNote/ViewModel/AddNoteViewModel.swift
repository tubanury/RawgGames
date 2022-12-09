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
    func noteAdded()
    //func noteUpdated()
    //func noteDeleted()
}

final class AddNoteViewModel: AddNoteViewModelProtocol {
    
    weak var delegate: AddNoteViewModelDelegate?
    private var note: Note?
    
    func getNoteTitle() -> String {
        note?.noteTitle ?? ""
    }
    func getNoteText() -> String {
        note?.noteText ?? ""
    }
    
    
}
