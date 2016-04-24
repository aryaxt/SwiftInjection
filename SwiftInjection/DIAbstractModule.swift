//
//  DIAbstractModule.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

public class DIAbstractModule {
	
	public init() { }
	
	public func bind<T>(type: T.Type, named: String? = nil, asSingleton: Bool = false, closure: Void->AnyObject) {
		DIContainer.instance.bind(type, named: named, asSingleton: asSingleton, closure: closure)
	}
	
}
