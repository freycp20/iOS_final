//
//  ContentView.swift
//  FinalProject
//
//  Created by Caleb Frey on 11/7/22.
//

import SwiftUI

struct ContentView: View {
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
