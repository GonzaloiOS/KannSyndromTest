//
//  TestHistoryViewController.swift
//  S4NTest
//
//  Created by Gonzalinho on 2/12/19.
//  Copyright © 2019 Gonzalinho. All rights reserved.
//

import UIKit

struct TestHistoryViewControllerConfig {
    static let descriptionText = "Ordenado del más antiguo al más reciente"
    static let navigationTitle = "Historial"
    static let titleMessage = "No hay registros"
    static let emptyMessage = "Intenta luego por favor"
    static let finalPercentageText = "Resultado: "
}

class TestHistoryViewController: UIViewController {
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var percentageList = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        setupData()
    }
    
    private func setupInterface() {
        navigationItem.title = TestHistoryViewControllerConfig.navigationTitle
        
        descriptionLabel.text = TestHistoryViewControllerConfig.descriptionText
        
        descriptionLabel.numberOfLines = 2
        
        tableView.rowHeight = 40
        tableView.dataSource = self
        let nib = UINib(nibName: DefaultTitleTableViewCell.defaultReuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: DefaultTitleTableViewCell.defaultReuseIdentifier)
    }
    
    private func setupData() {
        StorageDataManager.fetchPreviousTests { (percentages) in
            guard let percentages = percentages else {
                self.presentEmptyAlert()
                return
            }
            
            self.percentageList = percentages
            self.tableView.reloadData()
        }
    }
    
    private func presentEmptyAlert() {
        presentAlertController(title: TestHistoryViewControllerConfig.titleMessage, message: TestHistoryViewControllerConfig.emptyMessage)
    }

}

extension TestHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return percentageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: DefaultTitleTableViewCell.defaultReuseIdentifier, for: indexPath)
        
        guard let cell = tableViewCell as? DefaultTitleTableViewCell else { return tableViewCell }
        
        let item = percentageList[indexPath.row]
        
        let finalText = TestHistoryViewControllerConfig.finalPercentageText + "\(item) %"
        cell.setupCell(item: finalText)
        
        return tableViewCell
    }
}
