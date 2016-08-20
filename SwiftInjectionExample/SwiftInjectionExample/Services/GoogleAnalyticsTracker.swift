//
//  GoogleAnalyticsTracker.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/24/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

open class GoogleAnalyticsTracker: AnalyticsTracker {
	
	open static func analyticsIdentifier() -> String {
		return "GoogleAnalytics"
	}
	
	open func trackEvent(name: String, dictionary: [NSObject : AnyObject]? = nil) {
		print("\(GoogleAnalyticsTracker.analyticsIdentifier()): Tracking event with name \(name)")
	}
	
}
