//
//  NotesApp.swift
//  Notes
//
//  Created by Teacher on 17/03/25.
//

import SwiftUI
import CoreData


@main
struct NotesApp: App {
    let persistenceController = PersistenceController.shared

        var body: some Scene {
            WindowGroup {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}
