//
//  DIBindingInfo.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/24/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

private class DINamedBinding {
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

public class DIBindingProvider {

	private var namedBindings = [String: DINamedBinding]()
	private static let defaultBindingName = "default"
	
	public func addBinding(closure: Void->AnyObject, named: String? = nil, asSingleton: Bool) {
		let named = named ?? DIBindingProvider.defaultBindingName
		namedBindings[named] = DINamedBinding(closure: closure, asSingleton: asSingleton)
	}

	public func provideInstance(named: String? = nil) -> AnyObject {
		let named = named ?? DIBindingProvider.defaultBindingName
		
		if let namedBinding = namedBindings[named] {
			return namedBinding.provideInstance()
		}
		
		fatalError("Did not find binding named \(named)")
	}
	
	public func provideAllInstances() -> [AnyObject] {
		return Array(namedBindings.values).map { $0.provideInstance() }
	}
}

