//
//  ViewModel.swift
//  exam1
//
//  Created by Caleb Frey on 10/19/22.
//

import Foundation

class ViewModel : ObservableObject{
    @Published var categories : [String : [School]] = [String : [School]]()
    @Published var catChoice : String  = "undergrad_schools"
    @Published var undergrad_schools : [School] = [School]()
    @Published var grad_schools : [School] = [School]()
    @Published var corner_radius = 15
    
    var choiceArr : [School] {
        get {
            return categories[catChoice] ?? [School]()
        }
    }
    
    @Published var saved_schools : [School] = [School]()
    @Published var index : Int = 0 //    @Published var bShowName = true
//    @Published var bShowAddress = true
    
    
    // construction method
    // called once a new instance is created
    // set up code
    init(){
        
        readJSON()
    }
    
    func readJSON() {
        //1. get the path to the json file within the app bundle
        let pathString = Bundle.main.path(forResource: "schools", ofType: "json")
        
        // 2. unwrap the path string variable
        if let path = pathString{
            // 2. create a URL object
            
            let url = URL(fileURLWithPath: path)
            
            // 3. Create a Data object with the URL File
            do {
                let data = try Data(contentsOf: url)
                
                // 4. parse the data with a JSON Decoder
                let json_decoder = JSONDecoder()
                
                // 5. extract the models from the json file
                var json_data = try json_decoder.decode(AllSchools.self, from: data)
                
                
                for index in 0..<json_data.undergraduate_schools.count {
                    json_data.undergraduate_schools[index].id = UUID()
                }
                for index in 0..<json_data.graduate_schools.count {
                    json_data.graduate_schools[index].id = UUID()
                }
                categories["undergrad_schools"] = json_data.undergraduate_schools
                categories["grad_schools"] = json_data.graduate_schools
                undergrad_schools = json_data.undergraduate_schools
                grad_schools = json_data.graduate_schools
                print(undergrad_schools)
                print(grad_schools)
            } catch {
                print(error)
            }
            
            
        }
    }
//    func addPerson(r: Person){
//        people.append(r)
//    }
}
