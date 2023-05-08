//
//  Interactor.swift
//  CryptoViper
//
//  Created by Matteo Buompastore on 08/05/23.
//

import Foundation

//Class, Protocol
// Talks to Presenter

protocol AnyInteractor {
    
    var presenter : AnyPresenter? {get set}
    
    func downloadCryptos()
}

class CryptoInteractor : AnyInteractor {
    
    var presenter: AnyPresenter?
    
    private let urlCryptos = "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json"
    
    func downloadCryptos() {
        guard let url = URL(string: urlCryptos) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.NetworkFailed))
                return
            }
            
            do {
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))
            } catch {
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.ParsingFailed))
                print("Error crypto download: \(error)")
            }
            
        }.resume()
        
    }
    
}
