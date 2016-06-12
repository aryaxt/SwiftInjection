//
//  AppModule.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import SwiftInjection

public class AppModule: DIAbstractModule, DIModule {
	
	public func load(container container: DIContainer) {
		bind(Client.self) { HttpClient(baseUrl: "https://api.github.com") }
		bind(GithubClient.self) { GithubHttpClient(client: container.resolve(Client.self)) }
		bind(NSUserDefaults.self, asSingleton: false) { NSUserDefaults.standardUserDefaults() }
		bind(AnalyticsTracker.self, named: GoogleAnalyticsTracker.analyticsIdentifier()) { GoogleAnalyticsTracker() }
		bind(AnalyticsTracker.self, named: AmplitudeAnalyticsTracker.analyticsIdentifier()) { AmplitudeAnalyticsTracker() }
	}
	
}
