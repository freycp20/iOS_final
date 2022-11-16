//
//  DetailView.swift
//  FinalProject
//
//  Created by Immanuel Chia on 11/14/22.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var VM : ViewModel
    
    var currentSchool : School
    
    @State var showMap : Bool = false
    @State var showingWebSheet : Bool = false
    
    var body: some View {
        VStack {
            Divider()
                .foregroundColor(.black)
            
            VStack {
                
                HStack{
                    Spacer()
                    VStack (alignment: .leading){
                        Text("Average GPA")
                            .font(.title2)
                            .bold()
                        Text("\(currentSchool.meta_data.average_gpa, specifier: "%.2f")")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }.frame(
                        minWidth: 0,
                        maxWidth: .infinity
                    )
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.white)
                            .shadow(radius: 5)
                    )
                    
                    Spacer()
                    VStack (alignment: .leading){
                        Text("Average SAT")
                            .font(.title2)
                            .bold()
                        Text("\(currentSchool.meta_data.average_sat)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }.padding()
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
                VStack{
                    HStack{
                        Spacer()
                        VStack (alignment: .leading){
                            HStack{
                                Image(systemName: "person.3.fill")
                                    .font(.caption)
                                Text("Population: ")
                                    .font(.title2)
                                    .bold()
                                Text("\(currentSchool.meta_data.size)")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                            }
                            HStack{
                                Image(systemName: "graduationcap.fill")
                                    .font(.callout)
                                Text("Student to faculty ratio: ")
                                    .font(.title2)
                                    .bold()
                                Text("\(currentSchool.meta_data.student_to_faculty_ratio)")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                            }
                            
                            
                            Divider()
                            HStack{
                                Image(systemName: "dollarsign.square.fill")
                                    .font(.title2)
                                Text("Cost before aid: ")
                                    .font(.title2)
                                    .bold()
                                if currentSchool.meta_data.avg_cost_before_financial_aid != nil{
                                    Text("\(currentSchool.meta_data.avg_cost_before_financial_aid ?? 0 )")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                }
                                else{
                                    Text("N/A")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            HStack{
                                Image(systemName: "dollarsign.square")
                                    .font(.title2)
                                Text("Cost after aid: ")
                                    .font(.title2)
                                    .bold()
                                if currentSchool.meta_data.avg_cost_after_financial_aid != nil{
                                    Text("\(currentSchool.meta_data.avg_cost_after_financial_aid ?? 0 )")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                }
                                else{
                                    Text("N/A")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            Divider()
                            HStack{
                                Image(systemName: "flag.fill")
                                    .font(.title2)
                                Text("State: ")
                                    .font(.title2)
                                    .bold()
                                Text("\(currentSchool.meta_data.state)")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                            }
                            
                            HStack{
                                Image(systemName: "building.2.fill")
                                    .font(.headline)
                                Text("Type of community: ")
                                    .font(.title2)
                                    .bold()
                                Text("\(currentSchool.meta_data.type_of_community)")
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
                }
                
                VStack{
                    HStack{
                        Spacer()
                        VStack{
                            Button{
                                showMap.toggle()
                            }label: {
                                HStack {
                                    HStack{
                                        VStack(alignment: .leading){
                                            HStack{
                                                Image(systemName: "location.fill")
                                                Text("Location")
                                                    .bold()
                                            }
                                            .font(.title2)
                                            .foregroundColor(.black)
                                            Text("*INSERTS ADDRESS OF SCHOOL*")
                                                .font(.headline)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                    Spacer()
                                    HStack{
                                        Image(systemName: "chevron.right")
                                            .font(.title)
                                    }
                                }
                            }.padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(.white)
                                        .shadow(radius: 5)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                )
                        }
                        Spacer()
                    }
                }
                
                HStack{
                    Spacer()
                    VStack{
                        //                            HStack {
                        Button{
                            showingWebSheet.toggle()
                        }label: {
                            HStack {
                                HStack{
                                    VStack(alignment: .leading){
                                        HStack{
                                            Image(systemName: "wifi")
                                            Text("Website")
                                                .bold()
                                        }
                                        .font(.title2)
                                        .foregroundColor(.black)
                                        
                                        
                                        
                                        Text("\(currentSchool.url)")
                                            .font(.headline)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                }
                                Spacer()
                                HStack{
                                    Image(systemName: "chevron.right")
                                        .font(.title)
                                    
                                }
                            }
                            
                        }.padding()
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                
                                    .fill(.white)
                                    .shadow(radius: 5)
                                
                            )
                            .sheet(isPresented: $showingWebSheet) {
                                //
                                WebView(URLwebsite: currentSchool.url)
                                
                            }
                    }
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity
                    )
                    Spacer()
                }
                
                Spacer()
            }
        }.sheet(isPresented: $showMap) {
            MapView(showMap: $showMap, currentSchool: currentSchool)
            
        }
        .navigationTitle("\(currentSchool.school_name)")
    }
}




