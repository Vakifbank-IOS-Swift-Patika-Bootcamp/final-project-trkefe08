//
//  AddNoteViewController.swift
//  FinalProject
//
//  Created by Tarik Efe on 15.12.2022.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var gamePickerView: UIPickerView!
    @IBOutlet weak var gameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    //MARK: - Variables
    private var game: [GameDetailModel]? {
        didSet {
            gamePickerView.delegate = self
            gamePickerView.dataSource = self
        }
    }
    private var selectedGamePickerView: Int = 0
    var editNote : (Bool, Note?) = (false, nil)
    private var viewModel: AddNoteViewModelProtocol = AddNoteViewModel()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchAllGames()
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
       /* if selectedGamePickerView > 0, let note = gameTextField.text  {
            let gameId = 
            if editNote.0 == false {
                viewModel.saveNote(note: note, id: <#T##Int#>)
            }*/
        }
    }
    
//}

extension AddNoteViewController: AddNoteViewModelDelegate {
    func gameLoaded() {
        
    }
}

extension AddNoteViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
}
