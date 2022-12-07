//
//  ViewController.swift
//  FinalProject
//
//  Created by Tarik Efe on 6.12.2022.
//

import UIKit

class GameListViewController: UIViewController {
//MARK: Outlets
    @IBOutlet private weak var gameListTableView: UITableView! {
        didSet {
            gameListTableView.dataSource = self
            gameListTableView.delegate = self
        }
    }
//MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}
//MARK: Extensions
extension GameListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension GameListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
