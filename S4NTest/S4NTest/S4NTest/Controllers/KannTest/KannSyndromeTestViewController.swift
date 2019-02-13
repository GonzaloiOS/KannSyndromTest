//
//  KannSyndromeTestViewController.swift
//  S4NTest
//
//  Created by Gonzalinho on 2/12/19.
//  Copyright © 2019 Gonzalinho. All rights reserved.
//

import UIKit

struct KannSyndromeTestViewControllerConfig {
    static let navigationTitle = "Test"
    static let descriptionText = "Por favor contesta las siguientes preguntas:"
    static let resultsText = "Resultados"
    static let bodyMessageText = "Probabilidad de tener la condición de Kann es: "
    static let defaultRowHeight = CGFloat(60)
    static let percentageToSum = 25
}

class KannSyndromeTestViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var makeTestButton: UIButton!
    
    var kanQuestionList = [KannQuestion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
        setupData()
    }
    
    private func setupInterface() {
        navigationItem.title = KannSyndromeTestViewControllerConfig.navigationTitle
        
        descriptionLabel.text = KannSyndromeTestViewControllerConfig.descriptionText
        descriptionLabel.numberOfLines = 2
        
        tableView.rowHeight = KannSyndromeTestViewControllerConfig.defaultRowHeight
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: OptionTitleTableViewCell.defaultReuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: OptionTitleTableViewCell.defaultReuseIdentifier)
    }
    
    private func setupData() {
        let firstQuestion = KannQuestion(type: .headeache, status: false)
        let secondQuestion = KannQuestion(type: .rangeAge, status: false)
        let thirdQuestion = KannQuestion(type: .gender, status: false)
        let FourthQuestion = KannQuestion(type: .alcohol, status: false)
        
        kanQuestionList = [firstQuestion, secondQuestion, thirdQuestion, FourthQuestion]
    }
    
    @IBAction func makeTestButtonTapped(_ sender: Any) {
        let percentage = calculateKannSyndromePercentage(answers: kanQuestionList)
        let title = KannSyndromeTestViewControllerConfig.resultsText
        let message = KannSyndromeTestViewControllerConfig.bodyMessageText + "\(percentage) %"
        showMessage(title: title, message: message)
        
        saveUserPreferences(result: percentage)
    }
    
    private func calculateKannSyndromePercentage(answers: [KannQuestion]) -> Int {
        var percentage = 0
        
        for item in answers {
            guard item.status else { continue }
            percentage += KannSyndromeTestViewControllerConfig.percentageToSum
        }
        
        return percentage
    }
    
    private func showMessage(title: String, message: String) {
        presentAlertController(title: title, message: message)
    }
    
    private func saveUserPreferences(result: Int) {
        StorageDataManager.saveNewTest(percentage: result)
    }
}


extension KannSyndromeTestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kanQuestionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: OptionTitleTableViewCell.defaultReuseIdentifier, for: indexPath)
        
        guard let cell = tableViewCell as? OptionTitleTableViewCell else { return tableViewCell }
        
        let item = kanQuestionList[indexPath.row]
        cell.setupCell(item: item)
        cell.delegate = self
        return cell
    }
}

extension KannSyndromeTestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = kanQuestionList[indexPath.row]
        item.status = !item.status
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

extension KannSyndromeTestViewController: OptionTitleTableViewCellDelegate {
    func answerUpdated(cell: OptionTitleTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let item = kanQuestionList[indexPath.row]
        item.status = !item.status
    }
}
