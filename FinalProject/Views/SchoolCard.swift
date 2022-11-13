//
//  SchoolCard.swift
//  FinalProject
//
//  Created by Caleb Frey on 11/8/22.
//

import SwiftUI

struct SchoolCard: View {
    @EnvironmentObject var VM : ViewModel
    var currentSchool : School
    var expanded: Bool
    var body: some View {
        VStack {
            ZStack(alignment:.topLeading) {
                Color.clear
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(
                        Image(currentSchool.image)
                            .resizable()
                            .scaledToFill()
                        )
                    .clipShape(Rectangle())
                    .cornerRadius(15, corners: [.topLeft, .topRight])
                Text(currentSchool.school_name)
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
                    .padding()
            }
            if expanded {
                HStack {
                    Text("Average GPA: \(currentSchool.meta_data.average_gpa, specifier: "%.2f")")
                    Text("Average SAT: \(currentSchool.meta_data.average_sat)")
                }.padding(30)
            }
        }
        .background(RoundedRectangle(cornerRadius: CGFloat(VM.corner_radius)).fill(.white))
        .clipped()
        .modifier(CustomFrameModifier(active: expanded))
        .shadow(color: Color.gray, radius: CGFloat(VM.corner_radius), x: 0, y: 0)
    }
}

struct CustomFrameModifier : ViewModifier {
    var active : Bool
    
    @ViewBuilder func body(content: Content) -> some View {
        if active {
            content
        } else {
            content.frame(height: 60)
        }
    }
}
//struct SchoolCard_Previews: PreviewProvider {
//    static var previews: some View {
//        SchoolCard()
//    }
//}
