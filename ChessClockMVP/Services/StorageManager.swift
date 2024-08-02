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
    
    func save(chessTimeArray: [TimeRealm]) {
        write {
            realm.add(chessTimeArray)
        }
    }
    
    func save(chessTime: TimeRealm) {
        write {
            realm.add(chessTime)
        }
    }
    
    func delete(chessTimeArray: Results<TimeRealm>) {
        write {
            realm.delete(chessTimeArray)
        }
    }
    
    func delete(timeChess: TimeRealm) {
        write {
            realm.delete(timeChess)
        }
    }
    
    func edit(timeChess: TimeRealm, seconds: Int, increment: Int) {
        write {
            timeChess.seconds = seconds
            timeChess.increment = increment
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
