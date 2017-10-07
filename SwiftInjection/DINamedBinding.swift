//
//  DINamedBinding.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/24/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

internal class DINamedBinding {
	fileprivate let closure: ()->Any
	fileprivate let asSingleton: Bool
	fileprivate var singletonInstance: Any?
	
	init(closure: @escaping ()->Any, asSingleton: Bool) {
		self.closure = closure
		self.asSingleton = asSingleton
	}
}

extension DINamedBinding {
	func provideInstance() -> Any {
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
