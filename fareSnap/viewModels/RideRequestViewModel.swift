//
//  RideRequestViewModel.swift
//  fareSnap
//
//  Created by Alejandro De Jesus on 18/12/2024.
//

import Foundation
import MapKit
import UberRides

class RideRequestViewModel: ObservableObject {
    @Published var pickupLocation: String = ""
    @Published var dropoffLocation: String = ""
    @Published var pickupCoordinate: CLLocationCoordinate2D?
    @Published var dropoffCoordinate: CLLocationCoordinate2D?
    @Published var errorMessage: String?
    @Published var rideParameters: RideParameters?
    
    private let builder = RideParametersBuilder()
    
    func updateLocation(isPickup: Bool) {
        let address = isPickup ? pickupLocation : dropoffLocation
        fetchCoordinates(for: address) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let location):
                    if isPickup {
                        self.pickupCoordinate = location.coordinate
                    } else {
                        self.dropoffCoordinate = location.coordinate
                    }
                    self.updateRideParameters()
                case .failure(let error):
                    self.errorMessage = "Error fetching coordinates: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func updateRideParameters() {
        if let pickup = pickupCoordinate {
            builder.pickupLocation = CLLocation(latitude: pickup.latitude, longitude: pickup.longitude)
            builder.pickupNickname = "Pickup Location"
        }
        
        if let dropoff = dropoffCoordinate {
            builder.dropoffLocation = CLLocation(latitude: dropoff.latitude, longitude: dropoff.longitude)
            builder.dropoffNickname = "Dropoff Location"
        }
        
        rideParameters = builder.build()
    }
    
    private func fetchCoordinates(for address: String, completion: @escaping (Result<CLLocation, Error>) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let location = placemarks?.first?.location else {
                completion(.failure(NSError(domain: "No location found", code: 0, userInfo: nil)))
                return
            }
            completion(.success(location))
        }
    }
}
