//
//  ViewController.swift
//  S4NTest
//
//  Created by Gonzalinho on 2/12/19.
//  Copyright © 2019 Gonzalinho. All rights reserved.
//

import UIKit

struct ViewControllerConfig {
    static let navigationTitleText = "Inicio"
    static let welcomeDestcriptionText = "Bienvenido. Por favor selecciona la opción que prefieras:"
}

class ViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }

    private func setupInterface() {
        navigationItem.title = ViewControllerConfig.navigationTitleText
        descriptionLabel.text = ViewControllerConfig.welcomeDestcriptionText
        descriptionLabel.numberOfLines = 0
    }
    
    @IBAction func makeTestButtonTapped() {
        guard let testViewController = storyboard?.instantiateViewController(withIdentifier: KannSyndromeTestViewController.defaultReuseIdentifier) as? KannSyndromeTestViewController else { return }
        presentNextController(controller: testViewController)
    }
    
    @IBAction func historyButtonTapped() {
        guard let historyViewController = storyboard?.instantiateViewController(withIdentifier: TestHistoryViewController.defaultReuseIdentifier) as? TestHistoryViewController else { return }
        presentNextController(controller: historyViewController)
    }
    
    private func presentNextController(controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
}

