import SwiftUI

// Home Page: List of saved notes
struct HomePage: View {
    @StateObject var viewModel = CoreDataNotesViewModel() // Initializing the view model
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.notes, id: \.objectID) { note in
                    NavigationLink(destination: EditNotePage(note: note, viewModel: viewModel)) {
                        VStack(alignment: .leading) {
                            Text(note.title ?? "Untitled")
                                .font(.headline)
                            Text(note.content ?? "No content")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteNote)
            }
            .navigationTitle("Notes")
            .navigationBarItems(
                leading: CustomEditButton(isEditing: $isEditing),
                trailing: NavigationLink(destination: CreateNotePage(viewModel: viewModel)) {
                    Image(systemName: "plus")
                }
            )
        }
    }
    
    func deleteNote(at offsets: IndexSet) {
        viewModel.deleteNote(at: offsets)
    }
}

// Custom Edit Button
struct CustomEditButton: View {
    @Binding var isEditing: Bool

    var body: some View {
        Button(action: {
            isEditing.toggle()
        }) {
            Text(isEditing ? "Done" : "Edit")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 80, height: 40)
                .background(isEditing ? Color.green : Color.blue)
                .cornerRadius(10)
                .shadow(radius: 5)
        }
    }
}

// Create Note Page: Form for creating and saving notes
struct CreateNotePage: View {
    @ObservedObject var viewModel: CoreDataNotesViewModel
    @State private var title = ""
    @State private var content = ""

    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Enter title", text: $title)
            }
            Section(header: Text("Content")) {
                TextEditor(text: $content)
            }
            Button(action: {
                viewModel.addNote(title: title, content: content)
            }) {
                Text("Save Note")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
        .navigationTitle("Create Note")
    }
}

// Edit Note Page: Page to edit existing notes
struct EditNotePage: View {
    var note: Note
    @ObservedObject var viewModel: CoreDataNotesViewModel
    @State private var title = ""
    @State private var content = ""

    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Enter title", text: $title)
                    .onAppear {
                        title = note.title ?? "" // Default title if none exists
                    }
            }
            Section(header: Text("Content")) {
                TextEditor(text: $content)
                    .onAppear {
                        content = note.content ?? "" // Default content if none exists
                    }
            }
            Button(action: {
                viewModel.updateNote(id: note.objectID, title: title, content: content)
            }) {
                Text("Update Note")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
        .navigationTitle("Edit Note")
    }
}

// The main ContentView, initializing the HomePage
struct ContentView: View {
    var body: some View {
        HomePage(viewModel: CoreDataNotesViewModel()) // Make sure the HomePage has a view model
    }
}


#Preview {
    ContentView() // Ensure proper preview for ContentView
}
