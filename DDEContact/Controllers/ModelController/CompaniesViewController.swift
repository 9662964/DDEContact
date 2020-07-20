//
//  ViewController.swift
//  DDEContact
//
//  Created by iljoo Chae on 7/20/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class CompaniesViewController: UITableViewController {
    
    let companies = [
    
        Company(name: "Apple", founded: Date()),
        Company(name: "Google", founded: Date()),
        Company(name: "Facebook", founded: Date())
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupNavigationStyle()
        view.backgroundColor = .white
        navigationItem.title = "Companies"
        tableView.backgroundColor = UIColor(red: 9/255, green: 45/255, blue: 64/255, alpha: 1)
        //able to remove tableView seperator(line)
        //tableView.separatorStyle = .none
        
        //just show tableview seperator as it has been assigned,and rest of the space show no seperators.
        tableView.tableFooterView = UIView()
        
        //Add plus btn
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(handleAddCompany))
        
        //Assign cell ID
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        //seperator color
        tableView.separatorColor = .white
    }
    

    
    @objc func handleAddCompany() {
        print("Adding compnay")
        
        let  createCompanyController = CreateCompanycomtroller()
//        createCompanyController.view.backgroundColor = .green
        let navController = UINavigationController(rootViewController: createCompanyController)
        present(navController, animated: true, completion: nil)
    }

    //header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        let company = companies[indexPath.row]
        cell.textLabel?.text = company.name
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        cell.backgroundColor = UIColor.tealColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 8
        return companies.count
        
    }
    
}



