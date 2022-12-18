//
//  AddNoteViewController.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 10.12.2022.
//

import UIKit

class AddNoteViewController: BaseViewController {
    
    @IBOutlet weak var noteTitle: UITextField!
    
    @IBOutlet weak var noteText: UITextView!
    
    var viewModel = AddNoteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        configureView()
    }
    
    @IBAction func didSaveButtonTapped(_ sender: Any) {
        if self.noteText.text == "" || self.noteTitle.text == "" {
            presentAlert(title: Localizables.warning.value, message: Localizables.emptyNoteMessage.value)
            return
        }
        if let note = viewModel.note{
            note.noteText = self.noteText.text
            note.noteTitle = self.noteTitle.text
            viewModel.delegateNoteList?.noteUpdated(note: note)
        }
        else {
            viewModel.delegateNoteList?.noteAdded(title: self.noteTitle.text!, text: self.noteText.text)
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func configureView(){
        noteText.becomeFirstResponder()
        noteTitle.text = viewModel.getNoteTitle()
        noteText.text = viewModel.getNoteText()
    }
    
    
}


