//
//  DINamedBindingTests.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/24/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import XCTest
@testable import SwiftInjection

class DINamedBindingTests: XCTestCase {

	func testNamedBindingShouldReturnCorrectValue() {
		let binding = DINamedBinding(closure: { return 4 }, asSingleton: false)
		XCTAssertTrue(binding.provideInstance() as? Int == 4)
	}
	
	func testNamedBindingShouldReturnDifferentInstancesForNonSingleton() {
		let binding = DINamedBinding(closure: { RegularPump() }, asSingleton: false)
		XCTAssertTrue(binding.provideInstance() as? AnyObject !== binding.provideInstance() as? AnyObject )
	}
	
	func testNamedBindingShouldReturnSameInstancesForSingleton() {
		let binding = DINamedBinding(closure: { RegularPump() }, asSingleton: true)
		XCTAssertTrue(binding.provideInstance() as? AnyObject === binding.provideInstance() as? AnyObject)
	}
	
}
