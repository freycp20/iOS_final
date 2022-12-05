//
//  ProfileView.swift
//  FinalProject
//
//  Created by Caleb Frey on 11/7/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var VM : ViewModel
    //        var currentSchool : School
    @State var indexPlaceholder : Int = 0
    @State var changingPlaceholder : Bool = false

    @ViewBuilder
    var schoolContent : some View {
        
        if let school = VM.favSchool {
            Spacer()
            NavigationLink {
                DetailView(currentSchool: school)
            } label: {
                CardView(currentSchool: school, height: UIScreen.main.bounds.size.height/2.15, changing: $changingPlaceholder, index: $indexPlaceholder, profile: true)
                
                
            }
            Spacer()
        } else {
            VStack{
                HStack{
                    Spacer()
                    VStack {
                        Spacer()
                        Text("No favorite school, press star on a detail view to favorite a school")
                        Spacer()
                    }.padding().background(RoundedRectangle(cornerRadius: 20).fill(.white).shadow(color: .gray, radius: 5, x: 0, y: 0)).padding(8)
                    Spacer()
                }
            }
        }
        
    }
    var body: some View {
        NavigationView {
            VStack{
                schoolContent
                Divider()
                    .foregroundColor(.black)
                VStack{
                    HStack{
                        Spacer()
                        VStack (alignment: .leading, spacing: 15){
                            HStack{
                                Image(systemName: "person.3.fill")
                                    .font(.caption)
                                Text("SAT: ")
                                    .font(.title2)
                                    .bold()
                                Text("*SAT score*")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                            }
                            Divider()
                            HStack{
                                Image(systemName: "graduationcap.fill")
                                    .font(.callout)
                                Text("GPA: ")
                                    .font(.title2)
                                    .bold()
                                Text("*GPA*")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                            }
                            Divider()
                            HStack{
                                Image(systemName: "dollarsign.square.fill")
                                    .font(.title2)
                                Text("Major: ")
                                    .font(.title2)
                                    .bold()
                                Text("*MAJOR*")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                            }
                            Divider()
                            HStack{
                                Image(systemName: "dollarsign.square")
                                    .font(.title2)
                                Text("Saved Schools: ")
                                    .font(.title2)
                                    .bold()
                                Text("*Saved Schools*")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.white)
                                .shadow(radius: 5)
                        )
                        Spacer()
                    }
                }.padding(.bottom, 35)
            }
            .navigationBarTitle(
                Text("Profile") ,displayMode: .inline)
            .toolbar{
                NavigationLink{
                    SettingsView()
                }label: {
                    Image(systemName: "gear")
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
}
