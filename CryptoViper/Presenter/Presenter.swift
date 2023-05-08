//
//  Presenter.swift
//  CryptoViper
//
//  Created by Matteo Buompastore on 08/05/23.
//

import Foundation

//Class, protocol
// Talks to --> Interactor, Router, View

protocol AnyPresenter {
    
    var router : AnyRouter? { get set }
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    func interactorDidDownloadCrypto(result : Result<[Crypto], Error>)
}

class CryptoPresenter : AnyPresenter {
    
    var view: AnyView?
    var interactor: AnyInteractor? {
        didSet {
            interactor?.downloadCryptos()
        }
    }
    var router: AnyRouter?
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>) {
        switch result {
        case .success(let cryptos):
            //update view
            view?.update(with: cryptos)
            print("Success")
            return
            
        case .failure( _):
            //show error
            print("Error")
            view?.update(with: "Download error...")
            return
        }
    }
    
}

enum NetworkError : Error {
    case NetworkFailed
    case ParsingFailed
}
