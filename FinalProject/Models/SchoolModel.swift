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
    var average_sat : Int
    var average_gpa : Double
    var average_cost_before_financial_aid : Int?
    var average_cost_after_financial_aid : Int?
    var location : Location
}

struct Location : Decodable {
    var latitude : Double
    var longitude : Double
}

//struct U : Decodable {
//    var sport : Question = Question()
//    var maths = [Question]()
//}
//struct Question : Decodable, Identifiable {
//    var id : UUID?
//    var question : String = ""
//    var options = [String]()
//    var answer = ""
//}
