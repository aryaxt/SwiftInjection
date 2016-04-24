//
//  DIContainerTests.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import XCTest
@testable import SwiftInjection

class DIContainerTests: XCTestCase {
	
	var container = DIContainer()
	
	override func setUp() {
		super.setUp()
		container = DIContainer()
	}

	func testShouldReturnCorrectImplementation() {
		container.bind(Pump.self) { RegularPump() }
		let instance = container.resolve(Pump.self)
		XCTAssertTrue(instance.dynamicType == RegularPump.self)
	}
	
	func testShouldReturnNewInstance() {
		container.bind(RegularPump.self) { RegularPump() }
		let instance1 = container.resolve(RegularPump.self)
		let instance2 = container.resolve(RegularPump.self)
		XCTAssertTrue(instance1 !== instance2)
	}
	
	func testShouldReturnSameInstanceForSingleton() {
		container.bind(RegularPump.self, asSingleton: true) { RegularPump() }
		let instance1 = container.resolve(RegularPump.self)
		let instance2 = container.resolve(RegularPump.self)
		XCTAssertTrue(instance1 === instance2)
	}
	
	func testShouldReturnCorrectNamedInstance() {
		let regularIdentifier = "regular"
		let turboIdentifier = "turbo"
		container.bind(Pump.self, named: regularIdentifier) { RegularPump() }
		container.bind(Pump.self, named: turboIdentifier) { TurboPump() }
		let regular = container.resolve(Pump.self, named: regularIdentifier)
		let turbo = container.resolve(Pump.self, named: turboIdentifier)
		XCTAssert(regular.dynamicType == RegularPump.self)
		XCTAssert(turbo.dynamicType == TurboPump.self)
	}
	
	func testShouldReturnAllInstances() {
		let regularIdentifier = "regular"
		let turboIdentifier = "turbo"
		container.bind(Pump.self, named: regularIdentifier) { RegularPump() }
		container.bind(Pump.self, named: turboIdentifier) { TurboPump() }
		let pumps: [Pump] = container.resolveAll(Pump.self)
		XCTAssertTrue(pumps.count == 2)
	}
	
}