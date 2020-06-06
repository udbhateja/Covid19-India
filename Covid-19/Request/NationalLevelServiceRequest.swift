//
//  NationalLevelServiceRequest.swift
//  Covid-19
//
//  Created by JBhateja on 02/05/20.
//  Copyright © 2020 Sarab_Uday. All rights reserved.
//

import Foundation

// MARK: - Request
class NationalLevelServiceRequest {
    
    typealias NationalLevelServiceRequest_Callback = ( ([Cases_National]?, String?) -> () )
    private let manager = WebServiceManager(url: WebServiceURL.nationalLevel, parameters: [:])
    
    func get(completion: @escaping NationalLevelServiceRequest_Callback) {
        
        manager.onCompletion = {
            [weak self] response in
            
            if let json = response,
                let stateData = json["statewise"] as? [[String: Any]] {
                let cases = self?.decode(json: stateData)
                completion(cases, nil)
            }
        }
        manager.onError = {
            error in
            completion(nil, error.localizedDescription)
        }
        manager.get()
    }
    
    private func decode(json: [[String: Any]]) -> [Cases_National]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            let data = try? decoder.decode([Cases_National].self, from: jsonData)
            return data
        }
        return nil
    }
}

// MARK: - NationalLevelData
class NationalLevelData {
    
    private static let shared = NationalLevelData()
    
    private var request : NationalLevelServiceRequest = NationalLevelServiceRequest()
    private var cases   : [Cases_National]? {
        didSet {
            totalSummary    = cases?.first
            statesData      = Array(cases?[1...] ?? [])
        }
    }
    
    var totalSummary    : Cases_National?
    var statesData      : [Cases_National]?
    
    class func get(completion: @escaping ( (NationalLevelData) -> ()) ) {
        let shared = NationalLevelData.shared
        guard shared.cases == nil else {
            completion(shared)
            return
        }
        
        shared.request.get {
            (_cases, _) in
            shared.cases = _cases ?? []
            completion(shared)
        }
    }
}
