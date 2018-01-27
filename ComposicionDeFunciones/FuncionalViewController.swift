//
//  FuncionalViewController.swift
//  ComposicionDeFunciones
//
//  Created by spychatter mx on 1/5/18.
//  Copyright © 2018 spychatter. All rights reserved.
//
// Procedimiento: GetJSON > 	ParseJSON 		> 		   GetValidPrices        >    		formatAll
//				  string  >  string -> [AnyObject]	    [AnyObject] -> [Int]			[Int] -> [String]
//							 String								>               					[String]
//Genericos							T								->		U			U		->		V

// Lo que hemos hecho hasta ahora es modularizar nuestras funciones pero falta componerlas
import UIKit

infix operator |> : AdditionPrecedence
//func |> <T,U,V>(paso1: @escaping(T) -> U, paso2: @escaping(U) -> V) -> (T)->V {
//	return { paso2(paso1($0)) }
//}


func |> <T,U,V>(paso1: @escaping(T) -> U, paso2: @escaping(U) -> V) -> (T)->V {
	return { paso2(paso1($0)) }
}

enum LocaleFormatter: String {
	case ES = "es_ES"
	case US = "us_US"
	case UK = "uk_UK"
}

class FunctionalViewController: UIViewController{
	
	let stringJSON = "[10, 5, null, 20, 0]"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
//		let typeCurrency = formatAll(locale: .ES)
//		let formatPricesCombinado = (parseJSON |> getValidPrices |> typeCurrency)
//		print(formatPricesCombinado(stringJSON))
	}
	
	
	//MARK: Paso 1
	//Nivel 1
	func parseJSON(json:String) -> [AnyObject]{
		return try! JSONSerialization.jsonObject(with: json.data(using: .utf8)!, options: []) as! [AnyObject]
	}
	
	func getValidPrices(values: [AnyObject]) -> [Int]{
		return values.flatMap{($0 as? NSNumber)?.intValue}
	}
	
	func getFormatter(locale:LocaleFormatter) -> NumberFormatter{
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.locale = Locale(identifier: locale.rawValue)
		return formatter
	}
	
	func formatPrices(locale:LocaleFormatter) -> (Int) -> String{
		return{
			guard $0 != 0 else { return "Gratis"}
			return self.getFormatter(locale: LocaleFormatter(rawValue: locale.rawValue)!).string(from: NSNumber(value: $0))!
		}
		
	}
	
	func formatAll(locale: LocaleFormatter) -> ([Int])-> [String]{
		return{
			$0.map(self.formatPrices(locale: locale))
		}
		
	}
	
	/*
	//Nivel 2 - combinar
	func parseAndGetValidPrices(json: String) -> [Int]{
	let pricesConCombinar = combina(paso1: parseJSON, paso2: getValidPrices)
	return pricesConCombinar(json) //getValidPrices(values: parseJSON(json: json))
	}
	
	//Nivel 3 - combinar con genericos
	func formatPrice(json:String) -> [String]{
	let pricesToString = combina(paso1: parseAndGetValidPrices, paso2: formatAll)
	return pricesToString(json)//formatAll(prices: parseAndGetValidPrices(json: json))
	}
	*/
	
	//Nivel 4
	func combina <T,U,V>(paso1: @escaping(T) -> U, paso2: @escaping(U) -> V) -> (T)->V {
		return { paso2(paso1($0)) }
}
}




