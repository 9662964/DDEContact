//
//  CreateCompanyController.swift
//  DDEContact
//
//  Created by iljoo Chae on 7/20/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import CoreData

protocol CreateCompanyViewControllerDelegate {
    func didAddCompany(company: Company)
    func didEditCompany(company: Company)
}

class CreateCompanycontroller: UIViewController {
    
    var company: Company? {
        didSet {
            nameTextField.text = company?.name
        }
    }
    var delegate: CreateCompanyViewControllerDelegate?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        //enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        setupUI()
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightBlue
        setupNavigationStyle()
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action:#selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //ternary syntax : For edit function
        navigationItem.title = company == nil ? "Create Company" : "Edit Company"
    }
    
    
    
    @objc private func handleSave() {
        print("Tying to save company")
        
        if company == nil {
            createCompany()
        }else{
            saveCompanyChanges()
        }
    }

    private func saveCompanyChanges() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        company?.name = nameTextField.text
        do {
            try context.save()
            //save succeded : Save and then dismiss
            dismiss(animated: true, completion: {self.delegate?.didEditCompany(company: self.company!)
            })
        }catch let saveErr{
            print(saveErr)
        }

    }
    
    
    private func createCompany() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
               let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
               company.setValue(nameTextField.text, forKey: "name")
               //perform the save
               do {
                   try context.save()
                   //Success
                   dismiss(animated: true, completion: {
                       self.delegate?.didAddCompany(company: company as! Company)
                   })
               }catch let saveError{
                   print("Failed to save company:",saveError)
               }
        
    }
    
    
    private func setupUI() {
        let lightBlueBackgroundView = UIView()
        lightBlueBackgroundView.backgroundColor = UIColor.lightBlue
        lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lightBlueBackgroundView)
        lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBlueBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16).isActive = true
        //        nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //use following will cover till bottom
        //nameLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
}//End Of Class

extension UIViewController {
    func setupNavigationStyle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.backgroundColor = UIColor.lightRed
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .red
        navigationController?.navigationBar.tintColor = .white
        //fix bug for title in black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

