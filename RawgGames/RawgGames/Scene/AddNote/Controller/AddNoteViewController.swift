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
    
    var viewModel = AddNoteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        viewModel.delegate = self
        configureView()
    }
    
    @IBAction func didSaveButtonTapped(_ sender: Any) {
        if let note = viewModel.note{
            note.noteText = self.noteText.text
            note.noteTitle = self.noteTitle.text
            viewModel.delegateNoteList?.noteUpdated(note: note)
        }
        else {
            viewModel.delegateNoteList?.noteAdded(title: self.noteTitle.text ?? "", text: self.noteText.text ?? "")
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    func configureView(){
        noteTitle.text = viewModel.getNoteTitle()
        noteText.text = viewModel.getNoteText()
    }
    
    
}
extension AddNoteViewController: AddNoteViewModelDelegate {
    func noteInformationsLoaded() {
    }
}


