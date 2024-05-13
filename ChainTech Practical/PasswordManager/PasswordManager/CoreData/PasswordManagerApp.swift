//
//  PasswordManagerApp.swift
//  PasswordManager
//
//  Created by Darshan Dangar on 13/05/24.
//

import SwiftUI

@main
struct PasswordManagerApp: App {
    @StateObject private var manager: PasswordManager = PasswordManager()
    
    var body: some Scene {
        WindowGroup {
            HomeVC()
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
        }
    }
}
