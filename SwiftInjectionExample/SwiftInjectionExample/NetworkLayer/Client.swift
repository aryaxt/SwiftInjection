//
//  Client.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

import Foundation

public enum HttpMethod: String {
	case Get	= "GET"
	case Post	= "POST"
	case Put	= "PUT"
	case Delete = "DELETE"
}

public enum ClientError: ErrorProtocol {
	case InvalidUrl
	case MissingResponse
	case MappingFaild
	case InvalidResponse
}

public protocol Client {
	func fetchObject<T: Mappable>(type: T.Type, path: String, method: HttpMethod, completion: (Result<T>)->Void) -> URLSessionDataTask
	func fetchObjects<T: Mappable>(type: T.Type, path: String, method: HttpMethod, completion: (Result<[T]>)->Void) -> URLSessionDataTask
}
