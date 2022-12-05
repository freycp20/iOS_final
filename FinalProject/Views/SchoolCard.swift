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
                    .shadow(color: .gray, radius: 5, x: 0, y: 0)
                    .padding()
            }
            HStack(alignment:.top, spacing:0) {
                VStack(alignment:.leading, spacing: 0) {
                    Text("Average GPA")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 5)

                    Text("\(currentSchool.meta_data.average_gpa, specifier: "%.2f")")
                        .font(.caption)
                        .padding(.bottom, 20)
                }
                .frame(minWidth: 0, maxWidth: .infinity)

                Divider().frame(height: 60)
                VStack(alignment:.leading, spacing: 0) {
                    Text("Average SAT")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 5)

                    Text("\(currentSchool.meta_data.average_sat ?? 0)")
                        .font(.caption)
                        .padding(.bottom, 20)

                }
                .frame(minWidth: 0, maxWidth: .infinity)
//                .padding(.bottom, 20)
//                .background(.green)
//                .padding(10)
            }
//            .frame(minWidth: 0, maxWidth: .infinity)

        }
        .background(RoundedRectangle(cornerRadius: CGFloat(VM.corner_radius)).fill(.white))
        .clipped()
//        .modifier(CustomFrameModifier(active: expanded))
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
