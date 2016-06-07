//
//  DIBindingProviderTests.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/24/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import XCTest
@testable import SwiftInjection

class DIBindingProviderTests: XCTestCase {
	
	var bindingProvider = DIBindingProvider()
	
	override func setUp() {
		super.setUp()
		bindingProvider = DIBindingProvider()
	}
	
	func testAddBindingShouldStoreTheCorrectBindingWithName() {
		let value = "asdasd"
		let bindingName = "bindingNumber1"
		bindingProvider.addBinding({ return value }, named: bindingName, asSingleton: false)
		XCTAssertTrue(bindingProvider.provideInstance(bindingName) as? String == value)
	}
	
	func testprovideAllInstancesShouldReturnAllBindings() {
		bindingProvider.addBinding({ return 100 }, named: "name1", asSingleton: false)
		bindingProvider.addBinding({ return 200 }, named: "name2", asSingleton: false)
		XCTAssertTrue(bindingProvider.provideAllInstances().count == 2)
        
        let allNumbers = bindingProvider.provideAllInstances().flatMap { $0 as? Int }
		XCTAssertTrue(allNumbers.contains(100))
		XCTAssertTrue(allNumbers.contains(200))
	}
}