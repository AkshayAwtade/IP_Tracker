//
//  APICall.swift
//  IP_Tracker_Akshay_Awtade
//
//  Created by Akshay Awtade on 01/04/21.
//  Copyright © 2021 Akshay Awtade. All rights reserved.
//

import Foundation
import Alamofire

class APICall {
    
    func apiCallData(urlStr:String,params:Dictionary<String,String>, _ completion:  @escaping (Data) -> Void){
        let url = urlStr
        print(url,"url printed", params)
        AF.request(URL.init(string: url)! as URLConvertible, method: .get, parameters: params, headers: .none, interceptor: .none, requestModifier: .none).responseJSON { response in
            if((response.error) != nil){
                completion(Data.init())
            }else{
            let responseData = response.data!
            completion(responseData)
            }
        }
    }
}
