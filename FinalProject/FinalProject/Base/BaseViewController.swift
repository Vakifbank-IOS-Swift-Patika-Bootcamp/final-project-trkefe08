//
//  BaseViewController.swift
//  FinalProject
//
//  Created by Tarik Efe on 17.12.2022.
//

import UIKit
import MaterialActivityIndicator
import SwiftAlertView
//MARK: - Class
class BaseViewController: UIViewController {
    //MARK: - Variables
    let indicator = MaterialActivityIndicatorView()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicatorView()
    }
    //MARK: - Methods
    private func setupActivityIndicatorView() {
        view.addSubview(indicator)
        setupActivityIndicatorViewConstraints()
    }
    
    private func setupActivityIndicatorViewConstraints() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func showErrorAlert(message: String, completion: @escaping () -> Void) {
        SwiftAlertView.show(title: "Error",
                            message: message,
                            buttonTitles: ["OK"]).onButtonClicked { _, _ in
            completion()
        }
    }
}
