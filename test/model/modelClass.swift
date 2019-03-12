//
//  modelClass.swift
//  test
//
//  Created by Pritesh Khandelwal on 11/03/19.
//  Copyright © 2019 Pritesh Khandelwal. All rights reserved.
//

import Foundation

class RootClass : Codable {
    var explore : [Explore] =  [Explore]()
    var filter : Filter =  Filter()
}

class Filter : Codable {
    var countries : [String] =  [String]()
}

class Explore : Codable {
    var entities : [Entity] =   [Entity]()
    var isTop : Bool?
    var sectionType : String = ""
    var title : String = ""
}


class Entity : Codable {
    
    var id : String?
    var imageRatio : Float?
    var imageUrl : String?
    var name : String?
    
    var userTerm : String?
    var userTermSlug : String?
    var firstName : String?
    var lastName : String?
    
    var totalProjectClaps : Int?
    var actionUrl:String?
    var dex :dexClass?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case imageRatio = "imageRatio"
        case imageUrl = "imageUrl"
        case name = "name"
        
        case userTerm = "userTerm"
        case userTermSlug = "userTermSlug"
        case firstName = "firstName"
        case lastName = "lastName"
        
        case totalProjectClaps = "totalProjectClaps"
        case actionUrl = "actionUrl"
        case dex = "dex"
    }

    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        imageRatio = try values.decodeIfPresent(Float.self, forKey: .imageRatio)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        userTerm = try values.decodeIfPresent(String.self, forKey: .userTerm)
        userTermSlug = try values.decodeIfPresent(String.self, forKey: .userTermSlug)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        totalProjectClaps = try values.decodeIfPresent(Int.self, forKey: .totalProjectClaps)
        actionUrl = try values.decodeIfPresent(String.self, forKey: .actionUrl)
        
        dex = try values.decodeIfPresent(dexClass.self, forKey: .dex)
        //dex =  try dexClass(from: decoder)
    }
    
}

class dexClass: Codable {
    var id : String?
    var imageRatio : Float?
    var imageUrl : String?
    var name : String?
    var userTerm : String?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case imageRatio = "imageRatio"
        case imageUrl = "imageUrl"
        case name = "name"
        case userTerm = "userTerm"

    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        imageRatio = try values.decodeIfPresent(Float.self, forKey: .imageRatio)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        userTerm = try values.decodeIfPresent(String.self, forKey: .userTerm)

    }
}

class userResponse:Codable{
    var users:[user] = [user]()
    var next :String = ""
}

class user:Codable{
    var _id : String?
    var firstName : String?
    var lastName : String?
    var imageUrl : String?
    var totalProjectClaps :Int?
}
