//
//  Quiz.swift
//  exam1
//
//  Created by Caleb Frey on 10/19/22.
//

import Foundation

struct AllSchools : Decodable{
    
    var undergraduate_schools : [School] = [School]()
    var graduate_schools : [School] = [School]()
    var major: [String] = [String]()
    var state: [String] = [String]()
//    var population_range: [String] = [String]()
    
}

struct School : Decodable, Identifiable, Equatable {
    static func == (lhs: School, rhs: School) -> Bool {
        return lhs.id == rhs.id && lhs.school_name == rhs.school_name
    }
    
    var id : UUID?
    var school_name : String
    var meta_data : MetaData
    var url : String
    var image : String
    
}

struct MetaData : Decodable {
    var size : Int
    var average_sat : Int?
    var average_gre : Int?
    var average_gpa : Double
    var avg_cost_before_financial_aid : Int?
    var avg_cost_after_financial_aid : Int?
    var location : Location
    var student_to_faculty_ratio : String
    var state : String
    var type_of_community : String
    
}

struct Location : Decodable {
    var latitude : Double
    var longitude : Double
}

