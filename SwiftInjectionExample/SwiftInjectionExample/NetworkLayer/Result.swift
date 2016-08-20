//
//  Result.swift
//  SwiftInjectionExample
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

public enum Result<T> {
	case success(T)
	case failure(Error)
	
	public var isError: Bool {
		switch self {
		case .success(_):
			return false
		case .failure(_):
			return true
		}
	}
}
