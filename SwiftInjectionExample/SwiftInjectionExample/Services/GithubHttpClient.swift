//
//  GithubHttpClient.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

public class GithubHttpClient: HttpClient, GithubClient {
	
	public func fetchRepos(user user: String, completion: Result<[Repository]>->Void) -> NSURLSessionTask {
		return fetchObjects(type: Repository.self, path: "users/\(user)/repos", method: .Get, completion: completion)
	}
	
}