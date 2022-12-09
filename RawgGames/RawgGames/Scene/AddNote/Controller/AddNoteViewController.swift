//
//  AddNoteViewController.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 10.12.2022.
//

import UIKit

class AddNoteViewController: UIViewController {

    @IBOutlet weak var noteTitle: UITextField!
    
    @IBOutlet weak var noteText: UITextView!
    
    var note: Note?
    var viewModel = AddNoteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewModel.delegate = self
        if note != nil {
            noteTitle.text = viewModel.getNoteTitle()
            noteText.text = viewModel.getNoteText()
        }
        else {

        }
        
    }
    @IBAction func didSaveButtonTapped(_ sender: Any) {
        //todo
    }
   
    
}


