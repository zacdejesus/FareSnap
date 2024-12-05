//
//  SheetView.swift
//  fareSnap
//
//  Created by Alejandro De Jesus on 02/12/2024.
//

import Foundation
import SwiftUI

struct SheetView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Enter Your Destination to obtein fares")
                .font(.headline)
            
            TextField("your location", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("where are you going", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: {
                print("First Name: \(firstName), Last Name: \(lastName)")
            }) {
                Text("Get fares")
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
