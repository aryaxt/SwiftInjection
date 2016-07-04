//
//  ClientError.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 7/4/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

public enum ClientError: ErrorProtocol {
	case InvalidUrl
	case MissingResponse
	case MappingFaild
	case InvalidResponse
}
