//
//  DIBindingInfo.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/24/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

public class DIBindingInfo {
	private let closure: Void->AnyObject
	private let asSingleton: Bool
	private var singletonInstance: AnyObject?
	
	public init(closure: Void->AnyObject, asSingleton: Bool) {
		self.closure = closure
		self.asSingleton = asSingleton
	}
}

extension DIBindingInfo {
	public func provideInstance() -> AnyObject {
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
