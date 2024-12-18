//
//  SheetView.swift
//  fareSnap
//
//  Created by Alejandro De Jesus on 02/12/2024.
//

import Foundation
import SwiftUI
import CoreLocation

struct RideDestinationInputView: View {
    @StateObject private var viewModel = RideRequestViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            RideRequestButtonSwiftUI(viewModel: viewModel)
                .frame(height: 50)
                .accessibility(label: Text("Request Uber ride"))
            
            Text("Enter Your Destination to Obtain Fares")
                .font(.headline)
            
            TextField("Your location", text: $viewModel.pickupLocation)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .onChange(of: viewModel.pickupLocation) {
                    viewModel.updateLocation(isPickup: true)
                }
            
            TextField("Where are you going?", text: $viewModel.dropoffLocation)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .onChange(of: viewModel.dropoffLocation) {
                    viewModel.updateLocation(isPickup: false)
                }
            
            Button(action: {
                viewModel.updateRideParameters()
            }) {
                Text("Get Fares")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
        }
        .padding()
    }
}

#Preview {
    RideDestinationInputView()
}
