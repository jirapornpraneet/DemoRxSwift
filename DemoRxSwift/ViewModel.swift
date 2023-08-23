//
//  ViewModel.swift
//  DemoRxSwift
//
//  Created by Nut Jiraporn on 23/8/2566 BE.
//

import RxSwift
import Alamofire
import SwiftyJSON

class ViewModel {

    var info: UserInfo?
    var url = "https://swapi.dev/api/people/1/"
    let isDataReady: PublishSubject<Void> = PublishSubject()
    let error: PublishSubject<Error> = PublishSubject()

    func requestCurrency() {
        let request = AF.request(self.url, method: .get, parameters: nil, encoding:URLEncoding.default, headers: nil)
            .validate(statusCode:  200..<300)
            .validate(contentType: ["application/json"])
        request.responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.info = UserInfo(json)
                //เพื่อเป็นการบอกว่าข้อมูล Map เรียบร้อยแล้วโดยให้ตัว DataReady ที่ sucscribe รอไว้อยู่
                //ส่งค่าต่อไปยัง Observer หมายความว่า Observer ที่ Subscribe ตัวมัน ณ ขณะที่ส่ง onNext เท่านั้น ที่จะได้รับค่าใหม่ไป
                self.isDataReady.onNext(())
            case .failure(let error):
                print(error.localizedDescription)
                //เพื่อเป็นการบอกว่ามีข้อมูลerror ส่งไปและทำงาน ที่ sucscribe รอไว้อยู่
                //ส่งค่าต่อไปยัง Observer หมายความว่า Observer ที่ Subscribe ตัวมัน ณ ขณะที่ส่ง onNext เท่านั้น ที่จะได้รับค่าใหม่ไป
                self.error.onNext(error)
            }
        }
    }
}


