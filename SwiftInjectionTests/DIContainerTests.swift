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
		let instance: Pump = container.resolve()
		XCTAssertTrue(type(of: instance) == RegularPump.self)
	}
	
	func testShouldReturnNewInstance() {
		container.bind(type: RegularPump.self) { RegularPump() }
		let instance1: RegularPump = container.resolve()
		let instance2: RegularPump = container.resolve()
		XCTAssertTrue(instance1 !== instance2)
	}
	
	func testShouldReturnSameInstanceForSingleton() {
		container.bind(type: RegularPump.self, asSingleton: true) { RegularPump() }
		let instance1: RegularPump = container.resolve()
		let instance2: RegularPump = container.resolve()
		XCTAssertTrue(instance1 === instance2)
	}
    
    func testShouldReturnCorrectImplementationForStructs() {
        container.bind(type: SomeStruct.self) { SomeStruct() }
		let instance: SomeStruct = container.resolve()
        XCTAssertTrue(type(of: instance) == SomeStruct.self)
    }
	
	func testShouldReturnCorrectNamedInstance() {
		let regularIdentifier = "regular"
		let turboIdentifier = "turbo"
		container.bind(type: Pump.self, named: regularIdentifier) { RegularPump() }
		container.bind(type: Pump.self, named: turboIdentifier) { TurboPump() }
		let regular: Pump = container.resolve(named: regularIdentifier)
		let turbo: Pump = container.resolve(named: turboIdentifier)
		XCTAssert(type(of: regular) == RegularPump.self)
		XCTAssert(type(of: turbo) == TurboPump.self)
	}
	
	func testShouldReturnAllInstances() {
		let regularIdentifier = "regular"
		let turboIdentifier = "turbo"
		container.bind(type: Pump.self, named: regularIdentifier) { RegularPump() }
		container.bind(type: Pump.self, named: turboIdentifier) { TurboPump() }
		let pumps: [Pump] = container.resolveAll()
		XCTAssertTrue(pumps.count == 2)
	}
	
	func testShouldResolveArgumentDependencies() {
		container.bind(type: Pump.self) { RegularPump() }
		container.bind(type: Heater.self) { ElectricHeater() }
		container.bind(type: CoffeeMaker.self) { CoffeeMaker(heater: $0, pump: $1) }
		let coffeeMaker: CoffeeMaker = container.resolve()
		XCTAssertTrue(type(of: coffeeMaker.heater) == ElectricHeater.self)
		XCTAssertTrue(type(of: coffeeMaker.pump) == RegularPump.self)
	}

	func testShouldInferGenericAutomatically() {
		container.bind() { RegularPump() }
		let _: RegularPump = container.resolve()
	}
	
}
