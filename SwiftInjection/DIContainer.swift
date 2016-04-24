//
//  DIContainer.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

public func inject<T>(type: T.Type) -> T {
	return DIContainer.instance.resolve(type)
}

public class DIContainer {

	public static let instance = DIContainer()
	public typealias BindingClosure = Void->AnyObject
	private var bindingDictionary = [String: DIBindingInfo]()
	
	/**
	Adds all binding from module to DIContainer
	
	- parameter module: A subclass of DIAbstractModule that implements DIModule
	*/
	public func addModule<T: DIAbstractModule where T: DIModule>(module: T) {
		module.load()
	}
	
	/**
	Returns an insance of an object based on existing bindings or will trigger fatal error if missing
	
	- parameter type: Type of object to provide
	
	- returns: An instance of class or an implementation of a protocol
	*/
	public func resolve<T>(type: T.Type) -> T {
		let typeString = String(type)
		
		if let bindingInfo = bindingDictionary[typeString] {
			let result = bindingInfo.provideInstance()
			
			if let result = result as? T {
				return result
			}
			
			fatalError("Invalid object type \(String(result.dynamicType)) for binding \(typeString)")
		}
		
		fatalError("No binding found for \(typeString)")
	}
	
	/**
	Binds a class or protocol to an instance provided through a closure
	This method is marked as internal, instead of this Subclass DIAbstractModule to implement binding
	
	- parameter type:        Protocol or a Class
	- parameter asSingleton: if true DI will use a single instance wherever injected
	- parameter closure:     closure to provide an injection object
	*/
	internal func bind<T>(type: T.Type, asSingleton: Bool = false, closure: BindingClosure) {
		let typeString = String(type)
		
		if let _ = bindingDictionary[typeString] {
			fatalError("Binding for \(typeString) already exists")
		}
		
		bindingDictionary[typeString] = DIBindingInfo(closure: closure, asSingleton: asSingleton)
	}

}
