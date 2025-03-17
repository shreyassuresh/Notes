//
//  ContentView.swift
//  Notes
//
//  Created by Shreyas on 17/03/25.
//


//import SwiftUI
//
//// Model to represent a Note
//struct Note: Identifiable {
//    let id = UUID()
//    var title: String
//    var content: String
//}
//
//// ViewModel to manage notes
//class NotesViewModel: ObservableObject {
//    @Published var notes: [Note] = []
//
//    func addNote(title: String, content: String) {
//        let newNote = Note(title: title, content: content)
//        notes.append(newNote)
//    }
//
//    func updateNote(id: UUID, title: String, content: String) {
//        if let index = notes.firstIndex(where: { $0.id == id }) {
//            notes[index].title = title
//            notes[index].content = content
//        }
//    }
//
//    func deleteNotes(at offsets: IndexSet) {
//        notes.remove(atOffsets: offsets)
//    }
//
//    func moveNotes(from source: IndexSet, to destination: Int) {
//        notes.move(fromOffsets: source, toOffset: destination)
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        HomePage(viewModel: NotesViewModel())
//    }
//}
//
//// Custom Edit Button
//struct CustomEditButton: View {
//    @Binding var isEditing: Bool
//
//    var body: some View {
//        Button(action: {
//            isEditing.toggle()
//        }) {
//            Text(isEditing ? "Done" : "Edit")
//                .font(.headline)
//                .foregroundColor(.white)
//                .padding()
//                .frame(width: 80, height: 40)
//                .background(isEditing ? Color.green : Color.blue)
//                .cornerRadius(10)
//                .shadow(radius: 5)
//        }
//    }
//}
//
//// Home Page: List of saved notes
//struct HomePage: View {
//    @ObservedObject var viewModel: NotesViewModel
//    @State private var isEditing = false
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(viewModel.notes) { note in
//                    NavigationLink(destination: EditNotePage(note: note, viewModel: viewModel)) {
//                        VStack(alignment: .leading) {
//                            Text(note.title)
//                                .font(.headline)
//                            Text(note.content)
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
//                    }
//                }
//                .onDelete(perform: viewModel.deleteNotes) // Enable swipe-to-delete
//                .onMove(perform: viewModel.moveNotes) // Enable reordering
//            }
//            .navigationTitle("Notes")
//            .navigationBarItems(
//                leading: CustomEditButton(isEditing: $isEditing), // Custom edit button
//                trailing: NavigationLink(destination: CreateNotePage(viewModel: viewModel)) {
//                    Image(systemName: "plus")
//                }
//            )
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//    }
//}
//
//// Create Note Page: Form for creating and saving notes
//struct CreateNotePage: View {
//    @ObservedObject var viewModel: NotesViewModel
//    @State private var title = ""
//    @State private var content = ""
//    @State private var isTapped = false
//    @Environment(\.presentationMode) var presentationMode
//
//    var body: some View {
//        Form {
//            Section(header: Text("Title")) {
//                TextField("Enter title", text: $title)
//            }
//            Section(header: Text("Content")) {
//                TextEditor(text: $content)
//            }
//            Button(action: {
//                withAnimation(.easeInOut(duration: 0.1)) {
//                    // Toggle button color change on tap
//                    isTapped.toggle()
//                }
//                viewModel.addNote(title: title, content: content)
//                presentationMode.wrappedValue.dismiss()
//            }) {
//                Text("Save Note")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(isTapped ? Color.blue : Color.primary) // Change color on tap
//                    .cornerRadius(10)
//                    .shadow(radius: 5)
//            }
//        }
//        .navigationTitle("Create Note")
//    }
//}
//
//// Edit Note Page: Page to edit existing notes
//struct EditNotePage: View {
//    var note: Note
//    @ObservedObject var viewModel: NotesViewModel
//    @State private var title = ""
//    @State private var content = ""
//    @State private var isTapped = false // Declare isTapped here as well
//    @Environment(\.presentationMode) var presentationMode
//
//    var body: some View {
//        Form {
//            Section(header: Text("Title")) {
//                TextField("Enter title", text: $title)
//                    .onAppear {
//                        title = note.title
//                    }
//            }
//            Section(header: Text("Content")) {
//                TextEditor(text: $content)
//                    .onAppear {
//                        content = note.content
//                    }
//            }
//            Button(action: {
//                withAnimation(.easeInOut(duration: 0.1)) {
//                    // Toggle button color change on tap
//                    isTapped.toggle()
//                }
//                viewModel.updateNote(id: note.id, title: title, content: content)
//                presentationMode.wrappedValue.dismiss()
//            }) {
//                Text("Update Note")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(isTapped ? Color.blue : Color.primary) // Change color on tap
//                    .cornerRadius(10)
//                    .shadow(radius: 5)
//            }
//        }
//        .navigationTitle("Edit Note")
//    }
//}
//
//#Preview {
//    ContentView()
//}

import SwiftUI

struct Note: Identifiable {
    let id = UUID()
    var title: String
    var content: String
}


class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []
    
    func addNote(title: String, content: String) {
        let newNote = Note(title: title, content: content)
        notes.append(newNote)
    }
    
    func updateNote(id: UUID, title: String, content: String) {
        if let index = notes.firstIndex(where: { $0.id == id }) {
            notes[index].title = title
            notes[index].content = content
        }
    }
    
    func deleteNotes(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }
    
    func moveNotes(from source: IndexSet, to destination: Int) {
        notes.move(fromOffsets: source, toOffset: destination)
    }
}

struct ContentView: View {
    var body: some View {
        HomePage(viewModel: NotesViewModel())
    }
}


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
// Home Page: List of saved notes
struct HomePage: View {
    @ObservedObject var viewModel: NotesViewModel
    @State private var isEditing = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.notes) { note in
                    NavigationLink(destination: EditNotePage(note: note, viewModel: viewModel)) {
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.headline)
                            Text(note.content)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteNote)
                .onMove(perform: viewModel.moveNotes)
            }
            .navigationTitle("Notes")
            .navigationBarItems(
                leading: CustomEditButton(isEditing: $isEditing),
                trailing: NavigationLink(destination: CreateNotePage(viewModel: viewModel)) {
                    Image(systemName: "plus")
                }
            )
            .toolbar {
               
                EditButton()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

   
    func deleteNote(at offsets: IndexSet) {
        viewModel.deleteNotes(at: offsets)
    }
}


struct CreateNotePage: View {
    @ObservedObject var viewModel: NotesViewModel
    @State private var title = ""
    @State private var content = ""
    @State private var isTapped = false
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
                withAnimation(.easeInOut(duration: 0.1)) {
                   
                    isTapped.toggle()
                }
                viewModel.addNote(title: title, content: content)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save Note")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isTapped ? Color.blue : Color.primary)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
        .navigationTitle("Create Note")
    }
}

struct EditNotePage: View {
    var note: Note
    @ObservedObject var viewModel: NotesViewModel
    @State private var title = ""
    @State private var content = ""
    @State private var isTapped = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Enter title", text: $title)
                    .onAppear {
                        title = note.title
                    }
            }
            Section(header: Text("Content")) {
                TextEditor(text: $content)
                    .onAppear {
                        content = note.content
                    }
            }
            Button(action: {
                withAnimation(.easeInOut(duration: 0.1)) {
                  
                    isTapped.toggle()
                }
                viewModel.updateNote(id: note.id, title: title, content: content)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Update Note")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isTapped ? Color.blue : Color.primary) // Change color on tap
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
        .navigationTitle("Edit Note")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
