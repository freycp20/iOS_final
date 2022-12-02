//
//  CardView.swift
//  FinalProject
//
//  Created by Caleb Frey on 11/14/22.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var VM : ViewModel
    @State private var color : Color = .black
    @Environment(\.presentationMode) var presentationMode
    
    var currentSchool : School
    var height : CGFloat
    @State var offset : CGSize
    @Binding var changing : Bool
    
    @Binding var index : Int
    @State var completed : Bool = false
    
    
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
//                    withAnimation {
                        changeColor(width: offset.width)
//                    }
                } .onEnded{ _ in
                    completed = false
                    withAnimation {
                        swipeCard(width: offset.width)
                    }
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
        }
    }
    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
            completed = true
        case 150...500:
            offset = CGSize(width: 500, height: 0)
            completed = true
            if (!VM.saved_schools.contains(currentSchool)) {
                VM.saved_schools.append(currentSchool)
            }
        default:
            offset = .zero
            completed = false
            
        }
    }
    func changeColor(width: CGFloat) {
        switch width {
        case -500...(-150):
            color = .red
            
        case 150...500:
            color = .green
        default:
            color = .black
            
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
