//
//  DataManager.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 07.05.2024.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults()
    
    private init() {}
    
    func setPlayerTime(for name: String, with time: Int) {
        userDefaults.set(time, forKey: name)
    }
    func getPlayerTime(for name: String) -> Int {
        userDefaults.integer(forKey: name)
    }
    
}
