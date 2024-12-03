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
            Text("Enter Your Details")
                .font(.headline)
            
            TextField("First Name", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Last Name", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: {
                print("First Name: \(firstName), Last Name: \(lastName)")
            }) {
                Text("Submit")
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
