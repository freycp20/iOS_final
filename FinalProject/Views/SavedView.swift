//
//  SavedView.swift
//  FinalProject
//
//  Created by Caleb Frey on 11/7/22.
//

import SwiftUI

struct SavedView: View {
    @EnvironmentObject var VM : ViewModel
    var body: some View {
        NavigationView {
        VStack {
            List {
                ForEach(VM.saved_schools) { school in
                    ZStack {
                        NavigationLink(destination: DetailView(currentSchool: school)) { EmptyView() }.opacity(0.0)
                        
                        ListSchoolView(currentSchool: school, expanded: false) //This will be the view that you want to display to the user
                    }.listRowInsets(EdgeInsets())
                        .listRowSeparatorTint(.white)
//                    NavigationLink {
//                        Text("pass")
//                    } label: {
//                        ListSchoolView(currentSchool: school, expanded: false)
//
//                    }
                }.onDelete(perform: delete)
            }
            .listStyle(PlainListStyle())
        }.navigationTitle("Saved Schools")
        }
    }
    func delete(at offsets: IndexSet) {
        VM.saved_schools.remove(atOffsets: offsets)
        }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
    }
}
