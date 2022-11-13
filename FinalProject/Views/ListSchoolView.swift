//
//  SchoolCard.swift
//  FinalProject
//
//  Created by Caleb Frey on 11/8/22.
//

import SwiftUI

struct ListSchoolView: View {
    @EnvironmentObject var VM : ViewModel
    var currentSchool : School
    var index : Int
    var expanded: Bool
    var body: some View {
        VStack {
            HStack {
                Text(currentSchool.school_name)
                    .foregroundColor(.white)
                    .font(.title)
                    .bold()
                    .padding()
                Spacer()
                Button {
                    VM.saved_schools.remove(at: VM.saved_schools.firstIndex(where: {$0.school_name == currentSchool.school_name})!)
                    
                } label: {
                    Image(systemName: "trash")
                        .padding()
                        .foregroundColor(.white)
                }
            }.frame(height: 70)
            .background(
                Image(currentSchool.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .brightness(-0.2)
//                    .cornerRadius(CGFloat(VM.corner_radius))
            )
            
            .cornerRadius(10)
            
//            .padding()
//            ZStack(alignment:.topLeading) {
//                Color.clear
//                    .aspectRatio(contentMode: .fill)
//                    .overlay(
//                        Image(currentSchool.image)
//                            .resizable()
//                            .scaledToFill()
//                            .frame(height:50, width: 100)
//                        )
//                    .clipShape(Rectangle())
//                    .cornerRadius(15, corners: [.topLeft, .topRight])
//                    .frame(height: 80)
//
//
//            }
            if expanded {
                HStack {
                    Text("Average GPA: \(currentSchool.meta_data.average_gpa, specifier: "%.2f")")
                    Text("Average SAT: \(currentSchool.meta_data.average_sat)")
                }.padding(30)
            }
        }
//        .frame(height: 80)
        .background(RoundedRectangle(cornerRadius: CGFloat(VM.corner_radius)).fill(.white))
        .padding([.leading, .trailing], 15)
        .clipped()
        .shadow(color: Color.gray, radius: 5, x: 0, y: 0)
    }
}

//struct CustomFrameModifier : ViewModifier {
//    var active : Bool
//    
//    @ViewBuilder func body(content: Content) -> some View {
//        if active {
//            content
//        } else {
//            content.frame(height: 60)
//        }
//    }
//}
//struct SchoolCard_Previews: PreviewProvider {
//    static var previews: some View {
//        SchoolCard()
//    }
//}
