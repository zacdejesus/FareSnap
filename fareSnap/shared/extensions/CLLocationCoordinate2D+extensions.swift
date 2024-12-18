//
//  CLLocationCoordinate2D+extensions.swift
//  fareSnap
//
//  Created by Alejandro De Jesus on 05/12/2024.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
