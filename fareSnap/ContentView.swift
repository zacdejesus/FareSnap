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
    
    init(viewModel: ContentViewModel = ContentViewModel(locationManager: LocationManager())) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @State private var showSheet = true
    
    var body: some View {
        ZStack {
            Map(position: $viewModel.cameraPosition) {
                Marker("You", coordinate: viewModel.userLocation)
            }
            .ignoresSafeArea()
            
            .sheet(isPresented: $showSheet) {
                SheetView()
                    .interactiveDismissDisabled(true)
                    .presentationDetents([.medium, .height(300)])
            }
        }
        .onAppear {
            // Any additional setup if needed
        }
    }
}

#Preview {
    ContentView()
}
