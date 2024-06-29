//
//  StorageManager.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 25.06.2024.
//

import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    let realm = try! Realm()
    
    private init() {}
    
    func save(timeChess: TimeExample) {
        write {
            realm.add(timeChess)
        }
    }
    
    private func write(_ completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch let error {
            print(error)
        }
    }
}
