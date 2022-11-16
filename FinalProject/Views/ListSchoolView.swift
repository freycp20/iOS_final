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
                
            }.frame(height: 70)
            .background(
                Image(currentSchool.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .brightness(-0.2)
//                    .cornerRadius(CGFloat(VM.corner_radius))
            )
            
//            .cornerRadius(10)
            

//            }
        }
//        .frame(height: 80)
        .background(RoundedRectangle(cornerRadius: CGFloat(VM.corner_radius)).fill(.white))
        .clipped()
        .shadow(color: Color.gray, radius: 5, x: 0, y: 0)
//        .padding([.leading, .trailing], 15)
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
