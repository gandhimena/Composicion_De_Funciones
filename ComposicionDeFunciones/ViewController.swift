//
//  ViewController.swift
//  ComposicionDeFunciones
//
//  Created by spychatter mx on 1/5/18.
//  Copyright © 2018 spychatter. All rights reserved.
//
// Importante: De todos los fundamentos de la programación funcional, el más importante es la composición de funciones.
// Este principio nos permite ir componiendo funciones con funcionalidad simple para ir construyendo otras mucho mas complejas, que a su vez vamos a poder utilizar para construir nuevas exmpresiones mucho más complejas aún.
// De esta forma conseguimos tener una especie de miramide invertida, donde las capas más bajas van a estar formadas por funciones simple pero potentes y las capas mas altas van a tener las funcionalidades concretas que basemos en estas abstracciones.
// ==== Un progamador funcional bueno, consta de que sus fuciones sean facilmente componibles. ====
//

//Ejemplo Imperativo: Obtener un JSON de un API Web.

//El uso de formatter segun la documentación de apple es muy costosa, así que deberíamos reutilizarla en la medida que sea posible.

import UIKit

class ViewController: UIViewController {

	let stringJSON = "[10, 5, null, 20, 0]"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let prices = formatPrices(json: stringJSON)
		print(prices)
	}
	
	
	func formatPrices(json: String) -> [String]{
		//Serialice prices
		let prices = try! JSONSerialization.jsonObject(with: json.data(using: .utf8)!, options: []) as! [AnyObject]
		print(prices)
		
		var labels = [String]()
		
		for p in prices{
			if let price = p as? NSNumber{
				let label:String
				if price == 0{
					label = "Gratis"
				}else{
					let formatter = NumberFormatter()
					formatter.numberStyle = .currency
					formatter.locale = Locale(identifier: "es_ES")
					label = formatter.string(from: price)!
				}
				labels.append(label)
			}
		}
		return labels
	}


}

