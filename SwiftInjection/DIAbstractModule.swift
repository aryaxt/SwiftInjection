//
//  DIAbstractModule.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

public class DIAbstractModule {
	
	public typealias BindingClosure = Void->AnyObject
	
	public init() { }
	
	public func bind<T>(type: T.Type, asSingleton: Bool = false, closure: BindingClosure) {
		DIContainer.instance.bind(type, asSingleton: asSingleton, closure: closure)
	}
	
}
