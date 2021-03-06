//
// Copyright 2015 Coursera Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import XCTest
import SwiftyJSON
import Foundation

@testable import testsuite

class GeneratedCodeTests: XCTestCase {
    // TODO(jbetz): Locate a xcode variable for the project root, use that instead of the /base/coursera path here.
    let jsonDir = NSProcessInfo.processInfo().environment["HOME"]! + "/base/coursera/courier/reference-suite/src/main/json/"
    
    func testWithComplexTypesMap() {
        let json = try! jsonFile("WithComplexTypesMap.json");
        let deserialized = try! WithComplexTypesMap.readJSON(json);
        
        let expected = WithComplexTypesMap(
            empties: ["a": Empty(), "b": Empty(), "c": Empty()],
            fruits: ["a": Fruits.APPLE, "b": Fruits.BANANA, "c": Fruits.ORANGE],
            arrays: ["a": [ Simple(message: "v1"), Simple(message: "v2")]],
            maps: ["o1": ["i1": Simple(message: "o1i1"), "i2": Simple(message: "o1i2")]],
            unions: ["a": .IntMember(1), "b": .StringMember("u1")],
            fixed: ["a": "\u{0000}\u{0001}\u{0002}\u{0003}\u{0004}\u{0005}\u{0006}\u{0007}"])
        
        XCTAssertEqual(deserialized, expected)
        
        let serialized = deserialized.writeJSON();
        assertSameJsObject(json.rawString()!, actual: serialized.rawString()!)
    }
    
    func testWithCustomTypesArray() {
        let json = try! jsonFile("WithCustomTypesArray.json");
        let deserialized = try! WithCustomTypesArray.readJSON(json);
        
        let expected = WithCustomTypesArray(
            ints: [CustomInt(int: 1), CustomInt(int: 2), CustomInt(int: 3)],
            arrays: [[ Simple(message: "a1")]],
            maps: [["a": Simple(message: "m1")]],
            unions: [.IntMember(1), .StringMember("str"), .SimpleMember(Simple(message: "u1"))],
            fixed: [ "\u{0000}\u{0001}\u{0002}\u{0003}\u{0004}\u{0005}\u{0006}\u{0007}"])
        
        XCTAssertEqual(deserialized, expected)
        
        let serialized = deserialized.writeJSON();
        assertSameJsObject(json.rawString()!, actual: serialized.rawString()!)
    }
    
    func testWithCustomTypesMap() {
        let json = try! jsonFile("WithCustomTypesMap.json");
        let deserialized = try! WithCustomTypesMap.readJSON(json);
        
        let expected = WithCustomTypesMap(ints: ["a": CustomInt(int: 1), "b": CustomInt(int: 2), "c": CustomInt(int: 3)])
        
        XCTAssertEqual(deserialized, expected)
        
        let serialized = deserialized.writeJSON();
        assertSameJsObject(json.rawString()!, actual: serialized.rawString()!)
    }
    
    func testWithFlatTypedDefinition() {
        let json = try! jsonFile("WithFlatTypedDefinition.json");
        let deserialized = try! WithFlatTypedDefinition.readJSON(json);
        
        let expected = WithFlatTypedDefinition(
            value: .MessageMember(Message(title: "title", body: "Hello, Courier.")))
        
        XCTAssertEqual(deserialized, expected)
        
        let serialized = deserialized.writeJSON();
        assertSameJsObject(json.rawString()!, actual: serialized.rawString()!)
    }
    
    func testWithPrimitives() {
        let json = try! jsonFile("WithPrimitives.json");
        let deserialized = try! WithPrimitives.readJSON(json);
        
        let expected = WithPrimitives(intField: 1, longField: 2, floatField: 3.3, doubleField: 4.4, booleanField: true, stringField: "str", bytesField: "\u{0000}\u{0001}\u{0002}")
        XCTAssertEqual(deserialized, expected)
        
        let serialized = deserialized.writeJSON();
        assertSameJsObject(json.rawString()!, actual: serialized.rawString()!)
    }
    
