//
//  NoteListTableViewCell.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 9.12.2022.
//

import UIKit

class NoteListTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var noteTitle: UILabel!
    @IBOutlet private weak var noteText: UILabel!

    func configureCell(note: Note){
        noteTitle.text = note.noteTitle
        noteText.text = note.noteText
    }
    
   
   
}
