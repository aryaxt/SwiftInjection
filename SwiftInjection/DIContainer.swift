//
//  DIContainer.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

public func inject<T>(type: T.Type, named: String? = nil) -> T {
	return DIContainer.instance.resolve(type: type)
}

public func injectAll<T>(type: T.Type) -> [T] {
	return DIContainer.instance.resolveAll(type: type)
}

public func inject(into: NSObject) {
	
}

public class DIContainer {

	public static let instance = DIContainer()
	public typealias BindingClosure = (Void)->Any
	private var bindingDictionary = [String: DIBindingProvider]()
	
	/**
	Adds all binding from module to DIContainer
	
	- parameter module: A subclass of DIAbstractModule that implements DIModule
	*/
	public func addModule<T: DIModule>(module: T) {
		module.load(container: self)
	}
	
	/**
	Returns an insance of an object based on existing bindings or will trigger fatal error if missing
	
	- parameter type: Type of object to provide
	
	- returns: An instance of class or an implementation of a protocol
	*/
	public func resolve<T>(type: T.Type, named: String? = nil) -> T {
		let typeString = String(type)
		guard let bindingProvider = bindingDictionary[typeString] else { fatalError("No binding found for \(typeString)") }
		let result = bindingProvider.provideInstance(named: named)
		
		guard
			let finalResult = result as? T
			else { fatalError("Invalid object type \(String(result.dynamicType)) for binding \(typeString)") }
		
		return finalResult
	}
	
	/**
	Returns all instances that were bound to a protocol
	
	- parameter type: a protocol or a base class
	
	- returns: an array of implementations
	*/
	public func resolveAll<T>(type: T.Type) -> [T] {
		let typeString = String(type)
		guard let bindingProvider = bindingDictionary[typeString] else { fatalError("No binding found for \(typeString)") }
		return bindingProvider.provideAllInstances().flatMap { $0 as? T }
	}
	
	/**
	Binds a class/struct or protocol to an instance provided through a closure
	
	- parameter type:        Protocol or a Class
	- parameter named:		 A named dependency
	- parameter asSingleton: if true DI will use a single instance wherever injected
	- parameter closure:     closure to provide an injection object
	*/
	public func bind<T>(type: T.Type, named: String? = nil, asSingleton: Bool = false, closure: BindingClosure) {
		let typeString = String(type)
		let bindingProvider = bindingDictionary[typeString] ?? DIBindingProvider()
		bindingDictionary[typeString] = bindingProvider
		bindingProvider.addBinding(closure: closure, named: named, asSingleton: asSingleton)
	}

}
