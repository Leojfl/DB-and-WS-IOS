//
//  FormDBAndWSTests.swift
//  FormDBAndWSTests
//
//  Created by Leonardo Flores Lopez on 22/01/21.
//

import XCTest
@testable import FormDBAndWS

class FormDBAndWSTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFunctionsPerson() throws {
        let person = Person(name: "Test",lastName: "Flores",email: "test@test.com", age: 18, gender: 1, weight: 60, height: 1.60)
        
        //test method calculeIMC
        assert(person.calculeIMC() == 0)
        person.setWeight(weight: 40)
        assert(person.calculeIMC() == -1)
        person.setWeight(weight: 80)
        assert(person.calculeIMC() == 1)
        
        //test method isAdult if the person is adult
        assert(person.isAdult())
        person.setAge(age: 15)
        assert(!person.isAdult())
        assert(person.getNSS() != Person.generateNSS())
    }

}
