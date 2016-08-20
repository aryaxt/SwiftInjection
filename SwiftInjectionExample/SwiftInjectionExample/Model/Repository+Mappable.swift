//
//  Repository+Mappable.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 7/4/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

extension Repository: Mappable {
	
	public init?(json: [NSObject : AnyObject]) {
		self.id = 1
		self.nuame = "name"
		self.description = "desc"
	}
	
}
