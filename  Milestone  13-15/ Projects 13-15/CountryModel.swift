//
//  CountryModel.swift
//   Projects 13-15
//
//  Created by Diana on 05/01/2024.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let countries = try? JSONDecoder().decode(Countries.self, from: jsonData)

// MARK: - Country
struct Country: Codable {
    let name: Name
    let tld: [String]?
    let cca2: String
    let ccn3: String?
    let cca3: String
    let independent: Bool?
    let status: Status
    let unMember: Bool
    let currencies: Currencies?
    let idd: Idd
    let capital: [String]?
    let altSpellings: [String]
    let region: Region
    let subregion: String?
    let languages: [String: String]?
    let translations: [String: Translation]
    let latlng: [Double]
    let landlocked: Bool
    let area: Double
    let demonyms: Demonyms?
    let flag: String
    let maps: Maps
    let population: Int
    let car: Car
    let timezones: [String]
    let continents: [Continent]
    let flags: Flags
    let coatOfArms: CoatOfArms
    let startOfWeek: StartOfWeek
    let capitalInfo: CapitalInfo
    let postalCode: PostalCode?
    let cioc: String?
    let borders: [String]?
    let fifa: String?
    let gini: [String: Double]?
}

// MARK: - CapitalInfo
struct CapitalInfo: Codable {
    let latlng: [Double]?
}

// MARK: - Car
struct Car: Codable {
    let signs: [String]?
    let side: Side
}

enum Side: String, Codable {
    case sideLeft = "left"
    case sideRight = "right"
}

// MARK: - CoatOfArms
struct CoatOfArms: Codable {
    let png: String?
    let svg: String?
}

enum Continent: String, Codable {
    case africa = "Africa"
    case antarctica = "Antarctica"
    case asia = "Asia"
    case europe = "Europe"
    case northAmerica = "North America"
    case oceania = "Oceania"
    case southAmerica = "South America"
}

// MARK: - Currencies
struct Currencies: Codable {
    let aud, ern, wst, mkd: Aed?
    let djf, jod, pkr, xpf: Aed?
    let eur, mru, dkk, nad: Aed?
    let zar, ghs, ssp, usd: Aed?
    let mdl, kpw, mop, scr: Aed?
    let amd, ang, xaf, syp: Aed?
    let aoa, tjs, ves, pln: Aed?
    let sar: Aed?
    let bam: BAM?
    let czk, gtq, krw, npr: Aed?
    let bwp, php, iqd, lbp: Aed?
    let bif, mnt, fok, pyg: Aed?
    let nok, nzd, gbp, ggp: Aed?
    let dzd, pab, egp, ils: Aed?
    let yer, brl, ngn, jpy: Aed?
    let tzs, kzt, shp, lkr: Aed?
    let mad, mmk, cop, pen: Aed?
    let xof, kgs, cny, afn: Aed?
    let currenciesTRY, lrd, clp, kid: Aed?
    let cve, jep, isk, gmd: Aed?
    let vuv, uyu, omr: Aed?
    let sdg: BAM?
    let inr, lak, awg, kmf: Aed?
    let xcd, uzs, mvr, gip: Aed?
    let idr, vnd, myr, ckd: Aed?
    let szl, ugx, mga, fjd: Aed?
    let twd, pgk, rwf, cdf: Aed?
    let rsd, khr, aed, bmd: Aed?
    let cuc, cup, hkd, mur: Aed?
    let ars, nio, uah, gyd: Aed?
    let tvd, lsl, top, gel: Aed?
    let etb, dop, bzd, imp: Aed?
    let htg, bdt, kwd, jmd: Aed?
    let ron, stn, bsd, mxn: Aed?
    let tmt, srd, sek, bob: Aed?
    let mzn, mwk, all, zmw: Aed?
    let chf, qar, sbd, lyd: Aed?
    let bbd, hnl, sos, kyd: Aed?
    let kes, bhd, gnf, rub: Aed?
    let bnd, sgd, zwl, byn: Aed?
    let thb, tnd, sll, btn: Aed?
    let fkp, cad, ttd, huf: Aed?
    let crc, bgn, azn, irr: Aed?

