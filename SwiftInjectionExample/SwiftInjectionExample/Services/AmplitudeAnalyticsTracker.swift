//
//  AmplitudeAnalyticsTracker.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/24/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

public class AmplitudeAnalyticsTracker: AnalyticsTracker {
	
	public static func analyticsIdentifier() -> String {
		return "Amplitude"
	}
	
	public func trackEvent(name: String, dictionary: [NSObject : AnyObject]? = nil) {
		print("\(AmplitudeAnalyticsTracker.analyticsIdentifier()): Tracking event with name \(name)")
	}
	
}
