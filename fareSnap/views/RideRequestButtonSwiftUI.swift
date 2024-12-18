import SwiftUI
import UberRides
import CoreLocation

struct RideRequestButtonSwiftUI: UIViewRepresentable {
    @ObservedObject var viewModel: RideRequestViewModel
    
    func makeUIView(context: Context) -> RideRequestButton {
        let button = RideRequestButton()
        updateButton(button)
        return button
    }

    func updateUIView(_ uiView: RideRequestButton, context: Context) {
        updateButton(uiView)
    }

    private func updateButton(_ button: RideRequestButton) {
        if let rideParameters = viewModel.rideParameters {
            button.rideParameters = rideParameters
        }
    }
}

