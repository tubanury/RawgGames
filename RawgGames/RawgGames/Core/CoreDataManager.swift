//
//  CoreDataManager.swift
//  RawgGames
//
//  Created by Tuba N. Yıldız on 10.12.2022.
//

import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private let managedContext: NSManagedObjectContext!
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func saveNote(title: String, text: String) -> Note?{
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        note.setValue(title, forKeyPath: "noteTitle")
        note.setValue(text, forKeyPath: "noteText")

        
        do {
            try managedContext.save()
            return note as? Note
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    func getNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        do {
            let notes = try managedContext.fetch(fetchRequest)
            return notes as! [Note]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    func deleteNote(note: Note) {
        managedContext.delete(note)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func updateNote(note: Note) -> Note {
        note.setValue(note.noteText, forKey: "noteText")
        note.setValue(note.noteTitle, forKey: "noteTitle")
        if note.hasChanges {
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            return note
        }
        return note
        
    }
    func fetchGames() -> [Game]{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
        do {
            let games = try managedContext.fetch(fetchRequest)
            return games as! [Game]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    func saveGame(img: Data){
        let entity = NSEntityDescription.entity(forEntityName: "Game", in: managedContext)!
        let game = NSManagedObject(entity: entity, insertInto: managedContext)
        game.setValue(img, forKey: "image")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func deleteGame(game: Game) {
        managedContext.delete(game)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
