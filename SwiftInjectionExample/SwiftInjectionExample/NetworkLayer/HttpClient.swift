//
//  HttpClient.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

public class HttpClient: HttpService {
	
	private let urlSession: URLSession
	private let baseUrl: String
	private let timeout: TimeInterval = 60
	
	init(baseUrl: String, urlSession: URLSession) {
		self.baseUrl = baseUrl
		self.urlSession = urlSession
	}
	
	// MARK: - Public -
	
	public func fetchObject<T: Mappable>(type: T.Type, path: String, method: HttpMethod, completion: (Result<T>)->Void) -> URLSessionDataTask {
		let request = requestWithPath(path: path, method: method)
		
		let task = urlSession.dataTask(with: request as URLRequest) { data, response, error in
			if let error = error {
				completion(Result.Failure(error))
			}
			else {
				guard let data = data else { completion(Result.Failure(ClientError.MissingResponse)); return }
				guard let dictionary = NSKeyedUnarchiver.unarchiveObject(with: data) as? [NSObject: AnyObject] else { completion(Result.Failure(ClientError.InvalidResponse)); return }
				guard let object = T(json: dictionary) else { completion(Result.Failure(ClientError.MappingFaild)); return }
				completion(Result.Success(object))
			}
		}
		
		task.resume()
		return task
	}
	
	public func fetchObjects<T: Mappable>(type: T.Type, path: String, method: HttpMethod, completion: (Result<[T]>)->Void) -> URLSessionDataTask {
		let request = requestWithPath(path: path, method: method)
		
		let task = urlSession.dataTask(with: request) { data, response, error in
			if let error = error {
				completion(Result.Failure(error))
			}
			else {
				guard let data = data else { completion(Result.Failure(ClientError.MissingResponse)); return }

				do {
					let object = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
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
	
	private func requestWithPath(path: String, method: HttpMethod) -> URLRequest {
		var request = URLRequest(
			url: NSURL(string: "\(baseUrl)/\(path)") as! URL,
			cachePolicy: .reloadIgnoringCacheData,
			timeoutInterval: timeout)
		request.httpMethod = method.rawValue
		return request
	}

}
