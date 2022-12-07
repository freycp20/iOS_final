//
//  SettingsView.swift
//  FinalProject
//
//  Created by Immanuel Chia on 11/21/22.
//

import SwiftUI
struct StaticEditCardView: View {
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("Edit card display")
            }
        }
    }
}

struct DarkModeView: View{
    @Binding var toggle : Bool
    var body: some View{
        ZStack {
            Capsule()
                .frame(width:60,height:33)
                .foregroundColor(Color(toggle ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6039008336) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1028798084)))
            ZStack{
                Circle()
                    .frame(width:30, height:30)
                    .foregroundColor(.white)
                Image(systemName: toggle ? "sun.max.fill" : "moon.fill")
            }
            .shadow(color: .black.opacity(0.14), radius: 4, x: 0, y: 2)
            .offset(x:toggle ? 13 : -13)
            .animation(.spring())
        }
        .onTapGesture {
            self.toggle.toggle()
        }
    }
}

struct SATFilterView: View{
    @Binding var SATtoggle : Bool
    @Binding var SATGrade: String
    var body: some View{
        VStack{
            Toggle(isOn: $SATtoggle) {
                Text("Filter by SAT")
            }
            if SATtoggle {
                TextField(text: $SATGrade, prompt: Text("Enter SAT score")) {
                }.font(.caption)
            }
        }
    }
}



struct GPAFilterView: View{
    @Binding var GPAtoggle : Bool
    @Binding var GPAGrade: String
//    @EnvironmentObject var VM : ViewModel
    var body: some View{
        VStack{
            Toggle(isOn: $GPAtoggle) {
                Text("Filter by GPA")
            }
            if GPAtoggle {
                TextField(text: $GPAGrade, prompt: Text("Enter GPA score")) {
                }.font(.caption)
            }
        }
    }
}

struct GREFilterView: View{
    @Binding var GREtoggle : Bool
    @Binding var GREGrade: String
    var body: some View{
        VStack{
            Toggle(isOn: $GREtoggle) {
                Text("Filter by GRE")
            }
            if GREtoggle {
                TextField(text: $GREGrade, prompt: Text("Enter GRE score")) {
                }.font(.caption)
            }
        }
    }
}

struct MajorView: View{
    @Binding var DesiredMajor: String
    @EnvironmentObject var VM: ViewModel
    var body: some View{
        let majorList = VM.majors
        HStack{
            Picker("Desired Major", selection: $DesiredMajor) {
                ForEach(majorList, id:\.self){ id in
                    Text(id)
                }
            }
        }
    }
}


struct PopFilterView: View{
    @Binding var Poptoggle: Bool
    @Binding var DesiredPop: String
    @EnvironmentObject var VM: ViewModel
    var body: some View{
        let populationRangeList = VM.popArr
        VStack{
            Toggle(isOn: $Poptoggle) {
                Text("Filter by Population")
            }
            if Poptoggle {
                HStack{
                    Picker("Population Range", selection: $DesiredPop) {
                        ForEach(populationRangeList, id:\.self){ id in
                            Text(id)
                        }
                    }
                }
            }
        }
    }
}

//                    }.pickerStyle(MenuPickerStyle())

struct CommunityTypesFilterView: View{
    @Binding var CTtoggle: Bool
    @Binding var DesiredCT: String
    @EnvironmentObject var VM: ViewModel
    var body: some View{
        let CTlist = VM.CTArr
        VStack{
            Toggle(isOn: $CTtoggle) {
                Text("Filter by Community Types")
            }
            if CTtoggle {
                HStack{
                    Picker("Community", selection: $DesiredCT) {
                        ForEach(CTlist, id:\.self){ id in
                            Text(id)
                        }
                    }
                }
            }
        }
    }
}
struct SettingsView: View {
    @EnvironmentObject var VM : ViewModel
    
    var body: some View {
//        NavigationView{
            ZStack{
                // Color()
                VStack {
                    List{
                        // edit card
                        Section(header: Text("Card Display"),
                                footer: Text("Allows user to display different information on school card")){
                            NavigationLink{
                                EditCardView()
                            }label: {
                                StaticEditCardView()
                            }
                        }
                        // dark mode
                        Section(header: Text("Display")){
                            HStack{
                                HStack{
                                    Text("Dark Mode")
                                    Spacer()
                                }
                                DarkModeView(toggle: $VM.darkModeToggle)
//                                DarkModeView(toggle: $darkModeToggle)
                            }
                        }
                        
                        
                        // major information
                        Section(header: Text("Major preference")){
                            HStack{
                                MajorView(DesiredMajor: $VM.DesiredMajor)
                            }
                        }
                        
                        // GPA and SAT and GRE filter
                        Section(header: Text("Grade filter"), footer: Text("Allows user to filter schools through grades")){
                            VStack{
                                SATFilterView(SATtoggle: $VM.SATtoggle, SATGrade: $VM.SATGrade)
                                GPAFilterView(GPAtoggle: $VM.GPAtoggle, GPAGrade: $VM.GPAGrade)
                                GREFilterView(GREtoggle: $VM.GREtoggle, GREGrade: $VM.GREGrade)

                            }
                        }
                        
                        // population and state filter
                        Section(footer: Text("Filter out population range and community type of college")){
                            PopFilterView(Poptoggle: $VM.Poptoggle, DesiredPop: $VM.DesiredPop)
                            CommunityTypesFilterView(CTtoggle: $VM.CTtoggle, DesiredCT: $VM.DesiredCT)
                        }
                    }
                }.listStyle(.insetGrouped)
                    .navigationBarTitle("Settings", displayMode: .inline)
            }
//        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

