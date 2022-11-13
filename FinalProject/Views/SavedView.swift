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
        VStack {
            ScrollView {
                ForEach(0..<VM.saved_schools.count, id: \.self) { idx in
                    let school = VM.saved_schools[idx]
                    ListSchoolView(currentSchool: school, index: idx,  expanded: false)
                }
            }
        }
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
    }
}
