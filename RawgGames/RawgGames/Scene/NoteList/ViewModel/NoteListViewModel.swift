//
//  NoteListViewModel.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 9.12.2022.
//

import Foundation

protocol NoteListViewModelProtocol {
    var delegate: NoteListViewModelDelegate? {get set}
    func getNotes()
    func getNote(at index: Int) -> Note?
    func getNoteCount() -> Int
    func appendNote(title: String, text: String)
    func updateNote(note: Note)
    func deleteNote(at index: Int)
}

protocol NoteListViewModelDelegate: AnyObject {
    func notesChanged()
    func noteAdded(title: String, text: String)
    func noteUpdated(note: Note)
}

class NoteListViewModel: NoteListViewModelProtocol {
   
    weak var delegate: NoteListViewModelDelegate?
    
    private var notes: [Note]?
    
    func getNotes() {
        self.notes = CoreDataManager.shared.getNotes()
        self.delegate?.notesChanged()
    }
    func getNote(at index: Int) -> Note? {
       notes?[index]
    }
    func getNoteCount() -> Int {
        notes?.count ?? 0
    }
    func appendNote(title: String, text: String) {
        guard let note = CoreDataManager.shared.saveNote(title: title, text: text) else {return}
        notes?.append(note)
        self.delegate?.notesChanged()
    }
    func updateNote(note: Note) {
        CoreDataManager.shared.updateNote(note: note)
        self.delegate?.notesChanged()
    }
    
    func deleteNote(at index: Int) {
        guard let note = self.getNote(at: index) else {return}
        CoreDataManager.shared.deleteNote(note: note)
        notes?.remove(at: index)
    }
}
