//
//  GithubClient.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

public protocol GithubService {
	@discardableResult func fetchRepos(user: String, completion: @escaping (Result<[Repository]>)->Void) -> URLSessionTask
}
