//
//  Repository.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

public struct Repository {
	let id: Int
	let nuame: String
	let description: String
}

extension Repository: Mappable {
	public init?(json: [NSObject : AnyObject]) {
		guard	let id = json["id"] as? Int,
				let name = json["name"] as? String,
				let description = json["description"] as? String
			else { return nil }
		
		self.id = id
		self.nuame = name
		self.description = description
	}
}