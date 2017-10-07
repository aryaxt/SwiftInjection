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
		container.bind { URLSession.shared }
		container.bind { UserDefaults.standard }
		container.bind(type: HttpService.self) { HttpClient(baseUrl: "https://api.github.com", urlSession: $0) }
		container.bind(type: GithubService.self) { GithubClient(httpService: $0) }
		container.bind(type: AnalyticsTracker.self, named: GoogleAnalyticsTracker.analyticsIdentifier()) { GoogleAnalyticsTracker() }
		container.bind(type: AnalyticsTracker.self, named: AmplitudeAnalyticsTracker.analyticsIdentifier()) { AmplitudeAnalyticsTracker() }
	}
	
}
