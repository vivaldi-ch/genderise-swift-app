//
//  Gender.swift
//  genderise
//
//  Created by Vivaldi Ibelio Chandra on 17/2/19.
//  Copyright © 2019 Vivaldi Ibelio Chandra. All rights reserved.
//

import Foundation

struct Gender: Decodable {
    let name: String
    let gender: String?
    let probability: String?
    let count: Int?
}