    enum CodingKeys: String, CodingKey {
        case aud = "AUD"
        case ern = "ERN"
        case wst = "WST"
        case mkd = "MKD"
        case djf = "DJF"
        case jod = "JOD"
        case pkr = "PKR"
        case xpf = "XPF"
        case eur = "EUR"
        case mru = "MRU"
        case dkk = "DKK"
        case nad = "NAD"
        case zar = "ZAR"
        case ghs = "GHS"
        case ssp = "SSP"
        case usd = "USD"
        case mdl = "MDL"
        case kpw = "KPW"
        case mop = "MOP"
        case scr = "SCR"
        case amd = "AMD"
        case ang = "ANG"
        case xaf = "XAF"
        case syp = "SYP"
        case aoa = "AOA"
        case tjs = "TJS"
        case ves = "VES"
        case pln = "PLN"
        case sar = "SAR"
        case bam = "BAM"
        case czk = "CZK"
        case gtq = "GTQ"
        case krw = "KRW"
        case npr = "NPR"
        case bwp = "BWP"
        case php = "PHP"
        case iqd = "IQD"
        case lbp = "LBP"
        case bif = "BIF"
        case mnt = "MNT"
        case fok = "FOK"
        case pyg = "PYG"
        case nok = "NOK"
        case nzd = "NZD"
        case gbp = "GBP"
        case ggp = "GGP"
        case dzd = "DZD"
        case pab = "PAB"
        case egp = "EGP"
        case ils = "ILS"
        case yer = "YER"
        case brl = "BRL"
        case ngn = "NGN"
        case jpy = "JPY"
        case tzs = "TZS"
        case kzt = "KZT"
        case shp = "SHP"
        case lkr = "LKR"
        case mad = "MAD"
        case mmk = "MMK"
        case cop = "COP"
        case pen = "PEN"
        case xof = "XOF"
        case kgs = "KGS"
        case cny = "CNY"
        case afn = "AFN"
        case currenciesTRY = "TRY"
        case lrd = "LRD"
        case clp = "CLP"
        case kid = "KID"
        case cve = "CVE"
        case jep = "JEP"
        case isk = "ISK"
        case gmd = "GMD"
        case vuv = "VUV"
        case uyu = "UYU"
        case omr = "OMR"
        case sdg = "SDG"
        case inr = "INR"
        case lak = "LAK"
        case awg = "AWG"
        case kmf = "KMF"
        case xcd = "XCD"
        case uzs = "UZS"
        case mvr = "MVR"
        case gip = "GIP"
        case idr = "IDR"
        case vnd = "VND"
        case myr = "MYR"
        case ckd = "CKD"
        case szl = "SZL"
        case ugx = "UGX"
        case mga = "MGA"
        case fjd = "FJD"
        case twd = "TWD"
        case pgk = "PGK"
        case rwf = "RWF"
        case cdf = "CDF"
        case rsd = "RSD"
        case khr = "KHR"
        case aed = "AED"
        case bmd = "BMD"
        case cuc = "CUC"
        case cup = "CUP"
        case hkd = "HKD"
        case mur = "MUR"
        case ars = "ARS"
        case nio = "NIO"
        case uah = "UAH"
        case gyd = "GYD"
        case tvd = "TVD"
        case lsl = "LSL"
        case top = "TOP"
        case gel = "GEL"
        case etb = "ETB"
        case dop = "DOP"
        case bzd = "BZD"
        case imp = "IMP"
        case htg = "HTG"
        case bdt = "BDT"
        case kwd = "KWD"
        case jmd = "JMD"
        case ron = "RON"
        case stn = "STN"
        case bsd = "BSD"
        case mxn = "MXN"
        case tmt = "TMT"
        case srd = "SRD"
        case sek = "SEK"
        case bob = "BOB"
        case mzn = "MZN"
        case mwk = "MWK"
        case all = "ALL"
        case zmw = "ZMW"
        case chf = "CHF"
        case qar = "QAR"
        case sbd = "SBD"
        case lyd = "LYD"
        case bbd = "BBD"
        case hnl = "HNL"
        case sos = "SOS"
        case kyd = "KYD"
        case kes = "KES"
        case bhd = "BHD"
        case gnf = "GNF"
        case rub = "RUB"
        case bnd = "BND"
        case sgd = "SGD"
        case zwl = "ZWL"
        case byn = "BYN"
        case thb = "THB"
        case tnd = "TND"
        case sll = "SLL"
        case btn = "BTN"
        case fkp = "FKP"
        case cad = "CAD"
        case ttd = "TTD"
        case huf = "HUF"
        case crc = "CRC"
        case bgn = "BGN"
        case azn = "AZN"
        case irr = "IRR"
    }
}

// MARK: - Aed
struct Aed: Codable {
    let name, symbol: String
}

// MARK: - BAM
struct BAM: Codable {
    let name: String
}

// MARK: - Demonyms
struct Demonyms: Codable {
    let eng: Eng
    let fra: Eng?
}

// MARK: - Eng
struct Eng: Codable {
    let f, m: String
}

// MARK: - Flags
struct Flags: Codable {
    let png: String
    let svg: String
    let alt: String?
}

// MARK: - Idd
struct Idd: Codable {
    let root: String?
    let suffixes: [String]?
}

// MARK: - Maps
struct Maps: Codable {
    let googleMaps, openStreetMaps: String
}

// MARK: - Name
struct Name: Codable {
    let common, official: String
    let nativeName: [String: Translation]?
}

// MARK: - Translation
struct Translation: Codable {
    let official, common: String
}

// MARK: - PostalCode
struct PostalCode: Codable {
    let format: String
    let regex: String?
}

enum Region: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case antarctic = "Antarctic"
    case asia = "Asia"
    case europe = "Europe"
    case oceania = "Oceania"
}

enum StartOfWeek: String, Codable {
    case monday = "monday"
    case saturday = "saturday"
    case sunday = "sunday"
}

enum Status: String, Codable {
    case officiallyAssigned = "officially-assigned"
    case userAssigned = "user-assigned"
}

typealias Countries = [Country]
