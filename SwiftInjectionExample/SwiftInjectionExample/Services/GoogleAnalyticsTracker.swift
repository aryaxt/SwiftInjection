//
//  GoogleAnalyticsTracker.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/24/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

public class GoogleAnalyticsTracker: AnalyticsTracker {
	
	public static func analyticsIdentifier() -> String {
		return "GoogleAnalytics"
	}
	
	public func trackEvent(name name: String, dictionary: [NSObject : AnyObject]? = nil) {
		print("\(GoogleAnalyticsTracker.analyticsIdentifier()): Tracking event with name \(name)")
	}
	
}
