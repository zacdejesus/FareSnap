//
//  fareSnapApp.swift
//  fareSnap
//
//  Created by Alejandro De Jesus on 11/11/2024.
//

import SwiftUI
import SwiftData

@main
struct fareSnapApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    
    var sharedModelContainer: ModelContainer = {
        
        if let apiKeys = loadAPIKeys() {
            let googleAPIKey = apiKeys["GoogleMapsAPIKey"]
            print("Google API Key: \(googleAPIKey ?? "Not Found")")
        }
        
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
        
        
        func loadAPIKeys() -> [String: String]? {
            // Look for the file inside the app's main bundle

            
            if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                print("Documents directory: \(directory)")
            }
            
            if let path = Bundle.main.resourcePath {
                print("Resources path: \(path)")
            }
            
            guard let url = Bundle.main.url(forResource: "APIKeys", withExtension: "plist") else {
                print("Failed to find APIKeys.plist in the bundle")
                return nil
            }

            // Read the file data
            do {
                let data = try Data(contentsOf: url)

                // If it's a plist file, decode it
                let apiKeys = try PropertyListDecoder().decode([String: String].self, from: data)
                return apiKeys
            } catch {
                print("Error loading API keys: \(error)")
                return nil
            }
        }
    }()
    
    func loadAPIKeys() -> [String: String]? {
        // Look for the file inside the app's main bundle

        
        if let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            print("Documents directory: \(directory)")
        }
        
        if let path = Bundle.main.resourcePath {
            print("Resources path: \(path)")
        }
        
        guard let url = Bundle.main.url(forResource: "APIKeys", withExtension: "plist") else {
            print("Failed to find APIKeys.plist in the bundle")
            return nil
        }

        // Read the file data
        do {
            let data = try Data(contentsOf: url)

            // If it's a plist file, decode it
            let apiKeys = try PropertyListDecoder().decode([String: String].self, from: data)
            return apiKeys
        } catch {
            print("Error loading API keys: \(error)")
            return nil
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
