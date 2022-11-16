//
//  MapView.swift
//  FinalProject
//
//  Created by Immanuel Chia on 11/14/22.
//

import SwiftUI

import MapKit

struct MyView : UIViewRepresentable{
    
    @Binding var showMap : Bool
    
    var currentSchool : School
    //    var index: Int
    
    var region : MKCoordinateRegion {
        get {
            MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: currentSchool.meta_data.location.latitude, longitude: currentSchool.meta_data.location.longitude), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        }
    }
    
    
    var point_of_interest: [MKPointAnnotation] {
        
        var locs = [MKPointAnnotation]()
        var loc = MKPointAnnotation()
        loc.coordinate = CLLocationCoordinate2D(latitude: region.center.latitude, longitude: region.center.longitude)
        loc.title = currentSchool.school_name
        
        locs.append(loc)
        
        //        var loc2 = MKPointAnnotation()
        //        loc2.coordinate = CLLocationCoordinate2D(latitude: region.center.latitude+0.01, longitude: region.center.longitude-0.005)
        //        loc2.title = "SwiftUI"
        //        locs.append(loc2)
        
        return locs
    }
    
    // create
    func makeUIView(context: Context) -> MKMapView {
        var map = MKMapView()
        map.delegate = context.coordinator
        return map
    }
    
    // update
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(point_of_interest)
        uiView.setRegion(region, animated: true)
    }
    
    // tear down
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
    }
    
    // return the delegate
    func makeCoordinator() -> Coordinator {
        return Coordinator(map: self)
    }
    
    
    // delegate
    class Coordinator : NSObject, MKMapViewDelegate{
        
        var map : MyView
        
        init(map: MyView){
            self.map = map
        }
        
        // how the annotation is displayed
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)
            
            annotationView.canShowCallout = true
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            return annotationView
            
        }
        //        // how to respond
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            if view.annotation?.title == map.currentSchool.school_name{
                print(map.currentSchool.school_name)
                
                map.showMap = true
            }
        }
        
    }
}
//
struct MapView: View {
    
    @Binding var showMap : Bool
    var currentSchool : School
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            MyView(showMap: $showMap, currentSchool: currentSchool)
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


