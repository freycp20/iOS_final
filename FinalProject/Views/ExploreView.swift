//
//  ExploreView.swift
//  FinalProject
//
//  Created by Caleb Frey on 11/7/22.
//

import SwiftUI

struct ExploreView: View {
    @EnvironmentObject var VM : ViewModel
    @State var index : Int = 0
    @State private var isSideBarOpened = false
    @State private var cardChange = true
    
    var currentSchool : School {
        get {
            return VM.undergrad_schools[index]
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
                        }.padding(.leading, 15)
                        Spacer()
                    }
                    
                    VStack {
                        
                        Button {
                            // go to the previous image
                            if (index - 1 < 0) {
                                index = 0
                            } else {
                                index -= 1
                                self.remove = .bottomslide
                                cardChange.toggle()
                            }
                            
                        } label: {
                            Image(systemName: "arrow.up.to.line.compact")
                        }.foregroundColor(.black)
                        Spacer()
                        NavigationLink {
                            DetailView(VM: _VM, currentSchool: currentSchool)
                    } label: {
                        if (cardChange) {
                            CardView(currentSchool: currentSchool, height: geo.size.height*2/3.5, profile: false)
                                .transition(transition)
                        } else {
                            CardView(currentSchool: currentSchool, height: geo.size.height*2/3.5, profile: false)
                                .transition(transition)
                        }
                    }.animation(.default.speed(1), value: cardChange)
                    
                        .foregroundColor(.black)
                        
                        
                        
                        HStack (spacing:0) {
                            Button {
                                // what the button going to do
                                if (index + 1 > VM.undergrad_schools.count-1) {
                                    index = VM.undergrad_schools.count-1
                                } else {
                                    index += 1
                                    self.remove = .backslide
                                    //                                    self.overlay = true
                                    cardChange.toggle()
                                    //                                    self.overlay = false
                                    
                                }
                                
                            } label: {
                                // what it look like
                                //                            Text("bad")
                                Image(systemName: "trash")
                                    .frame(width:geo.size.width/3.5)
                                    .padding([.top, .bottom], geo.size.height/35)
                                    .foregroundColor(.white)
                                
                            }.buttonStyle(GradientButtonStyle(color: Color.red, corners: [.topLeft, .bottomLeft]))
                            
                            Button {
                                if (!VM.saved_schools.contains(currentSchool)) {
                                    VM.saved_schools.append(currentSchool)
                                }
                                if (index + 1 > VM.undergrad_schools.count-1) {
                                    index = VM.undergrad_schools.count-1
                                } else {
                                    index += 1
                                    self.remove = .slide
                                    //                                    self.overlay = true
                                    cardChange.toggle()
                                }
                            } label: {
                                Image(systemName: "bookmark")
                                    .frame(width:geo.size.width/3.5)
                                    .padding([.top, .bottom], geo.size.height/35)
                                    .foregroundColor(.white)
                            }.buttonStyle(GradientButtonStyle(color: Color.green, corners: [.topRight, .bottomRight]))
                        }.padding(.top, geo.size.height/30)
                        Text("\(index + 1) of \(VM.undergrad_schools.count)")
                            .font(.caption)
                            .padding(.top, 10)
                        Spacer()
                        
                    }.animation(.default, value: true)
                        .navigationBarHidden(true)
                        .navigationTitle(Text("Schools"))
                    
                    //                .navigationBarTitleDisplayMode(.inline)
                    //                .edgesIgnoringSafeArea([.top, .bottom])
                }
            }
            SideMenu(isSidebarVisible: $isSideBarOpened)
            
            
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
