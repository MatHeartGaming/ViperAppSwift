//
//  Router.swift
//  CryptoViper
//
//  Created by Matteo Buompastore on 08/05/23.
//

import Foundation
import UIKit

//Class, Protocol
// EntryPoint

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    
    var entry : EntryPoint? { get }
    
    static func startExecution() -> AnyRouter
    
    
}

class CryptoRouter : AnyRouter {
    
    var entry: EntryPoint?
    
    static func startExecution() -> AnyRouter {
        let router = CryptoRouter()
        
        var view = CryptoViewController()
        var presenter = CryptoPresenter()
        var interactor = CryptoInteractor()
        
        view.presenter = presenter
        
        //Presenter Init
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        //Interactor init
        interactor.presenter = presenter
        
        // Init Router
        router.entry = view
        
        return router
    }
    
    
}
