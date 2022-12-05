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
    @Published var majors: [String] = [String]()
    @Published var states: [String] = [String]()
    @Published var corner_radius = 15
    @Published var userSat : Int = 1300
    
    
    @Published var filterBySat : Bool = true
    
    
    var filteredSchools : [School] {
        get {
            let arr = choiceArr
            var filtered_arr : [School] = [School]()
            
            for school in arr {
                if passesTests(school: school) {
                    filtered_arr.append(school)
                }
            }
            return filtered_arr
        }
    }
    var choiceArr : [School] {
        get {
            return categories[catChoice] ?? [School]()
        }
    }
    
    @Published var favSchool : School? = nil
    @Published var saved_schools : [School] = [School]()
    var choiceSavedArr : [School] {
        get {
            return cat_saved_schools[catChoice] ?? [School]()
        }
    }
    @Published var cat_saved_schools : [String: [School]] = [String : [School]]()
    @Published var index : Int = 0 //    @Published var bShowName = true
//    @Published var bShowAddress = true
    @Published var darkMode : Bool = false
    
//    @Published var SATScore:  Int {
//        willSet{
//            
//        }
//        didSet{
//            if par
//        }
//    }

    
    
    // construction method
    // called once a new instance is created
    // set up code
    init(){
        
        readJSON()
    }
    
    func passesTests(school: School) -> Bool {
        if (filterBySat) {
            if (school.meta_data.average_sat ?? 0 < userSat) {
                return false
            }
        }
//        if (filterByPopulation) {
//            if (school.meta_data.size != userSize) { // FIX THIS LINE, JUST AN EXAMPLE
//                return false
//            }
//        }
        return true
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
                
                cat_saved_schools["undergrad_schools"] = [School]()
                cat_saved_schools["grad_schools"] = [School]()
                majors = json_data.major
                states = json_data.state
                
            } catch {
                print(error)
            }
            
            
        }
    }
}