    func testWithPrimitivesArray() {
        let json = try! jsonFile("WithPrimitivesArray.json");
        let deserialized = try! WithPrimitivesArray.readJSON(json);
        
        let expected = WithPrimitivesArray(
            ints: [1, 2, 3],
            longs: [10, 20, 30],
            floats: [1.1, 2.2, 3.3],
            doubles: [11.1, 22.2, 33.3],
            booleans: [false, true],
            strings: ["a", "b", "c"],
            bytes: ["\u{0000}\u{0001}\u{0002}", "\u{0003}\u{0004}\u{0005}"])
        XCTAssertEqual(deserialized, expected)
        
        let serialized = deserialized.writeJSON();
        assertSameJsObject(json.rawString()!, actual: serialized.rawString()!)
    }
    
    func testWithPrimitivesMap() {
        let json = try! jsonFile("WithPrimitivesMap.json");
        let deserialized = try! WithPrimitivesMap.readJSON(json);
        
        let expected = WithPrimitivesMap(
            ints: ["a": 1, "b": 2, "c": 3],
            longs: ["a": 10, "b": 20, "c": 30],
            floats: ["a": 1.1, "b": 2.2, "c": 3.3],
            doubles: ["a": 11.1, "b": 22.2, "c": 33.3],
            booleans: ["a": true, "b": false, "c": true],
            strings: ["a": "string1", "b": "string2", "c": "string3"],
            bytes: ["a": "\u{0000}\u{0001}\u{0002}", "b": "\u{0003}\u{0004}\u{0005}", "c": "\u{0006}\u{0007}\u{8}"])
        XCTAssertEqual(deserialized, expected)
        
        let serialized = deserialized.writeJSON();
        assertSameJsObject(json.rawString()!, actual: serialized.rawString()!)
    }
    
    func testWithRecordArray() {
        let json = try! jsonFile("WithRecordArray.json");
        let deserialized = try! WithRecordArray.readJSON(json);
        
        let expected = WithRecordArray(
            empties: [Empty(), Empty(), Empty()],
            fruits: [Fruits.APPLE, Fruits.BANANA, Fruits.ORANGE])
        XCTAssertEqual(deserialized, expected)
        
        let serialized = deserialized.writeJSON();
        assertSameJsObject(json.rawString()!, actual: serialized.rawString()!)
    }
    
    func testWithTypedDefinition() {
        let json = try! jsonFile("WithTypedDefinition.json");
        let deserialized = try! WithTypedDefinition.readJSON(json);
        
        let expected = WithTypedDefinition(
            value: .MessageMember(Message(title: "title", body: "Hello, Courier.")))
        XCTAssertEqual(deserialized, expected)
        
        let serialized = deserialized.writeJSON();
        assertSameJsObject(json.rawString()!, actual: serialized.rawString()!)
    }
    
    func testWithTypedKeyMap() {
        let json = try! jsonFile("WithTypedKeyMap.json");
        let deserialized = try! WithTypedKeyMap.readJSON(json);
        
        // TODO: implement once we have typed key maps
        
        let serialized = deserialized.writeJSON();
        assertSameJsObject(json.rawString()!, actual: serialized.rawString()!)
    }
    
    func testWithUnion() {
        let json = try! jsonFile("WithUnion.json");
        let deserialized = try! WithUnion.readJSON(json);
        
        let expected = WithUnion(value: .MessageMember(Message(title: "title", body: "Hello, Courier.")))
        XCTAssertEqual(deserialized, expected)
        
        let serialized = deserialized.writeJSON();
        assertSameJsObject(json.rawString()!, actual: serialized.rawString()!)
    }
    
    func testWithComplexTypes() {
        let json = try! jsonFile("WithComplexTypes.json");
        let deserialized = try! WithComplexTypes.readJSON(json);
        
        let expected = WithComplexTypes(
            record: Simple(message: "record"),
            `enum`: Fruits.APPLE,
            union: WithComplexTypes.Union.SimpleMember(Simple(message: "union")),
            array: [1, 2],
            map: ["a": 1, "b": 2],
            complexMap: ["x": Simple(message: "complexMap")],
            custom: CustomInt(int: 100))
        XCTAssertEqual(deserialized, expected)
        
        let serialized = deserialized.writeJSON();
        assertSameJsObject(json.rawString()!, actual: serialized.rawString()!)
    }
    
    func testDateTimeCoercer() {
        let json = try! jsonFile("WithDateTime.json");
        let deserialized = try! WithDateTime.readJSON(json);
        
        let expected = WithDateTime(createdAt: NSDate(timeIntervalSince1970: 1420070400))
        XCTAssertEqual(deserialized.createdAt, expected.createdAt)
        
        let serialized = deserialized.writeJSON();
        assertSameJsObject(json.rawString()!, actual: serialized.rawString()!)
    }
    
