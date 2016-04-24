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
		bindingProvider.addBinding({ return 1 }, named: "name1", asSingleton: false)
		bindingProvider.addBinding({ return 2 }, named: "name2", asSingleton: false)
		XCTAssertTrue(bindingProvider.provideAllInstances().count == 2)
		XCTAssertTrue((bindingProvider.provideAllInstances() as? [Int])!.contains(1))
		XCTAssertTrue((bindingProvider.provideAllInstances() as? [Int])!.contains(2))
	}
}