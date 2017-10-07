//
//  DIContainer.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

public func inject<T>(named: String? = nil) -> T {
	return DIContainer.instance.resolve(type: T.self)
}

public func injectAll<T>() -> [T] {
	return DIContainer.instance.resolveAll(type: T.self)
}

public class DIContainer {

	public static let instance = DIContainer()
	private var bindingDictionary = [String: DIBindingProvider]()
	
	/**
	Adds all binding from module to DIContainer
	
	- parameter module: A subclass of DIAbstractModule that implements DIModule
	*/
	public func addModule<T: DIModule>(_ module: T) {
		module.load(container: self)
	}
	
	/**
	Returns an insance of an object based on existing bindings or will trigger fatal error if missing
	
	- parameter type: Type of object to provide
	
	- returns: An instance of class or an implementation of a protocol
	*/
	public func resolve<T>(type: T.Type = T.self, named: String? = nil) -> T {
		let typeString = String(describing: type)
		guard let bindingProvider = bindingDictionary[typeString] else { fatalError("No binding found for \(typeString)") }
		let result = bindingProvider.provideInstance(named: named)
		
		guard
			let finalResult = result as? T
			else { fatalError("Invalid object type \(String(describing: Swift.type(of: result))) for binding \(typeString)") }
		
		return finalResult
	}
	
	/**
	Returns all instances that were bound to a protocol
	
	- parameter type: a protocol or a base class
	
	- returns: an array of implementations
	*/
	public func resolveAll<T>(type: T.Type = T.self) -> [T] {
		let typeString = String(describing: type)
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
	public func bind<T>(type: T.Type = T.self, named: String? = nil, asSingleton: Bool = false, closure: @escaping (())->T) {
		let newClosure: ()->T = { return closure(()) }
		_bind(type: type, named: named, asSingleton: asSingleton, closure: newClosure)
	}
	
	/**
	Binds a class/struct or protocol to an instance provided through a closure
	This method allows having arguments in the closure, the arguments are dependencies, and will be resolved and passed to the closire
	
	- parameter type:        Protocol or a Class
	- parameter named:		 A named dependency
	- parameter asSingleton: if true DI will use a single instance wherever injected
	- parameter closure:     closure to provide an injection object
	*/
	public func bind<T, A>(type: T.Type = T.self, named: String? = nil, asSingleton: Bool = false, closure: @escaping ((A))->T) {
		let newClosure: ()-> T = {
			let a: A = self.resolve()
			return closure((a))
		}
		
		_bind(type: type, named: named, asSingleton: asSingleton, closure: newClosure)
	}
	
	public func bind<T, A, B>(type: T.Type = T.self, named: String? = nil, asSingleton: Bool = false, closure: @escaping ((A, B))->T) {
		let newClosure: ()-> T = {
			let a: A = self.resolve()
			let b: B = self.resolve()
			return closure((a, b))
		}
		
		_bind(type: type, named: named, asSingleton: asSingleton, closure: newClosure)
	}
	
	public func bind<T, A, B, C>(type: T.Type = T.self, named: String? = nil, asSingleton: Bool = false, closure: @escaping ((A, B, C))->T) {
		let newClosure: ()-> T = {
			let a: A = self.resolve()
			let b: B = self.resolve()
			let c: C = self.resolve()
			return closure((a, b, c))
		}
		
		_bind(type: type, named: named, asSingleton: asSingleton, closure: newClosure)
	}
	
	public func bind<T, A, B, C, D>(type: T.Type = T.self, named: String? = nil, asSingleton: Bool = false, closure: @escaping ((A, B, C, D))->T) {
		let newClosure: ()-> T = {
			let a: A = self.resolve()
			let b: B = self.resolve()
			let c: C = self.resolve()
			let d: D = self.resolve()
			return closure((a, b, c, d))
		}
		
		_bind(type: type, named: named, asSingleton: asSingleton, closure: newClosure)
	}
	
	public func bind<T, A, B, C, D, E>(type: T.Type = T.self, named: String? = nil, asSingleton: Bool = false, closure: @escaping ((A, B, C, D, E))->T) {
		let newClosure: ()-> T = {
			let a: A = self.resolve()
			let b: B = self.resolve()
			let c: C = self.resolve()
			let d: D = self.resolve()
			let e: E = self.resolve()
			return closure((a, b, c, d, e))
		}
		
		_bind(type: type, named: named, asSingleton: asSingleton, closure: newClosure)
	}
	
	public func bind<T, A, B, C, D, E, F>(type: T.Type = T.self, named: String? = nil, asSingleton: Bool = false, closure: @escaping ((A, B, C, D, E, F))->T) {
		let newClosure: ()-> T = {
			let a: A = self.resolve()
			let b: B = self.resolve()
			let c: C = self.resolve()
			let d: D = self.resolve()
			let e: E = self.resolve()
			let f: F = self.resolve()
			return closure((a, b, c, d, e, f))
		}
		
		_bind(type: type, named: named, asSingleton: asSingleton, closure: newClosure)
	}
	
	// MARK: - Private -

	public func _bind<T>(type: T.Type, named: String? = nil, asSingleton: Bool = false, closure: @escaping ()->T) {
		let typeString = String(describing: type)
		let bindingProvider = bindingDictionary[typeString] ?? DIBindingProvider()
		bindingDictionary[typeString] = bindingProvider
		bindingProvider.addBinding(closure: closure, named: named, asSingleton: asSingleton)
	}
}
