//
//  StateLevelServiceRequest.swift
//  Covid-19
//
//  Created by JBhateja on 15/05/20.
//  Copyright © 2020 Sarab_Uday. All rights reserved.
//

import Foundation

import Foundation

// MARK: - Request
class StateLevelServiceRequest {
    
    typealias StateLevelServiceRequest_Callback = ( ([Cases_State]?, String?) -> () )
    private let manager = WebServiceManager(url: WebServiceURL.stateLevel, parameters: [:])
    
    func get(completion: @escaping StateLevelServiceRequest_Callback) {
        
        manager.onCompletion = {
            [weak self] response in
            
            if let json = response,
                let stateData = json["data"] as? [[String: Any]] {
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
    
    func getFor(stateCode: String, completion: @escaping StateLevelServiceRequest_Callback) {
        
        manager.onCompletion = {
            [weak self] response in
            
            if let json = response,
                let stateData = json["data"] as? [[String: Any]] {
                let cases = self?.decode(json: stateData)
                if let stateCase = cases?.objectFor(stateCode: stateCode) {
                    completion([stateCase], nil)
                }
                else {
                    completion(nil, "Object for StateCode \(stateCode) does not exist")
                }
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





