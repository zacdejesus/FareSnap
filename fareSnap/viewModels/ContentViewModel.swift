//
//  ContentViewModel.swift
//  fareSnap
//
//  Created by Alejandro De Jesus on 05/12/2024.
//

import Foundation
import MapKit
import _MapKit_SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    @Published var userLocation = CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868)
    @Published var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    )
    
    private var locationManager: LocationManager
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        self.locationManager.requestPermission()
        self.locationManager.startUpdatingLocation()
        
        self.locationManager.$userLocation
            .sink { [weak self] newLocation in
                guard let self = self, let newLocation = newLocation else { return }
                self.userLocation = newLocation
                self.updateCameraPosition(for: newLocation)
            }
            .store(in: &cancellables)
    }
    
    private func updateCameraPosition(for location: CLLocationCoordinate2D) {
        cameraPosition = .region(
            MKCoordinateRegion(
                center: location,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        )
    }
    
    private var cancellables = Set<AnyCancellable>()
}
