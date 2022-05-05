//
//  AppSettingViewController.swift
//  RabbleWabble
//
//  Created by Ives Murillo on 5/1/22.
//

import UIKit

//1
public class AppSettingsViewContoller: UITableViewController {
    //2
    // MARK: - Properties
    public let appSetting = AppSetting.shared
    private let cellIdentifier = "basicCell"
    
    // MARK: - View Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // 3
        tableView.tableFooterView = UIView()
        
        // 4
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
}

// MARK: - UITableViewDataSource
extension AppSettingsViewContoller {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return QuestionStrategyType.allCases.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // 2
        let questionStrategyType = QuestionStrategyType.allCases[indexPath.row]
        
        // 3
        cell.textLabel?.text = questionStrategyType.title()
        
        // 4
        if appSetting.questionStrategyType == questionStrategyType{
            cell.accessoryType = .checkmark
            
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AppSettingsViewContoller {
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questioinStrategyType = QuestionStrategyType.allCases[indexPath.row]
        appSetting.questionStrategyType = questioinStrategyType
        tableView.reloadData()
    }
}
