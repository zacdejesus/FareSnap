//
//  FareEstimateResponse.swift
//  fareSnap
//
//  Created by Alejandro De Jesus on 10/12/2024.
//

import Foundation

struct FareEstimateResponse: Decodable {
    let prices: [Price]
    
    struct Price: Decodable {
        let estimate: String
    }
}
