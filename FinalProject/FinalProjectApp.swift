//
//  FinalProjectApp.swift
//  FinalProject
//
//  Created by Caleb Frey on 11/7/22.
//

import SwiftUI

@main
struct FinalProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewModel())
        }
    }
}
