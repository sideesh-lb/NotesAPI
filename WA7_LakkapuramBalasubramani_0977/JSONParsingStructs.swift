//
//  JSONParsingStructs.swift
//  WA7_LakkapuramBalasubramani_0977
//
//  Created by Sideeshwaran Balasubramani on 11/2/23.
//

import Foundation

struct X_access_token: Codable{
    
    var auth: Bool
    var token: String!
}

struct Note: Codable {
    var userId: String
    var text: String
    var _id: String
    var __v: Int
}

struct Notes: Codable {
    var notes: [Note]
}

struct Profile: Codable {
    var _id: String
    var name: String
    var email: String
    var __v: Int
}
//{
//    "posted": true,
//    "note": {
//        "userId": "6543c448d838b81f11324187",
//        "text": "I have a class on Tue",
//        "_id": "6543dcffd838b81f1132421c",
//        "__v": 0
//    }
//}
