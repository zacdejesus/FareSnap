//
//  GoogleMapView.swift
//  fareSnap
//
//  Created by Alejandro De Jesus on 11/11/2024.
//

import SwiftUI
import GoogleMaps

struct GoogleMapView: UIViewRepresentable {
    var gMSMapViewOptions = GMSMapViewOptions()

    func makeUIView(context: Context) -> GMSMapView {
        
        let mapView = GMSMapView(options: gMSMapViewOptions)
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // You can update your map here if necessary
    }
}
