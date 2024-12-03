//
//  GoogleMapView.swift
//  fareSnap
//
//  Created by Alejandro De Jesus on 11/11/2024.
//
import SwiftUI
import GoogleMaps
import CoreLocation

struct MapView: UIViewRepresentable {
    // Binding for total distance
    @Binding var totalDistance: CLLocationDistance

    // Coordinator to handle events
    class Coordinator: NSObject, CLLocationManagerDelegate {
        var mapView: GMSMapView?
        var locationManager = CLLocationManager()
        var previousLocation: CLLocation?
        var polyline: GMSPolyline?
        @Binding var totalDistance: CLLocationDistance

        init(totalDistance: Binding<CLLocationDistance>) {
            self._totalDistance = totalDistance
        }

        // Location manager delegate method
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.first else { return }

            // Calculate distance and update total distance
            if let previousLocation = self.previousLocation {
                let distance = location.distance(from: previousLocation)
                self.totalDistance += distance
            }

            // Update polyline to draw the route
            if let path = polyline?.path {
                let mutablePath = GMSMutablePath(path: path)
                mutablePath.add(location.coordinate)
                polyline?.path = mutablePath
            } else {
                let path = GMSMutablePath()
                path.add(location.coordinate)
                
                let newPolyline = GMSPolyline(path: path)
                newPolyline.strokeColor = .red
                newPolyline.strokeWidth = 5.0
                newPolyline.map = mapView
                polyline = newPolyline
            }

            // Set camera position to current location
            let zoom: Float = 18.0
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                                  longitude: location.coordinate.longitude,
                                                  zoom: zoom)
            mapView?.animate(to: camera)

            self.previousLocation = location
        }

        // Authorization status change handler
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedWhenInUse {
                locationManager.startUpdatingLocation()
                mapView?.isMyLocationEnabled = true
                mapView?.settings.myLocationButton = true
            }
        }
    }

    // Make coordinator
    func makeCoordinator() -> Coordinator {
        return Coordinator(totalDistance: $totalDistance)
    }

    // Make UIView
    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        context.coordinator.mapView = mapView

        // Request location authorization
        context.coordinator.locationManager.requestWhenInUseAuthorization()
        context.coordinator.locationManager.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {}
}
