//
//  ContentView.swift
//  FinalProject
//
//  Created by Caleb Frey on 11/7/22.
//

import SwiftUI

struct ContentView: View {

    init() {
        UITabBar.appearance().backgroundColor = UIColor(red: 246, green: 246, blue: 246, alpha: 1)

    }
    
    var body: some View {
        
        TabView {
//            ZStack {
//                Color.green
//                    .opacity(0.1)
//                    .ignoresSafeArea()
//            }
            ExploreView()
                .tabItem {
                    Image(systemName: "globe")
                    Text("Explore")
                }
            SavedView().tabItem {
                Image(systemName: "bookmark")
                Text("Saved")
            }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
        }.background(.gray)
//        SettingsView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
