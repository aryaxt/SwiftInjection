//
//  Client.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

public protocol HttpService {
	func fetchObject<T: Mappable>(type: T.Type, path: String, method: HttpMethod, completion: @escaping (Result<T>)->Void) -> URLSessionDataTask
	func fetchObjects<T: Mappable>(type: T.Type, path: String, method: HttpMethod, completion: @escaping (Result<[T]>)->Void) -> URLSessionDataTask
}
