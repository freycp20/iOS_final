//
//  WebView.swift
//  FinalProject
//
//  Created by Immanuel Chia on 11/14/22.
//

import SwiftUI

import WebKit

struct MyWebView : UIViewRepresentable{
    
    
    
    let request : URLRequest
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
}


struct WebView: View {
    
    var URLwebsite = ""
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            if let url_add = URL(string: URLwebsite){
                MyWebView(request: URLRequest(url: url_add))
            }
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        HStack{
                            Image(systemName: "chevron.left")
                                .foregroundColor(.gray)
                            Text("Back")
                            
                                .foregroundColor(.gray)
                        }.padding(10)
                    }.background(RoundedRectangle(cornerRadius: 10).fill(.white).opacity(0.8))
                        .padding(5)
                    Spacer()
                }
                Spacer()
            }
        }
        
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView()
    }
}
