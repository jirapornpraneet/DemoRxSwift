//
//  UserInfo.swift
//  DemoRxSwift
//
//  Created by Nut Jiraporn on 23/8/2566 BE.
//

import SwiftyJSON

struct UserInfo {
    let name: String
    let height: String
    let hairColor: String

    init(_ json: JSON) {
        name = json["name"].stringValue
        height = json["height"].stringValue
        hairColor = json["hairColor"].stringValue
    }
}
