//
//  ViewController.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 17/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Task {
            do{
                let result = try await NetworkManager.shared.getPersons(for: Endpoint.people)
                print(result)
            }catch {
               print("error")
            }
            
        }
    }
    
    
}

