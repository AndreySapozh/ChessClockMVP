//
//  AssemblyModelBuilder.swift
//  ChessClockMVP
//
//  Created by Андрей Сапожников on 01.12.2022.
//

import UIKit
import RealmSwift

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol, timeChess: TimeRealm) -> UIViewController
    func createSettingsModule(router: RouterProtocol, timeChess: TimeRealm) -> UIViewController
    func createNewTimeModule(router: RouterProtocol, newTimeChess: TimeRealm) -> UIViewController
}

final class AssemblyModelBuilder: AssemblyBuilderProtocol {
    
    func createMainModule(router: RouterProtocol, timeChess: TimeRealm) -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view, router: router, timerTopPlayer: Timer(), timerBottomPlayer: Timer(), timeChess: timeChess)
        view.presenter = presenter
        return view
    }

    func createSettingsModule(router: RouterProtocol, timeChess: TimeRealm) -> UIViewController {
        let view = SettingsViewController()
        let time = StorageManager.shared.realm.objects(TimeRealm.self)
        let presenter = SettingsPresenter(view: view, router: router, timeChess: timeChess, time: time)
        view.presenter = presenter
        return view
    }
    func createNewTimeModule(router: RouterProtocol, newTimeChess: TimeRealm) -> UIViewController {
        let view = NewTimeViewController()
        let presenter = NewTimePresenter(view: view, router: router, newTimeChess: newTimeChess)
        view.presenter = presenter
        return view
    }

    
}
