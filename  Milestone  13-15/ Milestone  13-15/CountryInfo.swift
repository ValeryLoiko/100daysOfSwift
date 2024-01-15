//
//  CountryInfo.swift
//   Projects 13-15
//
//  Created by Diana on 11/01/2024.
//

import Foundation

struct CountryInfo {
    let flagURL: String
    let countryName: String
    let area: Double
    let population: Int
    let region: Region
    let languages: [String: String]?
    let timezones: [String]
}
