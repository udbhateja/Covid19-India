//
//  MultipartMediaUploadManager.swift
//  ZvestaPro
//
//  Created by JBhateja on 22/04/20.
//  Copyright © 2020 Zapbuild Technology Private Limited. All rights reserved.
//

import Foundation
import Alamofire


// MARK: - WebServiceManager
class WebServiceManager: NSObject {
    
    //MARK: Private Variables
    private var url                     : String
    private var parameters              : [String: Any]
    
    lazy private var headers: HTTPHeaders = [:]
    
    //MARK: Callbacks
    var onError                         : ( (Error) -> () )?
    var onCompletion                    : ( ([String: Any]?) -> () )?
    
    //MARK: init
    init(url: String, parameters: [String: Any]) {
        self.url                    = url
        self.parameters             = parameters
    }
    
    func get() {
        Alamofire.request(url).responseJSON { (response) in
            
            if response.result.isSuccess {
                if let json = response.result.value as? [String: Any] {
                    self.onCompletion?(json)
                }
                else if let jsonArray = response.result.value as? [[String: Any]] {
                    self.onCompletion?(["data": jsonArray])
                }
            }
            else if let error = response.error {
                self.onError?(error)
            }
            else {
                let error = NSError(domain: "Something went wrong", code: 0, userInfo: nil)
                self.onError?(error)
            }
        }
    }
}
