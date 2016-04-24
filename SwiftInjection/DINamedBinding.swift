//
//  DINamedBinding.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/24/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

internal class DINamedBinding {
	private let closure: Void->AnyObject
	private let asSingleton: Bool
	private var singletonInstance: AnyObject?
	
	init(closure: Void->AnyObject, asSingleton: Bool) {
		self.closure = closure
		self.asSingleton = asSingleton
	}
}

extension DINamedBinding {
	func provideInstance() -> AnyObject {
		if asSingleton {
			if let singletonInstance = singletonInstance {
				return singletonInstance
			}
			else {
				let instance = closure()
				singletonInstance = instance
				return instance
			}
		}
		else {
			return closure()
		}
	}
}
