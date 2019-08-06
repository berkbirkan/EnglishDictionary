//
//  DBManager.swift
//  TRENGDict
//
//  Created by berk birkan on 2.08.2019.
//  Copyright © 2019 berk birkan. All rights reserved.
//


import UIKit
import RealmSwift

class DBManager {
    private var   database:Realm
    static let   sharedInstance = DBManager()
    private init() {
        database = try! Realm()
    }
    func getDataFromDB() ->   Results<Word> {
        let results: Results<Word> =   database.objects(Word.self)
        return results
    }
    func addData(object: Word)   {
        try! database.write {
            database.add(object, update: true)
            print("Added new object")
        }
    }
    func deleteAllFromDatabase()  {
        try!   database.write {
            database.deleteAll()
        }
    }
    func deleteFromDb(object: Word)   {
        try!   database.write {
            database.delete(object)
        }
    }
    
    
}
