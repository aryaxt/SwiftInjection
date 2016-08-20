//
//  AppModule.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import  Foundation
import SwiftInjection

public class AppModule: DIModule {
	
	public func load(container: DIContainer) {
		container.bind(type: URLSession.self) { URLSession.shared }
		container.bind(type: UserDefaults.self) { UserDefaults.standard }
		container.bind(type: HttpService.self) { HttpClient(baseUrl: "https://api.github.com", urlSession: container.resolve(URLSession.self)) }
		container.bind(type: GithubService.self) { GithubClient(httpService: container.resolve(HttpService.self)) }
		container.bind(type: AnalyticsTracker.self, named: GoogleAnalyticsTracker.analyticsIdentifier()) { GoogleAnalyticsTracker() }
		container.bind(type: AnalyticsTracker.self, named: AmplitudeAnalyticsTracker.analyticsIdentifier()) { AmplitudeAnalyticsTracker() }
	}
	
}
