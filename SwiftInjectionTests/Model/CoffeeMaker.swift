//
//  CoffeeMaker.swift
//  SwiftInjection
//
//  Created by Aryan Ghassemi on 4/23/16.
//  Copyright © 2016 Aryan Ghassemi. All rights reserved.
//

public class CoffeeMaker {
	
	let heater: Heater
	let pump: Pump
	
	init(heater: Heater, pump: Pump) {
		self.heater = heater
		self.pump = pump
	}
}
