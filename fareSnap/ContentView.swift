//
//  ContentView.swift
//  fareSnap
//
//  Created by Alejandro De Jesus on 11/11/2024.
//

import SwiftUI
import SwiftData
import MapKit

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // San Francisco, CA
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
         Map(coordinateRegion: $region)
             .ignoresSafeArea() // Makes the map occupy the full screen
     }
    
    func convertToMapPoint(coordinate: CLLocationCoordinate2D, region: MKCoordinateRegion, geometry: GeometryProxy) -> CGPoint {
        let mapRect = MKMapRect(
            origin: MKMapPoint(region.center),
            size: MKMapSize(width: region.span.longitudeDelta, height: region.span.latitudeDelta)
        )
        
        let mapPoint = MKMapPoint(coordinate)
        
        let x = (mapPoint.x - mapRect.origin.x) / mapRect.size.width * geometry.size.width
        let y = (mapPoint.y - mapRect.origin.y) / mapRect.size.height * geometry.size.height
        
        return CGPoint(x: x, y: y)
    }
    
}

struct BottomSheetView: View {
    var body: some View {
        Button("") {}
    }
}


#Preview {
    ContentView()
}
