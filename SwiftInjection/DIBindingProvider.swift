//
//  DIBindingInfo.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/24/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

internal class DIBindingProvider {

	private var namedBindings = [String: DINamedBinding]()
	private static let defaultBindingName = "default"
	
	func addBinding(closure: (Void)->Any, named: String? = nil, asSingleton: Bool) {
		let named = named ?? DIBindingProvider.defaultBindingName
		namedBindings[named] = DINamedBinding(closure: closure, asSingleton: asSingleton)
	}

	func provideInstance(named: String? = nil) -> Any {
		let named = named ?? DIBindingProvider.defaultBindingName
		
		if let namedBinding = namedBindings[named] {
			return namedBinding.provideInstance()
		}
		
		fatalError("Did not find binding named \(named)")
	}
	
	func provideAllInstances() -> [Any] {
		return namedBindings.values.map { $0.provideInstance() }
	}
}

