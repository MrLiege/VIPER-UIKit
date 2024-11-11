//
//  UserStorage.swift
//  CoffeApp
//
//  Created by Artyom Petrichenko on 29.10.2024.
//

import Foundation

final class UserStorage {
    static var shared = UserStorage()
    
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    var token: String? {
        get {
            let token = defaults.string(forKey: UserStorageKey.token.rawValue)
            return token
        }
        set {
            if let newValue = newValue {
                defaults.setValue(newValue, forKey: UserStorageKey.token.rawValue)
            } else {
                defaults.removeObject(forKey: UserStorageKey.token.rawValue)
            }
        }
    }
    
    var isFirstLaunch: Bool {
        get {
            !UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        }
        set {
            UserDefaults.standard.set(!newValue, forKey: "hasLaunchedBefore")
        }
    }
}

enum UserStorageKey: String {
    case token
    case isFirstLaunch
}
