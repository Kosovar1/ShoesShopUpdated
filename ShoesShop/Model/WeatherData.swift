//
//  WeatherData.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 21/05/2023.
//

import Foundation
import UIKit


struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}
struct Main: Codable {
    let temp: Double
}
struct Weather: Codable {
    let id: Int
}


let myDouble = 3.14
//
