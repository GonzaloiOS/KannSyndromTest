//
//  StorageDataManager.swift
//  S4NTest
//
//  Created by Gonzalinho on 2/12/19.
//  Copyright © 2019 Gonzalinho. All rights reserved.
//

import Foundation

typealias StorageDataManagerFetchDataCompletionClosure = (_ percentages: [Int]?) -> Void

struct StorageDataManagerConfig {
    static let resultsKeyString = "testResultsSaved"
}

class StorageDataManager {
    
    static func saveNewTest(percentage: Int) {
        
        fetchPreviousTests { (percentages) in
            let defaults = UserDefaults.standard
            
            guard var percentages = percentages else {
                let results = [percentage]
                defaults.set(results, forKey: StorageDataManagerConfig.resultsKeyString)
                
                return
            }
            
            percentages.append(percentage)
            defaults.set(percentages, forKey: StorageDataManagerConfig.resultsKeyString)
        }
    }
    
    static func fetchPreviousTests(completion: @escaping StorageDataManagerFetchDataCompletionClosure) {
        
        let defaults = UserDefaults.standard
        
        DispatchQueue.main.async {
            guard let percentages = defaults.object(forKey: StorageDataManagerConfig.resultsKeyString) as? [Int] else {
                completion(nil)
                return
            }
            
            completion(percentages)
        }
    }
}
