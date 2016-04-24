//
//  AppModule.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import SwiftInjection

public class AppModule: DIAbstractModule, DIModule {
	
	public func load() {
		bind(GithubClient.self) { GithubHttpClient(baseUrl: "https://api.github.com") }
		bind(NSUserDefaults.self, asSingleton: false) { NSUserDefaults.standardUserDefaults() }
	}
	
}
