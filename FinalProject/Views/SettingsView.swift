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
    var body: some View{
        let populationRangeList = ["None", "10000>", "3000 - 7000", "1000 - 3000", "<1000"]
        VStack{
            Toggle(isOn: $Poptoggle) {
                Text("Filter by Population")
            }
            if Poptoggle {
                HStack{
                    Text("Population Range")
                    Spacer()
                    Picker("Population Range", selection: $Poptoggle){
                        ForEach(populationRangeList, id:\.self){ id in
                            Text(id)

                        }
                    }.pickerStyle(MenuPickerStyle())
                }
            }
        }
    }
}

struct StateFilterView: View{
    @Binding var Statetoggle: Bool
    @Binding var DesiredState: String
    @EnvironmentObject var VM: ViewModel
    var body: some View{
        let StateList = VM.states
        VStack{
            Toggle(isOn: $Statetoggle) {
                Text("Filter by States")
            }
            if Statetoggle {
                HStack{
                    Picker("Desired State", selection: $DesiredState) {
                        ForEach(StateList, id:\.self){ id in
                            Text(id)
                        }
                    }
                }
            }
        }
    }
}
struct SettingsView: View {
    @State var darkModeToggle : Bool = false
    @State var SATtoggle : Bool = false
    @State var GPAtoggle : Bool = false
    @State var SATGrade: String = ""
    @State var GPAGrade: String = ""
    @State var DesiredMajor: String = "Undeclared"
    @State var Poptoggle : Bool = false
    @State var Statetoggle : Bool = false
    @State var DesiredState: String = "None"
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
                                DarkModeView(toggle: $darkModeToggle)
                            }
                        }
                        
                        // GPA and SAT filter
                        Section(header: Text("Grade filter"), footer: Text("Allows user to filter schools through grades")){
                            VStack{
                                SATFilterView(SATtoggle: $SATtoggle, SATGrade: $SATGrade)
                                GPAFilterView(GPAtoggle: $GPAtoggle, GPAGrade: $GPAGrade)
                            }
                        }
                        
                        // major information
                        Section(header: Text("Major preference")){
                            HStack{
                                MajorView(DesiredMajor: $DesiredMajor)
                            }
                        }
                        
                        // population and state filter
                        Section(footer: Text("Filter out population range and state of college")){
                            PopFilterView(Poptoggle: $Poptoggle)
                            StateFilterView(Statetoggle: $Statetoggle, DesiredState: $DesiredState)
                        }
                    }
                }.listStyle(.insetGrouped)
                    .navigationBarTitle("Settings", displayMode: .inline)
            }
//        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

