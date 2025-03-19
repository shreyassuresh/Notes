import SwiftUI
import CoreData
class CoreDataNotesViewModel: ObservableObject {
    @Published var notes: [Note] = []
    
    private let context = CoreDataStack.shared.context

    init() {
        fetchNotes()
    }

    func fetchNotes() {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            notes = try context.fetch(request)
        } catch {
            print("Error fetching notes: \(error)")
        }
    }

    func addNote(title: String, content: String) {
        let newNote = Note(context: context)
        newNote.title = title
        newNote.content = content
        saveContext()
        fetchNotes() // Reload notes after adding the new note
    }

    func updateNote(id: NSManagedObjectID, title: String, content: String) {
        if let noteToUpdate = context.object(with: id) as? Note {
            noteToUpdate.title = title
            noteToUpdate.content = content
            saveContext()
            fetchNotes() // Reload notes after updating
        }
    }

    func deleteNote(at offsets: IndexSet) {
        offsets.forEach { index in
            let noteToDelete = notes[index]
            context.delete(noteToDelete)
        }
        saveContext()
        fetchNotes()  // Reload notes after deletion
    }

    func deleteNote(id: NSManagedObjectID) {
        if let noteToDelete = context.object(with: id) as? Note {
            context.delete(noteToDelete)
            saveContext()
            fetchNotes()  // Reload notes after deletion
        }
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
