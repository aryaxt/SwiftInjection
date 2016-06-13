//
//  DIContainer.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

public func inject<T>(type: T.Type, named: String? = nil) -> T {
	return DIContainer.instance.resolve(type)
}

public func injectAll<T>(type: T.Type) -> [T] {
	return DIContainer.instance.resolveAll(type)
}

public class DIContainer {

	public static let instance = DIContainer()
	public typealias BindingClosure = Void->Any
	private var bindingDictionary = [String: DIBindingProvider]()
	
	/**
	Adds all binding from module to DIContainer
	
	- parameter module: A subclass of DIAbstractModule that implements DIModule
	*/
	public func addModule<T: DIModule>(module: T) {
		module.load(self)
	}
	
	/**
	Returns an insance of an object based on existing bindings or will trigger fatal error if missing
	
	- parameter type: Type of object to provide
	
	- returns: An instance of class or an implementation of a protocol
	*/
	public func resolve<T>(type: T.Type, named: String? = nil) -> T {
		let typeString = String(type)
		
		if let bindingProvider = bindingDictionary[typeString] {
			let result = bindingProvider.provideInstance(named)
			
			if let result = result as? T {
				return result
			}
			
			fatalError("Invalid object type \(String(result.dynamicType)) for binding \(typeString)")
		}
		
		fatalError("No binding found for \(typeString)")
	}
	
	/**
	Returns all instances that were bound to a protocol
	
	- parameter type: a protocol or a base class
	
	- returns: an array of implementations
	*/
	public func resolveAll<T>(type: T.Type) -> [T] {
		let typeString = String(type)
		
		if let bindingProvider = bindingDictionary[typeString] {
			let result = bindingProvider.provideAllInstances()
			// TODO: Think
			return result.flatMap { $0 as? T }
		}
		
		fatalError("No binding found for \(typeString)")
	}
	
	/**
	Binds a class or protocol to an instance provided through a closure
	
	- parameter type:        Protocol or a Class
	- parameter named:		 A named dependency
	- parameter asSingleton: if true DI will use a single instance wherever injected
	- parameter closure:     closure to provide an injection object
	*/
	public func bind<T: AnyObject>(type: T.Type, named: String? = nil, asSingleton: Bool = false, closure: BindingClosure) {
		addBinding(type, named: named, asSingleton: asSingleton, closure: closure)
	}
	
	/**
	Binds a class.struct or protocol to an instance provided through a closure
	Any can refer to structs (value based) which are not compatible with singleton
	
	- parameter type:        Protocol or a Class
	- parameter named:		 A named dependency
	- parameter closure:     closure to provide an injection object
	*/
	public func bind<T: Any>(type: T.Type, named: String? = nil, closure: BindingClosure) {
		addBinding(type, named: named, asSingleton: false, closure: closure)
	}
	
	// MARK: - Private -
	
	private func addBinding<T>(type: T.Type, named: String?, asSingleton: Bool, closure: BindingClosure) {
		let typeString = String(type)
		let bindingProvider: DIBindingProvider
		
		if let existing = bindingDictionary[typeString] {
			bindingProvider = existing
		}
		else {
			bindingProvider = DIBindingProvider()
			bindingDictionary[typeString] = bindingProvider
		}
		
		bindingProvider.addBinding(closure, named: named, asSingleton: asSingleton)
	}

}
