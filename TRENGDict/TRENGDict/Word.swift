//
//  Word.swift
//  TRENGDict
//
//  Created by berk birkan on 2.08.2019.
//  Copyright © 2019 berk birkan. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class Word: Object {
    @objc dynamic var word = ""
    @objc dynamic var mean = ""
    
    override static func primaryKey() -> String? {
        return "word"
    }
    
    
}


