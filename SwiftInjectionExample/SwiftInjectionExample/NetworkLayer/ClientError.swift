//
//  ClientError.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 7/4/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

public enum ClientError: Error {
	case invalidUrl
	case missingResponse
	case mappingFaild
	case invalidResponse
}
