//
//  DetailsViewController.swift
//  CryptoViper
//
//  Created by Matteo Buompastore on 08/05/23.
//

import Foundation
import UIKit

class DetailViewController : UIViewController {
    
    var currency : String = ""
    var price : String = ""
    
    private let currencyLabel : UILabel = {
        let label = UILabel()
        let font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let priceLabel : UILabel = {
        let label = UILabel()
        let font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(currencyLabel)
        view.addSubview(priceLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let frame = view.frame
        let msgWidth = 200
        let msgHeight = 50
        currencyLabel.frame = CGRect(x: (Int(frame.width) / 2) - (msgWidth / 2), y: (Int(frame.height) / 2) - (msgHeight / 2), width: 200, height: 50)
        priceLabel.frame = CGRect(x: (Int(frame.width) / 2) - (msgWidth / 2), y: (Int(frame.height) / 2) - (msgHeight), width: 200, height: 50)
        
        currencyLabel.text = currency
        priceLabel.text = price
    }
    
}
