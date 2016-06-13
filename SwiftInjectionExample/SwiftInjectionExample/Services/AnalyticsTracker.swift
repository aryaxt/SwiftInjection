//
//  AnalyticsTracker.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/24/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

public protocol AnalyticsTracker {
	func trackEvent(name: String, dictionary: [NSObject: AnyObject]?)
	static func analyticsIdentifier() -> String
}
