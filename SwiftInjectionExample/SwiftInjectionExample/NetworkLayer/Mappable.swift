//
//  Mappable.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

public protocol Mappable {
	init?(json: [NSObject: AnyObject])
}
