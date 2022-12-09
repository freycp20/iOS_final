//
//  EditCardView.swift
//  FinalProject
//
//  Created by Immanuel Chia on 11/21/22.
//

import SwiftUI

struct EditCardView: View {
    @EnvironmentObject var VM : ViewModel
    @State private var color : Color = .clear
    
    var currentSchool : School {
        get {
            return VM.choiceArr[0]
        }
    }
    
    func create_view(title: Text, content: Text) -> some View {
        return VStack(alignment: .leading, spacing: 0) {
            title
                .font(.title2)
                .bold()
                .padding(.bottom, 5)
                .multilineTextAlignment(.leading)
            
            content
                .font(.headline)
                .foregroundColor(.secondary)
            
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            alignment: .topLeading
        )
        .padding(15)
    }
    var preferences : [String : AnyView] {
        get {
            let gpa = Text("\(currentSchool.meta_data.average_gpa, specifier: "%.2f")")
            return [
                "Test Scores": AnyView(create_view(title: Text("Average \(VM.catChoice == "undergrad_schools" ? "SAT" : "GRE")"), content: Text("\(VM.catChoice == "undergrad_schools" ? currentSchool.meta_data.average_sat ?? 0 : currentSchool.meta_data.average_gre ?? 0)"))),
                "GPA": AnyView(create_view(title: Text("Average GPA"), content: gpa)),
                "Population": AnyView(create_view(title: Text("Population"), content: Text("\(currentSchool.meta_data.size)"))),
                "Community" : AnyView(create_view(title: Text("Community Type"), content: Text(currentSchool.meta_data.type_of_community)))
            ]
        }
    }
    var firstChoice : AnyView {
        get {
            return AnyView(preferences[VM.firstChoice])
        }
    }
    var secondChoice : AnyView {
        get {
            return AnyView(preferences[VM.secondChoice])
        }
    }
    //    var height : CGFloat
    
    var profile : Bool = false
    
    @ViewBuilder
    var bottomContent : some View {
        metrics
    }
    
    @ViewBuilder
    var topContent : some View {
        HStack(alignment:.top) {
            Text(currentSchool.school_name)
                .foregroundColor(.white)
                .font(.title2)
                .bold()
                .shadow(color: .black, radius: 5, x: 0, y: 0)
                .multilineTextAlignment(.leading)
            Spacer()
        }.padding()
    }
    var metrics : some View {
        HStack(spacing:0) {
            firstChoice
            Divider().padding([.top, .bottom], 5)
            secondChoice
        }.background(.white)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    let choicesList = ["Test Scores", "GPA", "Population", "Community"]
    
    
    var setButtons : some View{
        HStack{
            Spacer()
            VStack (alignment: .center){
                Text("Set first choice")
                    .bold()
                Picker(selection: $VM.firstChoice, label: Text("test")) {
                    ForEach(choicesList, id:\.self){ id in
                        Text(id)
                    }
                }
            }.padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
//                        .border(.blue, width: 2)
//                        .shadow(radius: 5)
                        
                )
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity
                )
                .overlay(
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 1)
                    }
                )
                .cornerRadius(10)
            
            Spacer()
            VStack (alignment: .center){
                Text("Set second choice")
                    .bold()
                Picker("Second Choice", selection: $VM.secondChoice) {
                    ForEach(choicesList, id:\.self){ id in
                        Text(id)
                    }
                }
            }.padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
//                        .border(.blue, width: 2)
//                        .shadow(radius: 5)
                        
                )
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity
                )
                .overlay(
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue , lineWidth: 1)
                    }
                )
                .cornerRadius(10)
            Spacer()
        }
    }
    
    var cardContent : some View {
        GeometryReader { geo in
            ZStack (alignment: .center) {
                VStack{
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
                        .frame(height: geo.size.height*5/8)
                        .background(
                            Image(currentSchool.image)
                                .resizable()
                                .scaledToFill())
                        bottomContent
                    }
                    .cornerRadius(10)
                    .overlay(
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.3), lineWidth: 1)
                        }
                    )
                    .cornerRadius(10)
                    .padding([.top, .horizontal])
                    .shadow(color: .gray, radius: 10)
                    
                    //                    Spacer()
                    setButtons
                    
                    //                    Spacer()
                }
            }.navigationTitle("Edit card")
        }
    }
    
    
    var body: some View {
        cardContent
    }
}






