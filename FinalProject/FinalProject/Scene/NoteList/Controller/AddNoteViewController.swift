//
//  AddNoteViewController.swift
//  FinalProject
//
//  Created by Tarik Efe on 15.12.2022.
//

import UIKit

final class AddNoteViewController: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet private weak var gameTextField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var gameLabel: UITextField!
    
    //MARK: - Variables
    private var game: [GameDetailModel]?
    private var viewModel: AddNoteViewModelProtocol = AddNoteViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    //MARK: - IBAction
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let gameText = gameLabel.text, gameText.isEmpty {
            showErrorAlert(message: "Game cannot be left blank".localized()) {
            }
        } else if let note = gameTextField.text, note.isEmpty {
            showErrorAlert(message: "Note cannot be left blank".localized()) {
            }
        }
        viewModel.saveNote(note: gameTextField.text ?? "", id: gameLabel.text ?? "")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadNoteList"), object: nil)
        self.dismiss(animated: true)
    }
}
//MARK: - Extension
extension AddNoteViewController: AddNoteViewModelDelegate {
    func gameLoaded() {
    }
}
