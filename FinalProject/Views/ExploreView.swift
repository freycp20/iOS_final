//
//  ExploreView.swift
//  FinalProject
//
//  Created by Caleb Frey on 11/7/22.
//

import SwiftUI

struct ExploreView: View {
    @EnvironmentObject var VM : ViewModel
    @State private var isSideBarOpened = false
    @State private var cardChange = true
    @State var index = 0
    @State var dragging : Bool = false
    
    var currentSchool : School {
        get {
            if VM.filteredSchools.count != 0 {
                let index = self.index < VM.filteredSchools.count ? self.index : VM.filteredSchools.count-1
                return VM.filteredSchools[index]
            } else {
                return VM.undergrad_schools[0]
            }
        }
    }
    var nextSchool : School {
        get {
            return VM.filteredSchools[self.index+1]
        }
    }
    
    @State var insert : AnyTransition = .scale
    @State var remove : AnyTransition = .slide
    
    @State var green : Bool = true
    @State var overlay : Bool = false
    var transition : AnyTransition {
        get {
            return AnyTransition.asymmetric(insertion: self.insert, removal: self.remove).combined(with: .opacity)
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                ZStack {
                    VStack {
                        HStack {
                            Button {
                                //nothing yet
                                isSideBarOpened.toggle()
                            } label: {
                                
                                Image(systemName: "line.3.horizontal")
                                    .resizable()
                                //                                .aspectRatio(contentMode: .fill)
                                //                                .padding(20)
                                    .frame(width: 25, height:15)
                                
                            }
                            Spacer()
                            NavigationLink{
                                SettingsView()
                            }label: {
                                Image(systemName: "gear")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.gray)
                                    
                            }

                        }.padding([.leading, .trailing], 15)
                        Spacer()
                    }
                    
                    VStack {
                        
                        Button {
                            // go to the previous image
                            if (self.index - 1 < 0) {
                                self.index = 0
                            } else {
                                self.index -= 1
                                cardChange.toggle()
                            }
                            
                        } label: {
                            Image(systemName: "arrow.up.to.line.compact")
                        }.foregroundColor(.black)
                        Spacer()
                        if (index < VM.filteredSchools.count && VM.filteredSchools.count != 0){
                            NavigationLink {
                                DetailView(VM: _VM, currentSchool: currentSchool)
                            } label: {
                                if (cardChange) {
                                    ZStack {
                                        if (index + 1 < VM.filteredSchools.count) {
                                            CardView(currentSchool: nextSchool, height: geo.size.height*2/3, offset: CGSize.zero, changing: $cardChange, index: $index, dragging: $dragging).opacity(self.dragging ? 1 : 0)
                                                .shadow(color: .gray, radius: 10, x: 0, y: 0)
                                        } else {
                                            Text("No schools available")
                                        }
                                        CardView(currentSchool: currentSchool, height: geo.size.height*2/3, offset: CGSize.zero, changing: $cardChange, index: $index, dragging: $dragging)
                                            .shadow(color: .gray, radius: dragging ? 0 : 10, x: 0, y: 0)
                                    }
                                } else {
                                    ZStack {
                                        if (index + 1 < VM.filteredSchools.count) {
                                            CardView(currentSchool: nextSchool, height: geo.size.height*2/3, offset: CGSize.zero, changing: $cardChange, index: $index, dragging: $dragging).opacity(self.dragging ? 1 : 0)
                                                .shadow(color: .gray, radius: 10, x: 0, y: 0)
                                        } else {
                                            Text("No schools available")
                                        }
                                        CardView(currentSchool: currentSchool, height: geo.size.height*2/3, offset: CGSize.zero, changing: $cardChange, index: $index, dragging: $dragging)
                                            .shadow(color: .gray, radius: dragging ? 0 : 10, x: 0, y: 0)
                                        
                                    }
                                }
                            }
                            .foregroundColor(.black)
                        } else {
                            Text("No schools available")
                        }
                        Text(self.index < VM.filteredSchools.count ? "\(self.index + 1) of \(VM.filteredSchools.count)" : "")
                            .font(.caption)
                            .padding(.top, 10)
                            .zIndex(-100.0)
                        Spacer()
                        
                    }.animation(.default, value: true)
                        .navigationBarHidden(true)
                        .navigationTitle(Text("Schools"))
                    
                    //                .navigationBarTitleDisplayMode(.inline)
                    //                .edgesIgnoringSafeArea([.top, .bottom])
                }
            }
            SideMenu(isSidebarVisible: $isSideBarOpened, index: $index)
            
            
        }
        
    }
    
}

extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))}
    static var bottomslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .top),
            removal: .move(edge: .bottom))}
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct GradientButtonStyle: ButtonStyle {
    var color : Color
    var corners : UIRectCorner
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(color)
        //            .padding()
        //            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0, corners: corners)
            .brightness(configuration.isPressed ? 0.2 : 0)
        //            .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
        
    }
}
struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

//struct ExploreView_Previews: PreviewProvider {
//    @Binding var showWeb : Bool
//    @EnvironmentObject var VM : ViewModel
//    @State var index : Int = 0
//    static var previews: some View {
//        ExploreView(VM: _VM, index: index, showWeb: $showWeb)
//    }
//}
