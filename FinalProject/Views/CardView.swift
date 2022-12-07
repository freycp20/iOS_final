//
//  CardView.swift
//  FinalProject
//
//  Created by Caleb Frey on 11/14/22.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var VM : ViewModel
    @State private var color : Color = .clear
    @Environment(\.presentationMode) var presentationMode
    
    @State var image : String = "trash.circle"
    @State var message : String = ""
    var currentSchool : School
    var height : CGFloat
    @State var offset : CGSize = CGSize.zero
    @Binding var changing : Bool
    @Binding var index : Int
    @Binding var dragging : Bool
    
    @State var completed : Bool = false
    
    @State var animationStarted = false
    
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
            HStack(alignment:.top) {
                Text(currentSchool.school_name)
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
                    .shadow(color: .black, radius: 5, x: 0, y: 0)
                    .multilineTextAlignment(.leading)
                Spacer()
                if (VM.choiceSavedArr.contains(currentSchool)) {
                    Image(systemName: "bookmark.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                        .foregroundColor(.white)
                        
//                        .frame(width: 25, height: 25)
                    
                }
            }.padding()
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
                
                Text("\(currentSchool.meta_data.average_sat ?? 0)")
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
    var cardContent : some View {
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
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.3), lineWidth: 1)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(color.opacity(0.1))
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(color, lineWidth: 8)
//                    HStack {
//                        Image(systemName: image)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width:30)
//                            .foregroundColor(color)
//                        Text(message)
//                            .font(.largeTitle)
//                            .bold()
//                            .foregroundColor(color)
//                            .shadow(color: .gray, radius: 5)
//                            .border(<#T##content: ShapeStyle##ShapeStyle#>)
//
//                    }
                }
                
            )
//            color.opacity(0.1)
        }
        
        .cornerRadius(10)
        .padding([.top, .horizontal])
        .offset(x: offset.width, y: offset.height*0.4)
//        .foregroundColor(color.opacity(0.9))
        .rotationEffect(.degrees(Double(offset.width/40)))
    }
    
    @ViewBuilder
    var optionalDrag : some View {
        if (profile) {
            cardContent
        } else {
            cardContent
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                        //                    withAnimation {
                        changeColor(width: offset.width)
                        dragging = true
                        animationStarted = true
                        //                    }
                    } .onEnded{ _ in
                        completed = false
                        withAnimation {
                            swipeCard(width: offset.width)
                        }
                        animationStarted = false
//                        dragging = false
                    }
            )
            .onAnimationCompleted(for: offset.width) {
                if completed {
                    print("times called \(index)")
                    print()
                    //                presentationMode.wrappedValue.dismiss()
                    index += 1
                    changing.toggle()
                    
                }
                if (!animationStarted) {
                    dragging = false
                }
            }
        }
    }
    var body: some View {
        optionalDrag
    }
    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-100):
            offset = CGSize(width: -500, height: 0)
            completed = true
            if (VM.choiceSavedArr.contains(currentSchool)) {
                VM.cat_saved_schools[VM.catChoice]!.remove(at: VM.choiceSavedArr.firstIndex(of: currentSchool)!)
            }
        case 100...500:
            offset = CGSize(width: 500, height: 0)
            completed = true
            if (!VM.choiceSavedArr.contains(currentSchool)) {
                VM.cat_saved_schools[VM.catChoice]!.append(currentSchool)
            }
        default:
            offset = .zero
            completed = false
            
        }
    }
    func changeColor(width: CGFloat) {
        switch width {
        case -500...(-100):
            color = .red
            message = "Discard!"
            image = "trash.circle"
        case 100...500:
            color = .green
            message = "Save!"
            image = "checkmark.circle"
        default:
            color = .clear
            
            
            message = ""
            
        }
    }
}

extension View {
    
    /// Calls the completion handler whenever an animation on the given value completes.
    /// - Parameters:
    ///   - value: The value to observe for animations.
    ///   - completion: The completion callback to call once the animation completes.
    /// - Returns: A modified `View` instance with the observer attached.
    func onAnimationCompleted<Value: VectorArithmetic>(for value: Value, completion: @escaping () -> Void) -> ModifiedContent<Self, AnimationCompletionObserverModifier<Value>> {
        return modifier(AnimationCompletionObserverModifier(observedValue: value, completion: completion))
    }
}

/// An animatable modifier that is used for observing animations for a given animatable value.
struct AnimationCompletionObserverModifier<Value>: AnimatableModifier where Value: VectorArithmetic {
    
    /// While animating, SwiftUI changes the old input value to the new target value using this property. This value is set to the old value until the animation completes.
    var animatableData: Value {
        didSet {
            notifyCompletionIfFinished()
        }
    }
    
    /// The target value for which we're observing. This value is directly set once the animation starts. During animation, `animatableData` will hold the oldValue and is only updated to the target value once the animation completes.
    private var targetValue: Value
    
    /// The completion callback which is called once the animation completes.
    private var completion: () -> Void
    
    init(observedValue: Value, completion: @escaping () -> Void) {
        self.completion = completion
        self.animatableData = observedValue
        targetValue = observedValue
    }
    
    /// Verifies whether the current animation is finished and calls the completion callback if true.
    private func notifyCompletionIfFinished() {
        guard animatableData == targetValue else { return }
        
        /// Dispatching is needed to take the next runloop for the completion callback.
        /// This prevents errors like "Modifying state during view update, this will cause undefined behavior."
        DispatchQueue.main.async {
            self.completion()
        }
    }
    
    func body(content: Content) -> some View {
        /// We're not really modifying the view so we can directly return the original input value.
        return content
    }
}
//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
