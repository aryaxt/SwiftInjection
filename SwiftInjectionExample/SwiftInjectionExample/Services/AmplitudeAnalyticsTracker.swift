//
//  AmplitudeAnalyticsTracker.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/24/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

open class AmplitudeAnalyticsTracker: AnalyticsTracker {
	
	open static func analyticsIdentifier() -> String {
		return "Amplitude"
	}
	
	open func trackEvent(name: String, dictionary: [NSObject : AnyObject]? = nil) {
		print("\(AmplitudeAnalyticsTracker.analyticsIdentifier()): Tracking event with name \(name)")
	}
	
}
