//
//  GithubHttpClient.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

public class GithubHttpClient: GithubClient {
	
	private let client: Client
	
	public init(client: Client) {
		self.client = client
	}
	
	public func fetchRepos(user: String, completion: (Result<[Repository]>)->Void) -> URLSessionTask {
		return client.fetchObjects(type: Repository.self, path: "users/\(user)/repos", method: .Get, completion: completion)
	}
	
}
