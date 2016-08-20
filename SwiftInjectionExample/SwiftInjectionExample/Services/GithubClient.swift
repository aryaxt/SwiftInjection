//
//  GithubHttpClient.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

public class GithubClient: GithubService {
	
	private let httpService: HttpService
	
	public init(httpService: HttpService) {
		self.httpService = httpService
	}
	
	public func fetchRepos(user: String, completion: @escaping (Result<[Repository]>)->Void) -> URLSessionTask {
		return httpService.fetchObjects(type: Repository.self, path: "users/\(user)/repos", method: .get, completion: completion)
	}
	
}
