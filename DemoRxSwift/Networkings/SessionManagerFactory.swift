//
//  SessionManagerFactory.swift
//  DemoRxSwift
//
//  Created by Nut Jiraporn on 23/8/2566 BE.
//

import Foundation
import Alamofire

class SessionManagerFactory {
    static let shared = SessionManagerFactory()

    let manager: Session

    init() {
        manager = Session(interceptor: Interceptor(adapters: [oauthHandler, bcpTradeHandler, mfaAuthHandler], retriers: [oauthHandler, bcpTradeHandler, mfaAuthHandler]))
    }
}
