//
//  HttpClient.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

open class HttpClient: HttpService {
	
	private let urlSession: URLSession
	private let baseUrl: String
	private let timeout: TimeInterval = 60
	
	init(baseUrl: String, urlSession: URLSession) {
		self.baseUrl = baseUrl
		self.urlSession = urlSession
	}
	
	// MARK: - Public -
	
	public func fetchObject<T : Mappable>(type: T.Type, path: String, method: HttpMethod, completion: @escaping (Result<T>) -> Void) -> URLSessionDataTask {
		let request = requestWithPath(path: path, method: method)
		
		let task = urlSession.dataTask(with: request as URLRequest) { data, response, error in
			if let error = error {
				completion(Result.failure(error))
			}
			else {
				guard let data = data else { completion(Result.failure(ClientError.missingResponse)); return }
				guard let dictionary = NSKeyedUnarchiver.unarchiveObject(with: data) as? [NSObject: AnyObject] else { completion(Result.failure(ClientError.invalidResponse)); return }
				guard let object = T(json: dictionary) else { completion(Result.failure(ClientError.mappingFaild)); return }
				completion(Result.success(object))
			}
		}
		
		task.resume()
		return task
	}
	
	public func fetchObjects<T : Mappable>(type: T.Type, path: String, method: HttpMethod, completion: @escaping (Result<[T]>) -> Void) -> URLSessionDataTask {
		let request = requestWithPath(path: path, method: method)
		
		let task = urlSession.dataTask(with: request) { data, response, error in
			if let error = error {
				completion(Result.failure(error))
			}
			else {
				guard let data = data else { completion(Result.failure(ClientError.missingResponse)); return }
				
				do {
					let object = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
					guard let dicts = object as? [[NSObject: AnyObject]] else { completion(Result.failure(ClientError.invalidResponse)); return }
					let objects = dicts.flatMap { T(json: $0) }
					completion(Result.success(objects))
				}
				catch let error {
					completion(Result.failure(error))
				}
			}
		}
		
		task.resume()
		return task
	}
	
	// MARK: - Private -
	
	fileprivate func requestWithPath(path: String, method: HttpMethod) -> URLRequest {
		var request = URLRequest(
			url: URL(string: "\(baseUrl)/\(path)")!,
			cachePolicy: .reloadIgnoringCacheData,
			timeoutInterval: timeout)
		request.httpMethod = method.rawValue
		return request
	}

}
