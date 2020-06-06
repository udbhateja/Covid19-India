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
    typealias TestingDataServiceRequest_Callback = ( ([Cases_State]?, String?) -> () )
    
    func getFor(state: String, completion: @escaping TestingDataServiceRequest_Callback) {
        
        manager.onCompletion = {
            [weak self] response in
            
            if let json = response,
                let stateData = json["states_tested_data"] as? [[String: Any]] {
                let cases = self?.decode(json: stateData)
                print("")
            }
        }
        manager.onError = {
            error in
            completion(nil, error.localizedDescription)
        }
        manager.get()
    }
    
    private func decode(json: [[String: Any]]) -> [Cases_State]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            let data = try? decoder.decode([Cases_State].self, from: jsonData)
            return data
        }
        return nil
    }
}


// MARK: - NationalLevelData
class TestingData {
    
    private static let shared = TestingData()
    
    private var request : TestingDataServiceRequest = TestingDataServiceRequest()
    private var cases   : [Cases_National]? {
        didSet {
            totalSummary    = cases?.first
            statesData      = Array(cases?[1...] ?? [])
        }
    }
    
    var totalSummary    : Cases_National?
    var statesData      : [Cases_National]?
    
    class func get(completion: @escaping ( (TestingData) -> ()) ) {
        let shared = TestingData.shared
        guard shared.cases == nil else {
            completion(shared)
            return
        }
        
        shared.request.getFor(state: "") { (cases, error) in
            print(cases)
        }
    }
}