    func testDataTreeWritable() {
        let anyObject = withComplexTypesFixture.writeData()
        if let record = anyObject["record"] as? [String: String] {
            XCTAssertEqual(record["message"], "record")
        } else {
            XCTFail()
        }
        if let `enum` = anyObject["enum"] as? String {
            XCTAssertEqual(`enum`, "APPLE")
        } else {
            XCTFail()
        }
        if let union = anyObject["union"] as? [String: AnyObject] {
            if let simple = union["org.coursera.records.test.Simple"] as? [String: String] {
                XCTAssertEqual(simple["message"], "union")
            } else {
                XCTFail()
            }
        } else {
            XCTFail()
        }
        if let array = anyObject["array"] as? [Int] {
            XCTAssertEqual(array, [1, 2])
        } else {
            XCTFail()
        }
        if let map = anyObject["map"] as? [String: Int] {
            XCTAssertEqual(map, ["a": 1, "b": 2])
        } else {
            XCTFail()
        }
        if let complexMap = anyObject["complexMap"] as? [String: AnyObject] {
            if let simple = complexMap["x"] as? [String: String] {
                XCTAssertEqual(simple["message"], "complexMap")
            } else {
                XCTFail()
            }
        } else {
            XCTFail()
        }
        if let custom = anyObject["custom"] as? Int {
            XCTAssertEqual(custom, 100)
        } else {
            XCTFail()
        }
    }
    
    func testDataTreeSerializable() {
        let data = withComplexTypesFixture.writeData()
        let roundTripped = try! WithComplexTypes.readData(data)
        XCTAssertEqual(withComplexTypesFixture, roundTripped)
    }
    
    func testNSCoding() {
        let archived = NSKeyedArchiver.archivedDataWithRootObject(withComplexTypesFixture.writeData())
        
        if let unarchived = NSKeyedUnarchiver.unarchiveObjectWithData(archived) as? [String: AnyObject]{
            let deserialized = try! WithComplexTypes.readData(unarchived)
            XCTAssertEqual(withComplexTypesFixture, deserialized)
        } else {
            XCTFail()
        }
    }
    
    func testMalformedUnionMember() {
        let json = try! jsonFile("WithUnion_malformedMember.json");
        do {
            try WithUnion.readJSON(json);
            XCTFail()
        } catch let error as ReadError {
            XCTAssertEqual(error.cause, "Wrong Type.")
        } catch {
            XCTFail()
        }
    }
    
    func testMalformedUnionTag() {
        let json = try! jsonFile("WithUnion_malformedTag.json");
        do {
            try WithUnion.readJSON(json);
            XCTFail()
        } catch let error as ReadError {
            XCTAssertEqual(error.cause, "Wrong Type.")
        } catch {
            XCTFail()
        }
    }
    
    func testWrongFieldType() {
        let json = try! jsonFile("Message_wrongFieldType.json");
        do {
            try Message.readJSON(json);
            XCTFail()
        } catch let error as ReadError {
            XCTAssertEqual(error.cause, "Wrong Type.")
        } catch {
            XCTFail()
        }
    }

    // TODO: This is lame.  I'd prefer use SwiftyJSON to do the comparison here as well, but was unable to 
    // figure out how to compare JSON correctly with it
    func assertSameJsObject(expected: String, actual: String) {
        let expectedData = expected.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        let expectedObj = try! NSJSONSerialization.JSONObjectWithData(expectedData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        
        let actualData = actual.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        let actualObj = try! NSJSONSerialization.JSONObjectWithData(actualData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        
        XCTAssertEqual(expectedObj, actualObj)
    }
    
    func jsonFile(name: String) throws -> JSON {
        let jsonString = try! String(contentsOfFile: jsonDir + name)
        let dataFromString = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        return JSON(data: dataFromString)
    }
    
    let withComplexTypesFixture = WithComplexTypes(
        record: Simple(message: "record"),
        `enum`: Fruits.APPLE,
        union: WithComplexTypes.Union.SimpleMember(Simple(message: "union")),
        array: [1, 2],
        map: ["a": 1, "b": 2],
        complexMap: ["x": Simple(message: "complexMap")],
        custom: CustomInt(int: 100))
}
