//
//  GithubClient.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

public protocol GithubClient {
	@discardableResult func fetchRepos(user: String, completion: (Result<[Repository]>)->Void) -> URLSessionTask
}
