//
//  CardView.swift
//  FinalProject
//
//  Created by Caleb Frey on 11/14/22.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var VM : ViewModel
    @State private var offset = CGSize.zero
    @State private var color : Color = .black
    
    var currentSchool : School
    var height : CGFloat
    @Binding var changing : Bool
    var body: some View {
        ZStack {
        VStack(spacing:0) {
            ZStack(alignment: .topLeading) {
                VStack(alignment:.leading) {
                    
                    Text(currentSchool.school_name)
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
                    .shadow(color: .gray, radius: 5, x: 0, y: 0)
                    .padding()
                    .multilineTextAlignment(.leading)
                }.frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading
                  )
                
            }
            .frame(height: height)
            .background(
                Image(currentSchool.image)
                .resizable()
                .scaledToFill())
            HStack(spacing:0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Average GPA")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 5)
                        .multilineTextAlignment(.leading)
                    Text("\(currentSchool.meta_data.average_gpa, specifier: "%.2f") ")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                }.frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    alignment: .topLeading
                  )
                .padding(15)
                Divider().padding([.top, .bottom], 5)
                VStack(alignment: .leading, spacing: 0) {
                    Text("Average SAT")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 5)
                        .multilineTextAlignment(.leading)
                    Text("\(currentSchool.meta_data.average_sat)")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                }.frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    alignment: .topLeading
                  )
                .padding(15)
            }.background(.white)
            .fixedSize(horizontal: false, vertical: true)
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.3), lineWidth: 1)
        )}
        .cornerRadius(10)
        .shadow(color: .gray, radius: 10, x: 0, y: 0)
        .padding([.top, .horizontal])
        .offset(x: offset.width, y: offset.height*0.4)
        .foregroundColor(color.opacity(0.9))
        .rotationEffect(.degrees(Double(offset.width/40)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    withAnimation {
                        changeColor(width: offset.width)
                    }
                } .onEnded{ _ in
                    withAnimation {
                        swipeCard(width: offset.width)
                    }
                }
        )
    }
    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
            
        case 150...500:
            offset = CGSize(width: 500, height: 0)
        default:
            offset = .zero
        
        }
    }
    func changeColor(width: CGFloat) {
        switch width {
        case -500...(-150):
//            offset = CGSize(width: -500, height: 0)
            color = .red
        case 150...500:
            color = .green
        default:
            color = .black
        
        }
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
