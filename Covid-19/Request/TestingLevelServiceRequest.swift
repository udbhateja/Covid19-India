//
//  TestingLevelServiceRequest.swift
//  Covid-19
//
//  Created by JBhateja on 06/06/20.
//  Copyright © 2020 Sarab_Uday. All rights reserved.
//

import Foundation

class TestingDataServiceRequest {
    
    private let manager = WebServiceManager(url: WebServiceURL.testing, parameters: [:])
    typealias TestingDataServiceRequest_Callback = ( ([Stats_Test]?, String?) -> () )
    
    func get(completion: @escaping TestingDataServiceRequest_Callback) {
        
        manager.onCompletion = {
            [weak self] response in
            
            if let json = response,
                let stateData = json["states_tested_data"] as? [[String: Any]] {
                let stats = self?.decode(json: stateData)
                completion(stats, nil)
            }
        }
        manager.onError = {
            error in
            completion(nil, error.localizedDescription)
        }
        manager.get()
    }
    
    private func decode(json: [[String: Any]]) -> [Stats_Test]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            let data = try? decoder.decode([Stats_Test].self, from: jsonData)
            return data
        }
        return nil
    }
}


// MARK: - NationalLevelData
class TestingData {
    
    private static let shared = TestingData()
    
    private var request     : TestingDataServiceRequest = TestingDataServiceRequest()
    private var allStats    : [Stats_Test]?
    
    private func dataFor(state: String) -> Stats_Test?  {
        let stateStats = allStats?.filter({$0.state == state})
        return stateStats?.last
    }
    
    class func dataFor(state: String, completion: @escaping ( (Stats_Test?) -> ())) {
        let shared = TestingData.shared
        guard shared.allStats == nil else {
            completion(shared.dataFor(state: state))
            return
        }
        
        shared.request.get() { (cases, error) in
            shared.allStats = cases
            completion(shared.dataFor(state: state))
        }
    }
}
