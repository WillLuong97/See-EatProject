//
//  NetworkService.swift
//  RestaurantApp
//

import Foundation
import Moya

private let apiKey = "akjrEqjS3g2rTu3KbNyelwRsUCrXHiMOS2pSIXRNokD6XdFxirhDdJPy5ChVHDqSUog-Ttl6cf1aaiOw1t6yMYG9T7CeF1u5ScC9eb2G83-68DWTxQMKHTdHqZSfXnYx"

enum YelpService {
    enum BusinessesProvider: TargetType {
        case search(lat: Double, long: Double)
        case details(id: String)
        
        var baseURL: URL {
            return URL(string: "https://api.yelp.com/v3/businesses")!
        }

        var path: String {
            switch self {
            case .search:
                return "/search"
            case let .details(id):
                return "/\(id)"
            }
        }

        var method: Moya.Method {
            return .get
        }

        var sampleData: Data {
            return Data()
        }

        var task: Task {
            switch self {
            case let .search(lat, long):
                return .requestParameters(
                    parameters: ["latitude": lat, "longitude": long, "limit": 10], encoding: URLEncoding.queryString)
            case .details:
                return .requestPlain
            }
            
        }

        var headers: [String : String]? {
            return ["Authorization": "Bearer \(apiKey)"]
        }
    }
}
