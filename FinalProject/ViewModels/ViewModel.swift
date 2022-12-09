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
    

    @Published var firstChoice : String = "GPA"
    @Published var secondChoice : String = "Test Scores"
    
    var intSAT : Int? {
        get {
            if (SATGrade.isInt) {
                return Int(SATGrade)!
            } else {
                return nil
            }
        }
    }
    
    var doubleGPA : Double? {
        get {
            if (GPAGrade.isDouble) {
                return Double(GPAGrade)!
            } else {
                return nil
            }
        }
    }
    
    var intGRE : Int? {
        get {
            if (GREGrade.isInt) {
                return Int(GREGrade)!
            } else {
                return nil
            }
        }
    }

    @Published var darkModeToggle : Bool = false
    @Published var SATtoggle : Bool = false
    @Published var GPAtoggle : Bool = false
    @Published var GREtoggle : Bool = false
    @Published var SATGrade: String = ""
    @Published var GPAGrade: String = ""
    @Published var GREGrade: String = ""
    @Published var DesiredMajor: String = ""
    @Published var Poptoggle : Bool = false
    @Published var DesiredPop: String = ""
    @Published var CTtoggle : Bool = false
    @Published var DesiredCT: String = ""

    var CTArr = ["rural", "suburban", "city"]
    var popArr = ["None", "10000>", "7000-10000", "3000-7000", "1000-3000", "<1000"]
    var populationCompare : [String : [String : Int]] = [
        "None": [
            "max": 0,
            "min": 0
        ],
        "10000>": [
            "max": 1000000000,
            "min": 10001
        ],
        "7000-10000": [
            "max": 10000,
            "min": 7001
        ],
        "3000-7000": [
            "max": 7000,
            "min": 3000
        ],
        "1000-3000": [
            "max": 3000,
            "min": 1000
        ],
        "<1000": [
            "max": 999,
            "min": 0
        ]
    ]
    
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
    @Published var index : Int = 0
    @Published var darkMode : Bool = false
    

    @Published var filterBySat : Bool = true
    @Published var filterByGPA : Bool = true
    @Published var filterByGRE : Bool = true
    @Published var filterByPopulation : Bool = true
    @Published var filterByComType : Bool = true

    
    // construction method
    // called once a new instance is created
    // set up code
    init(){
            readJSON()
    }
    // SAT, GPA, GRE, STATE, com type
    func passesTests(school: School) -> Bool {
        if (SATtoggle) {
            if (school.meta_data.average_sat ?? 0 > (intSAT ?? 1600)) {
                return false
            }
        }
        if (GPAtoggle) {
            if (school.meta_data.average_gpa > (doubleGPA ?? 5.0)) {
                return false
            }
        }
        if (GREtoggle) {
            if (school.meta_data.average_gre ?? 0 > (intGRE ?? 400)) {
                return false
            }
        }
        
        if (Poptoggle) {
            if (DesiredPop != "None" && DesiredPop != "") {
                print(school.school_name)
                print(DesiredPop)
                let max = populationCompare[DesiredPop]!["max"]!
                let min = populationCompare[DesiredPop]!["min"]!
                print("max: \(max)")
                print("min: \(min)")
                print("size = \(school.meta_data.size)\n")
                // if pop < max and > min
//                if ((DesiredPop > max) && (DesiredPop < min)){
                if ((school.meta_data.size > max) || (school.meta_data.size < min)){

                    return false
                }
            }
        }
        
        if (CTtoggle) {
            if (DesiredCT != "") {
                if (DesiredCT != school.meta_data.type_of_community) {
                    return false
                }
            }
        }
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
                
                print(undergrad_schools)
                print(grad_schools)
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
extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
    
    var isDouble: Bool {
        return Double(self) != nil
    }
}
