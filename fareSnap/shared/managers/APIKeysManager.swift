//
//  APIKeysManager.swift
//  fareSnap
//
//  Created by Alejandro De Jesus on 05/12/2024.
//

import Foundation

class APIKeysManager {
    
    func loadAPIKeys() -> [String: String]? {
        
        guard let url = Bundle.main.url(forResource: "APIKeys", withExtension: "plist") else {
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let apiKeys = try PropertyListDecoder().decode([String: String].self, from: data)
            return apiKeys
        } catch {
            return nil
        }
    }
    
}
