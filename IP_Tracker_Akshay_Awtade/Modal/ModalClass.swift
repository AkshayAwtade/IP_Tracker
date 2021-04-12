//
//  ModalClass.swift
//  IP_Tracker_Akshay_Awtade
//
//  Created by Akshay Awtade on 01/04/21.
//  Copyright © 2021 Akshay Awtade. All rights reserved.
//

import Foundation

// MARK: - Main Response
struct MainResponse: Codable {
    let ip: String
    let location: Location
    let welcomeAs: As
    let isp: String
    let proxy: Proxy

// coding keys for main Response 
    enum CodingKeys: String, CodingKey {
        case ip, location
        case welcomeAs = "as"
        case isp, proxy
    }
}

//MARK: - Location

struct Location: Codable {
    let country, region, city: String
    let lat, lng: Double
    let postalCode, timezone: String
    let geonameId: Int

}

// MARK: - Proxy
struct Proxy: Codable {
    let proxy, vpn, tor: Bool
}

// MARK: - As
struct As: Codable {
    let asn: Int
    let name, route: String
    let domain: String
    let type: String
}
