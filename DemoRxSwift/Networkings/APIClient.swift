//
//  APIClient.swift
//  DemoRxSwift
//
//  Created by Nut Jiraporn on 23/8/2566 BE.
//

import Alamofire
import RxSwift
import SwiftyJSON

protocol APIClientProtocol {
    func requestUser() -> Observable<UserInfo>
}

class APIClient: APIClientProtocol {

    func requestUser() -> Observable<UserInfo> {
        let sessionManager = Session
        let reference = sessionManager.request(APIRouter.user).validate().responseData { response in
            handleResponse(response: response, observer: observer) { json in
                observer.onNext(UserInfo(json))
            }
        }
        return Disposables.create { reference.cancel() }

        
    }

    static func getDisclaimer() -> Observable<DisclaimerData> {
        return Observable<DisclaimerData>.create { observer -> Disposable in
            let sessionManager = SessionManagerFactory.shared.manager
            let reference = sessionManager.request(TWSAPIRouter.disclaimer).validate().responseData { response in
                handleResponse(response: response, observer: observer) { json in
                    observer.onNext(DisclaimerData(json))
                }
            }
            return Disposables.create { reference.cancel() }
        }
    }

}
