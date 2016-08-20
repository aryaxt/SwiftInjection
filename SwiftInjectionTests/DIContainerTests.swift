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
	
	func testResolvingGlobalFunction() {
		DIContainer.instance.bind(type: Pump.self) { RegularPump() }
		let pump: Pump = inject()
		XCTAssertTrue(type(of: pump) == RegularPump.self)
	}
	
	func testShouldReturnCorrectImplementation() {
		container.bind(type: Pump.self) { RegularPump() }
		let instance = container.resolve(Pump.self)
		XCTAssertTrue(type(of: instance) == RegularPump.self)
	}
	
	func testShouldReturnNewInstance() {
		container.bind(type: RegularPump.self) { RegularPump() }
		let instance1 = container.resolve(RegularPump.self)
		let instance2 = container.resolve(RegularPump.self)
		XCTAssertTrue(instance1 !== instance2)
	}
	
	func testShouldReturnSameInstanceForSingleton() {
		container.bind(type: RegularPump.self, asSingleton: true) { RegularPump() }
		let instance1 = container.resolve(RegularPump.self)
		let instance2 = container.resolve(RegularPump.self)
		XCTAssertTrue(instance1 === instance2)
	}
    
    func testShouldReturnCorrectImplementationForStructs() {
        container.bind(type: SomeStruct.self) { SomeStruct() }
        let instance = container.resolve(SomeStruct.self)
        XCTAssertTrue(type(of: instance) == SomeStruct.self)
    }
	
	func testShouldReturnCorrectNamedInstance() {
		let regularIdentifier = "regular"
		let turboIdentifier = "turbo"
		container.bind(type: Pump.self, named: regularIdentifier) { RegularPump() }
		container.bind(type: Pump.self, named: turboIdentifier) { TurboPump() }
		let regular = container.resolve(Pump.self, named: regularIdentifier)
		let turbo = container.resolve(Pump.self, named: turboIdentifier)
		XCTAssert(type(of: regular) == RegularPump.self)
		XCTAssert(type(of: turbo) == TurboPump.self)
	}
	
	func testShouldReturnAllInstances() {
		let regularIdentifier = "regular"
		let turboIdentifier = "turbo"
		container.bind(type: Pump.self, named: regularIdentifier) { RegularPump() }
		container.bind(type: Pump.self, named: turboIdentifier) { TurboPump() }
		let pumps: [Pump] = container.resolveAll(type: Pump.self)
		XCTAssertTrue(pumps.count == 2)
	}
	
}
