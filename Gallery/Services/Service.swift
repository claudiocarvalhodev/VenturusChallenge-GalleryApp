//
//  Service.swift
//  Gallery
//
//  Created by claudiocarvalho on 21/01/20.
//  Copyright © 2020 claudiocarvalho. All rights reserved.
//

import Foundation
import Moya

enum Service {
    case getList(q: String, clientId: String)
}

extension Service: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType {
        switch self {
        case .getList(_):
            return .bearer
        }
    }
    
    var baseURL: URL {
        switch self {
        case .getList(_):
            return URL(string: "https://api.imgur.com/3")!
        }
    }
    
    var path: String {
        switch self {
        case .getList(_):
            return "/gallery/search/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getList(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getList(let q, _):
            return .requestParameters(parameters: ["q": q], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getList(_, let clientId):
            return ["client_id": clientId]
        }
    }
}
