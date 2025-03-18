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

        func deleteNote(id: NSManagedObjectID) {
            // Logic to delete the note with the given objectID
            // This might involve fetching the note by ID and then deleting it
        }
    

    func addNote(title: String, content: String) {
        let newNote = Note(context: context)
        newNote.title = title
        newNote.content = content
        saveContext()
    }

    func updateNote(id: NSManagedObjectID, title: String, content: String) {
        if let noteToUpdate = context.object(with: id) as? Note {
            noteToUpdate.title = title
            noteToUpdate.content = content
            saveContext()
        }
    }

    func deleteNote(at offsets: IndexSet) {
        offsets.forEach { index in
            let noteToDelete = notes[index]
            context.delete(noteToDelete)
        }
        saveContext()
    }

    private func saveContext() {
        do {
            try context.save()
            fetchNotes()  // Reload the notes after saving
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
