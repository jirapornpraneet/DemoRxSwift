//
//  APIRouter.swift
//  DemoRxSwift
//
//  Created by Nut Jiraporn on 23/8/2566 BE.
//

import Alamofire

enum APIRouter: URLRequestConvertible {

    case user
    case orderInformation(portID: String, batchOrder: [[String: Any]])
    case dividendHistory(portID: String, page: Int)

    static let baseURLString = "https://swapi.dev"

    var method: HTTPMethod {
        switch self {
        case .user:
            return .get
        case .orderInformation:
            return .post
        case .dividendHistory:
            return .get
        }
    }

    var path: String {
        switch self {
        case .user
            return "api/people/1/"
        case .orderInformation:
            return "a"
        case .dividendHistory:
            return ""
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.baseURLString.asURL()
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)

        switch self {
        case .orderInformation(_, let batchOrder):
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: batchOrder, options: [])
            urlRequest.headers.add(.contentType("application/json"))
        case .orderHistory(_, let page):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: ["page": page])
        case .dividendHistory(_, let page):
            let params: [String: Any] = [
                "page": page,
                "order_by": "desc",
                "order_by_field": "order_date"
            ]
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        default:
            break
        }

        return urlRequest
    }
}
