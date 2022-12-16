//
//  NoteListViewController.swift
//  FinalProject
//
//  Created by Tarik Efe on 15.12.2022.
//

import UIKit

class NoteListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Floating Button
    private let floatingButton: UIButton = {
        let button = UIButton(
            frame: CGRect(x: 0,
                          y: 0,
                          width: 60,
                          height: 60))
        button.backgroundColor = .green
        
        let floatingButtonImage = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(floatingButtonImage, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.layer.cornerRadius = 60 / 2
        
        return button
    }()
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        title = "Notes".localized()
        tabBarItem.title = "Notes".localized()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width - 60 - 30,
                                      y: view.frame.size.height - 60 - 100,
                                      width: 60,
                                      height: 60)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadNewNote), name: NSNotification.Name(rawValue: "reloadNoteList"), object: nil)
    }
    
    //MARK: - Methods
    private func configureViews() {
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didFloatingButtonClicked), for: .touchUpInside)
    }
    
    @objc private func didFloatingButtonClicked() {
        guard let addNoteViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: AddNoteViewController.self)) as? AddNoteViewController else { return }
        addNoteViewController.modalPresentationStyle = .pageSheet
        present(addNoteViewController, animated: true)
    }
    
    @objc private func reloadNewNote() {
        //self.noteList = CoreDataManager.shared.getNotes()
        //tableView.reloadData()
    }

}

