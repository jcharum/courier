//
//  FortuneCookie.swift
//  Bindings
//
//  Created by David Le on 10/12/15.
//  Copyright © 2015 David Le. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
A fortune cookie.
*/
public struct FortuneCookie: JSONSerializable, Equatable {
    
    /**
    A fortune cookie message.
    */
    public let message: String
    
    public let certainty: Float?
    
    public let luckyNumbers: [Int]
    
    public let map: [String: Int]
    
    public let simpleArray: [Simple]?
    
    public let simpleMap: [String: Simple]?
    
    public let simple: Simple
    
    public let simpleOpt: Simple?
    
    public let arrayArray: [[Int]]?
    
    public static func read(json: JSON) -> FortuneCookie {
        return FortuneCookie(
            message: json["message"].stringValue,
            certainty: json["certainty"].float,
            luckyNumbers: json["luckyNumbers"].arrayValue.map { $0.intValue },
            map: json["map"].dictionaryValue.mapValues { $0.intValue },
            simpleArray: json["simpleArray"].array.map { $0.map { Simple.read($0.jsonValue) } },
            simpleMap: json["simpleMap"].dictionary.map { $0.mapValues { Simple.read($0.jsonValue) } },
            simple: Simple.read(json["simple"].jsonValue),
            simpleOpt: json["simpleOpt"].json.map { Simple.read($0) },
            arrayArray: json["arrayArray"].array.map { $0.map { $0.arrayValue.map { $0.intValue }}})
    }
    
    public func write() -> JSON {
        var json: [String : JSON] = [:]
        json["message"] = JSON(message)
        if let opt$ = certainty {
            json["certainty"] = JSON(opt$)
        }
        json["luckyNumbers"] = JSON(luckyNumbers)
        json["map"] = JSON(map)
        if let opt$ = simpleArray {
            json["simpleArray"] = JSON(opt$.map { $0.write() })
        }
        if let opt$ = simpleMap {
            json["simpleMap"] = JSON(opt$.mapValues { $0.write() })
        }
        json["simple"] = simple.write()
        if let opt$ = arrayArray {
            json["arrayArray"] = JSON(opt$.map { JSON($0.map { JSON($0) })})
        }
        return JSON(json)
    }
    
    /* TODO: figure out how to properly implement
    var hashValue: Int {
        var hash = 1
        hash = hash * 17 + hashOf(self.message)
        hash = hash * 17 + hashOf(self.certainty)
        hash = hash * 17 + hashOf(self.luckyNumbers)
        hash = hash * 17 + hashOf(self.map)
        hash = hash * 17 + hashOf(self.simpleArray)
        hash = hash * 17 + hashOf(self.simpleMap)
        hash = hash * 17 + hashOf(self.simple)
        hash = hash * 17 + hashOf(self.simpleOpt)
        hash = hash * 17 + hashOf(self.arrayArray)
        return hash
    }
    */
}

/*
extension Simple: Equatable, Hashable {
    var hashValue: Int {
        if let message = self.message {
            return message.hashValue
        } else {
            return 0 // TODO: provide a reasonable hash for empty class case
        }
    }
}
func ==(lhs: Simple, rhs: Simple) -> Bool {
    return lhs.message == rhs.message
}*/

public func ==(lhs: FortuneCookie, rhs: FortuneCookie) -> Bool {
    return
      lhs.message == rhs.message &&
      (lhs.certainty == nil ? (rhs.certainty == nil) : lhs.certainty! == rhs.certainty!) &&
      lhs.luckyNumbers == rhs.luckyNumbers &&
      lhs.map == rhs.map &&
      (lhs.simpleArray == nil ? (rhs.simpleArray == nil) : lhs.simpleArray! == rhs.simpleArray!) &&
      (lhs.simpleMap == nil ? (rhs.simpleMap == nil) : lhs.simpleMap! == rhs.simpleMap!) &&
      lhs.simple == rhs.simple &&
      lhs.simpleOpt == rhs.simpleOpt &&
      (lhs.arrayArray == nil ? (rhs.arrayArray == nil) : lhs.arrayArray! == rhs.arrayArray!)
}