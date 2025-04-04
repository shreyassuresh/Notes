import SwiftUI
import CoreData


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
            
           
            .navigationBarItems(
                                leading: HStack {
                                    // Logo on the left, bigger size
                                    Image("logo proto")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50) // Increased size of the logo
                                        .padding(.leading, 16)
                                    
                                    // Title on the left, bigger font size
                                    Text("Notes")
                                        .font(.system(size: 30, weight: .bold)) // Increased font size
                                        .foregroundColor(.primary)
                                },
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


// Create Note Page: Form for creating and saving notes
struct CreateNotePage: View {
    @ObservedObject var viewModel: CoreDataNotesViewModel
    @State private var title = ""
    @State private var content = ""
    @Environment(\.presentationMode) var presentationMode

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
                presentationMode.wrappedValue.dismiss() // Dismiss the view
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

struct EditNotePage: View {
    var note: Note
    @ObservedObject var viewModel: CoreDataNotesViewModel
    @State private var title = ""
    @State private var content = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Enter title", text: $title)
                    .onAppear {
                        title = note.title ?? ""
                    }
            }
            Section(header: Text("Content")) {
                TextEditor(text: $content)
                    .onAppear {
                        content = note.content ?? ""
                    }
            }
            Button(action: {
                viewModel.updateNote(id: note.objectID, title: title, content: content)
                presentationMode.wrappedValue.dismiss()
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
            Button(action: {
                viewModel.deleteNote(id: note.objectID)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Delete Note")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
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
