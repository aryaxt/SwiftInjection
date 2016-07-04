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
		container.bind(type: URLSession.self) { URLSession.shared() }
		container.bind(type: HttpService.self) { HttpClient(baseUrl: "https://api.github.com", urlSession: container.resolve(type: URLSession.self)) }
		container.bind(type: GithubService.self) { GithubClient(httpService: container.resolve(type: HttpService.self)) }
		container.bind(type: AnalyticsTracker.self, named: GoogleAnalyticsTracker.analyticsIdentifier()) { GoogleAnalyticsTracker() }
		container.bind(type: AnalyticsTracker.self, named: AmplitudeAnalyticsTracker.analyticsIdentifier()) { AmplitudeAnalyticsTracker() }
	}
	
}
