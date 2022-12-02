//
//  CardView.swift
//  FinalProject
//
//  Created by Caleb Frey on 11/14/22.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var VM : ViewModel
    var currentSchool : School
    var height : CGFloat
//    @Binding var changing : Bool
    var profile : Bool = false
    
    @ViewBuilder
    var bottomContent : some View {
        if (profile) {
            EmptyView()
        } else {
            metrics
        }
    }
    
    @ViewBuilder
    var topContent : some View {
        if (profile) {
            Spacer()
            Text(currentSchool.school_name)
                .foregroundColor(.white)
                .font(.largeTitle)
                .bold()
                .shadow(color: .black, radius: 5, x: 0, y: 0)
                .padding()
                .multilineTextAlignment(.leading)
        } else {
            Text(currentSchool.school_name)
                .foregroundColor(.white)
                .font(.title2)
                .bold()
                .shadow(color: .black, radius: 5, x: 0, y: 0)
                .padding()
                .multilineTextAlignment(.leading)
        }
    }
    var metrics : some View {
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
    
    var body: some View {
        ZStack {
            VStack(spacing:0) {
                ZStack(alignment: .topLeading) {
                    VStack(alignment:.leading) {
                        topContent
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
                bottomContent
            }
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.3), lineWidth: 1)
                
            )}
        .cornerRadius(10)
        .shadow(color: .gray, radius: 10, x: 0, y: 0)
        .padding([.top, .horizontal])
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
