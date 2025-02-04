import Foundation
import _MapKit_SwiftUI
import Combine
import MapKit

class ContentViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private var locationManager: LocationManagerProtocol
    
    @Published var userLocation = CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868)
    @Published var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    )
    
    init(locationManager: LocationManagerProtocol) {
        self.locationManager = locationManager
        self.locationManager.requestPermission()
        self.locationManager.startUpdatingLocation()
        
        self.locationManager.userLocationPublisher
            .compactMap { $0 }
            .sink { [weak self] newLocation in
                guard let self = self else { return }
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
}

