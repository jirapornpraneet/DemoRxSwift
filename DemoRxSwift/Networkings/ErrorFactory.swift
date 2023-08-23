//
//  ErrorFactory.swift
//  DemoRxSwift
//
//  Created by Nut Jiraporn on 23/8/2566 BE.
//

import Foundation

import SwiftyJSON

enum TWSErrorCode: String {
    case dateSlip = "E001"
    case dateSlipBatch = "E002"
    case editOrderDate = "E003"
    case validateError = "E005"
    case requiredError = "E006"
    case praUnavailable = "E010"
    case duplicateOrder = "E011"
    case needSuitabilityTest = "E027"
    case notFoundError = "E101"
    case forbiddenedError = "E103"
    case beFinUnexpectedBehavior = "E200"
    case beFinValidateError = "E210"
    case unauthorized = "E400"
    case timeUnavailable = "E420"
    case bcpUnavailable = "E421"
    case wrongPINError = "E500"
    case noPINError = "E501"
    case unexpectedError = "E999"
}

enum TWSError: Error {
    case dateSlip(orderID: String, message: String)
    case duplicateOrder
    case editOrderDate(message: String)
    case validate(message: String)
    case required
    case praUnavailable(message: String)
    case needSuitabilityTest
    case timeUnavailable(message: String)
    case bcpUnavailable(message: String)
    case pin(message: String)
    case message(String)
    case forbiddenedError

    var localizedDescription: String {
        switch self {
        case .dateSlip(_, let message):
            return message
            return ""
        case .duplicateOrder:
            return ""
        case .editOrderDate(let message):
            return message
        case .validate(let message):
            return message
        case .required:
            return "ไม่สามารทำรายการได้ กรุณาลองใหม่อีกครั้ง หากพบปัญหา ติดต่อ 02-026-5100"
        case .praUnavailable:
            return "รายการของคุณมีการเปลี่ยนแปลง กรุณาตรวจสอบอีกครั้ง"
        case .needSuitabilityTest:
            return "เนื่องจากแบบประเมินความเสี่ยงทางการลงทุนของคุณหมดอายุ กรุณาไปที่เว็บไซต์ NOMURA iFUND เพื่อทำแบบประเมินก่อนทำรายการซื้อขาย"
        case .timeUnavailable(let message):
            return message
        case .bcpUnavailable(let message):
            return message
        case .pin(let message):
            return message
        case .message(let message):
            return message
        case .forbiddenedError:
            return ""
        }
    }
}



class ErrorFactory {

    static func createTWSError(from json: JSON) -> TWSError {
        if let errorCode = TWSErrorCode(rawValue: json["error_code"].stringValue) {
            switch errorCode {
            case .dateSlip:
                let dateSlipJSON = JSON(parseJSON: json["message"].stringValue)
                return .dateSlip(orderID: dateSlipJSON["order_id"].stringValue, message: dateSlipJSON["msg"].stringValue)
            case .duplicateOrder:
                return .duplicateOrder
            case .editOrderDate:
                return .editOrderDate(message: json["message", "error_msg"].stringValue)
            case .validateError:
                let validateJSON = JSON(parseJSON: json["message"].stringValue)
                return .validate(message: validateJSON["msg"].stringValue)
            case .requiredError:
                return .required
            case .praUnavailable:
                return .praUnavailable(message: json["message"].stringValue)
            case .needSuitabilityTest:
                return .needSuitabilityTest
            case .beFinValidateError:
                let befinValidateJSON = JSON(parseJSON: json["message"].stringValue)
                return .message(befinValidateJSON["msg"].stringValue)
            case .timeUnavailable:
                return .timeUnavailable(message: json["message"].stringValue)
            case .bcpUnavailable:
                return .bcpUnavailable(message: json["message"].stringValue)
            case .wrongPINError, .noPINError:
                return .pin(message: json["message"].stringValue)
            case .forbiddenedError:
                return .forbiddenedError
            default:
                return .message(json["message"].stringValue)
            }
        }
        return .message("ไม่สามารถทำรายการได้ในขณะนี้ กรุณาลองใหม่อีกครั้ง")
    }
}
