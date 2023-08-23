//
//  Networking.swift
//  DemoRxSwift
//
//  Created by Nut Jiraporn on 23/8/2566 BE.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift

public func handleResponse<T>(response: AFDataResponse<Data>, observer: AnyObserver<T>, onSuccess: @escaping (JSON) -> Void) {
    #if DEBUG
        debugPrint(response)
    #endif
    switch response.result {
    case .success(let value):
        let json = JSON(value)
        onSuccess(json)

        observer.onCompleted()
    case .failure(let error):
        ErrorManager.handleNetworkError(error, response)
        if let data = response.data {
            let jsonText = String(decoding: data, as: UTF8.self)
            let json = JSON(parseJSON: jsonText)
            let twsError = ErrorFactory.createTWSError(from: json)
            observer.onError(twsError)
        } else {
            observer.onError(error)
        }
    }
}

class ErrorManager {

    static func handleNetworkError<T>(_ error: Error, _ response: AFDataResponse<T>) {
        guard let rsp = response.response else { return }
        guard let url = rsp.url else { return }
        guard let data = response.data else { return }
        #if DEBUG
            print("[Request]: \(url.absoluteString)")
            print("[Status Code]: \(rsp.statusCode)")
            print("[Data]: \(String(decoding: data, as: UTF8.self))")
        #else
//            let userInfo: [String: Any] = [
//                NSLocalizedDescriptionKey: url.absoluteString,
//                NSLocalizedFailureReasonErrorKey: rsp.statusCode,
//                NSLocalizedRecoverySuggestionErrorKey: String(decoding: data, as: UTF8.self)
//            ]
//            Crashlytics.crashlytics().record(error: error)
        #endif
    }
}

