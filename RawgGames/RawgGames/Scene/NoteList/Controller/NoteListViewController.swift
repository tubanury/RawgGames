//
//  NoteListViewController.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 9.12.2022.
//

import UIKit

class NoteListViewController: UIViewController {
   

    @IBOutlet weak var noteListTableView: UITableView!{
        didSet {
            noteListTableView.delegate = self
            noteListTableView.dataSource = self
        }
    }
    
    private var viewModel = NoteListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addBarButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toAddEdit", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "toAddEdit" {
            let destination = segue.destination as! AddNoteViewController
            destination.viewModel.delegate = self
            if sender != nil {
                destination.note = sender as? Note
            }
        }
    }

}

extension NoteListViewController: AddNoteViewModelDelegate {
    func noteAdded() {
        //todo
    }
}

extension NoteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNoteCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as? NoteListTableViewCell,
              let note = viewModel.getNote(at: indexPath.row) else {return UITableViewCell()}
        cell.configureCell(note: note)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toAddEdit", sender: viewModel.getNote(at: indexPath.row))
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
