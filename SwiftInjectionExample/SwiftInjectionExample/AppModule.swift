//
//  AppModule.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import SwiftInjection

public class AppModule: DIModule {
	
	public func load(container: DIContainer) {
		container.bind(Client.self) { HttpClient(baseUrl: "https://api.github.com") }
		container.bind(GithubClient.self) { GithubHttpClient(client: container.resolve(Client.self)) }
		container.bind(NSUserDefaults.self, asSingleton: false) { NSUserDefaults.standardUserDefaults() }
		container.bind(AnalyticsTracker.self, named: GoogleAnalyticsTracker.analyticsIdentifier()) { GoogleAnalyticsTracker() }
		container.bind(AnalyticsTracker.self, named: AmplitudeAnalyticsTracker.analyticsIdentifier()) { AmplitudeAnalyticsTracker() }
	}
	
}
