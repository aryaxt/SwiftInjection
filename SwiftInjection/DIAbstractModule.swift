//
//  DIAbstractModule.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

public class DIAbstractModule {
	
	public init() { }
	
    /**
     Structs are value based and they are not compatible with singleton
     So we create an overload of bind method that takes Any but doesn't suppport singletons
     In order to use singleton use the other bind method that takes AnyObject instead of Any
     */
    public func bind<T: Any>(type: T.Type, named: String? = nil, closure: Void->T) {
        DIContainer.instance.bind(type, named: named, asSingleton: false, closure: closure)
    }
    
    public func bind<T: AnyObject>(type: T.Type, named: String? = nil, asSingleton: Bool = false, closure: Void->T) {
        DIContainer.instance.bind(type, named: named, asSingleton: asSingleton, closure: closure)
    }
	
}
