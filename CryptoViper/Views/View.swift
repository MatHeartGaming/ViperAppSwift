//
//  View.swift
//  CryptoViper
//
//  Created by Matteo Buompastore on 08/05/23.
//

import Foundation
import UIKit

// The View talks to the Presenter
// Class, protocol
// ViewController

protocol AnyView {
    
    var presenter : AnyPresenter? {get set}
    
    func update(with cryptos : [Crypto])
    func update(with error : String)
    
    
}

class CryptoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AnyView {
    
    var presenter: AnyPresenter?
    var cryptos = [Crypto]()
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let messageLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Downloading..."
        let font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    func update(with cryptos: [Crypto]) {
        DispatchQueue.main.async {
            self.cryptos = cryptos
            self.messageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.cryptos = []
            self.tableView.isHidden = true
            self.messageLabel.isHidden = false
            self.messageLabel.text = error
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        initTableView()
        initMessageLabel()
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    func initTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
    }
    
    func initMessageLabel() {
        let frame = view.frame
        let msgWidth = 200
        let msgHeight = 50
        messageLabel.frame = CGRect(x: (Int(frame.width) / 2) - (msgWidth / 2), y: (Int(frame.height) / 2) - (msgHeight / 2), width: 200, height: 50)
        view.addSubview(messageLabel)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cryptos[indexPath.row].currency
        content.secondaryText = cryptos[indexPath.row].price
        cell.contentConfiguration = content
        cell.backgroundColor = .orange
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = DetailViewController()
        nextVC.currency = cryptos[indexPath.row].currency
        nextVC.price = cryptos[indexPath.row].price
        self.present(nextVC, animated: true)
    }
    
}
