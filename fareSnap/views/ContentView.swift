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
    
    @StateObject private var viewModel: ContentViewModel
    @State private var showSheet = true
    
    init(viewModel: ContentViewModel = ContentViewModel(locationManager: LocationManager())) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Map(position: $viewModel.cameraPosition) {
                Marker("", coordinate: viewModel.userLocation)
            }
            .ignoresSafeArea()
            
            .sheet(isPresented: $showSheet) {
                RideDestinationInputView()
                    .interactiveDismissDisabled(true)
                    .presentationDetents([.medium, .height(300)])
            }
        }
    }
}

#Preview {
    ContentView()
}
