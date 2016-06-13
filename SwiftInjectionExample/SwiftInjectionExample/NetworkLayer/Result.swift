//
//  Result.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

public enum Result<T> {
	case Success(T)
	case Failure(ErrorProtocol)
	
	public var isError: Bool {
		switch self {
		case .Success(_):
			return false
		case .Failure(_):
			return true
		}
	}
}
