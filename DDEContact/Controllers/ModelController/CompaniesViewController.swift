//
//  ViewController.swift
//  DDEContact
//
//  Created by iljoo Chae on 7/20/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import CoreData


class CompaniesViewController: UITableViewController,CreateCompanyViewControllerDelegate {

    

    //Creat empty array
    var companies = [Company]()
    
    func didAddCompany(company: Company) {
        //1 - Modify your array
        companies.append(company)
        //2- Insert a new index path into tableView
        let newIndexPath = IndexPath(row: companies.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        fetchCompaines()
    }
    
    func didEditCompany(company: Company) {
        //update my tableview somehow
        let row = companies.index(of: company)
        let reloadIndexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .middle    )
        
    }
    
    private func fetchCompaines() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        do {
            let companies = try context.fetch(fetchRequest)
            companies.forEach({ (company) in
                print(company.name ?? "")
            })
            self.companies = companies
            self.tableView.reloadData()
        }catch let fetchError{
            print("Failed to fetch comopanies", fetchError)
        }
    }

    @objc func handleAddCompany() {
        print("Adding compnay")
        let  createCompanyController = CreateCompanycontroller()
//        createCompanyController.view.backgroundColor = .green
        let navController = UINavigationController(rootViewController: createCompanyController)
        createCompanyController.delegate = self
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
    
    
    func dideditCompany(company: Company) {
        
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, nil) in
                  
            //Perform Edit
            print("Editing company")
            let editCompanyController = CreateCompanycontroller()
            editCompanyController.delegate = self
            editCompanyController.company = self.companies[indexPath.row]
            let navController = CustomNavigationController(rootViewController: editCompanyController)
            self.present(navController, animated: true, completion: nil)
            
            
        }
        
        
        edit.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            print("delete")
            let company = self.companies[indexPath.row]
            //remove the company from our tableview
            self.companies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            //delete the company from core data
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(company)
            do {
                try context.save()
            }catch let saveErr{
                print("Failed to delete company-- \(saveErr)")
            }
            
            
        }
        delete.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        let configure = UISwipeActionsConfiguration(actions: [edit, delete])
        configure.performsFirstActionWithFullSwipe = false
        return configure
    }

    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
}



