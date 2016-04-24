//
//  HttpClient.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

public class HttpClient: Client {
	
	private let baseUrl: String
	private let timeout: NSTimeInterval = 60
	
	init(baseUrl: String) {
		self.baseUrl = baseUrl
	}
	
	// MARK: - Public -
	
	public func fetchObject<T: Mappable>(type type: T.Type, path: String, method: HttpMethod, completion: Result<T> -> Void) -> NSURLSessionDataTask {
		let request = requestWithPath(path, method: method)
		
		let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
			if let error = error {
				completion(Result.Failure(error))
			}
			else {
				guard let data = data else { completion(Result.Failure(ClientError.MissingResponse)); return }
				guard let dictionary = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [NSObject: AnyObject] else { completion(Result.Failure(ClientError.InvalidResponse)); return }
				guard let object = T(json: dictionary) else { completion(Result.Failure(ClientError.MappingFaild)); return }
				completion(Result.Success(object))
			}
		}
		
		task.resume()
		return task
	}
	
	public func fetchObjects<T: Mappable>(type type: T.Type, path: String, method: HttpMethod, completion: Result<[T]> -> Void) -> NSURLSessionDataTask {
		let request = requestWithPath(path, method: method)
		
		let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
			if let error = error {
				completion(Result.Failure(error))
			}
			else {
				guard let data = data else { completion(Result.Failure(ClientError.MissingResponse)); return }

				do {
					let object = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
					guard let dicts = object as? [[NSObject: AnyObject]] else { completion(Result.Failure(ClientError.InvalidResponse)); return }
					let objects = dicts.flatMap { T(json: $0) }
					completion(Result.Success(objects))
				}
				catch let error {
					completion(Result.Failure(error))
				}
			}
		}
		
		task.resume()
		return task
	}
	
	// MARK: - Private -
	
	private func requestWithPath(path: String, method: HttpMethod) -> NSURLRequest {
		let request = NSMutableURLRequest(
			URL: NSURL(string: "\(baseUrl)/\(path)")!,
			cachePolicy: .ReloadIgnoringCacheData,
			timeoutInterval: timeout)
		request.HTTPMethod = method.rawValue
		return request
		
	}

}
