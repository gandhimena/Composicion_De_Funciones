//
//  Example.swift
//  ComposicionDeFunciones
//
//  Created by spychatter mx on 1/5/18.
//  Copyright © 2018 spychatter. All rights reserved.
//


// Procedimiento: GetJSON > 	ParseJSON 		> 	 GetValidPrices
//				  string  >  string [AnyObject]	    [AnyObject] [Int]
//							 String				>               [Int]


import UIKit

enum LocalCurrency: String{
	case es = "es_ES"
	case mx = "es_MX"
	case us = "us_US"
	case uk = "us_UK"
}

class Example: UIViewController{
	
	let stringJSON = "[0,10, 5, null, 30, 60]"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		print(getPriceWithFormatter(json: stringJSON))
		
	}
	
	
	func getPriceWithFormatter(json:String) -> [String]{
		return priceFormater(prices: parseJOSN(json:json)!).map{priceFormatter(local: .mx, price: $0)}
	}
	
	
	func parseJOSN(json: String) -> [AnyObject]?{
		return try? JSONSerialization.jsonObject(with: json.data(using: .utf8)!, options: []) as! [AnyObject]
	}
	
	func priceFormater(prices: [AnyObject]) -> [Int]{
		return prices.flatMap{($0 as? NSNumber)?.intValue}
	}

	func formatter(local: LocalCurrency) -> NumberFormatter{
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale(identifier: local.rawValue)
		return formatter
	}
	
	func priceFormatter(local: LocalCurrency, price: Int) -> String{
		guard price != 0 else{ return "gratis"}
		return formatter(local: local).string(from: NSNumber(value: price))!
	}
	

	
}
