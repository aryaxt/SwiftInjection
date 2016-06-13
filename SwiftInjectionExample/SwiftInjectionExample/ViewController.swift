//
//  ViewController.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import UIKit
import SwiftInjection

class ViewController: UIViewController {
	
	let userDefaults = inject(type: UserDefaults.self)
	let githubClient = inject(type: GithubClient.self)
	let analyticsTrackers = injectAll(type: AnalyticsTracker.self)

	override func viewDidLoad() {
		super.viewDidLoad()
		
		analyticsTrackers.forEach { $0.trackEvent(name: "ViewController", dictionary: nil)  }
		
		githubClient.fetchRepos(user: "aryaxt") {
			switch $0 {
			case .Success(let repos):
				print(repos)
				
			case .Failure(let error):
				print(error)
			}
		}
	}

}

