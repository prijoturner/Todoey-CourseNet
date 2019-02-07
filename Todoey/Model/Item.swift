//
//  ItemDataModel.swift
//  Todoey
//
//  Created by Prijo on 2/6/19.
//  Copyright © 2019 Prijo. All rights reserved.
//

import Foundation


class Item: Codable {
    var title: String = ""
    var done: Bool = false
}
