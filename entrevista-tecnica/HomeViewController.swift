//
//  HomeViewController.swift
//  entrevista-tecnica
//
//  Created by Thiago Firsen Bernardino on 20/11/25.
//

import UIKit
import SwiftUI
import Foundation

class ItemModel {
    var title: String
    var number: Int
    
    init(title: String, number: Int) {
        self.title = title
        self.number = number
    }
}


class HomeViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    var items: [ItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "Lista muito grande de itens"
        
        items = (0...500).map { ItemModel(title: "Item", number: $0) }
        
        setupScroll()
        setupContent()
    }
    
    func setupScroll() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    
    func setupContent() {
        for (i, model) in items.enumerated() {
            let label = UILabel()
            label.text = "\(model.title) \(model.number)"
            label.textColor = .white
            if model.number % 2 == 0 {
                label.backgroundColor = .systemBlue
            } else {
                label.backgroundColor = .systemYellow
            }
            label.textAlignment = .center
            label.heightAnchor.constraint(equalToConstant: 50).isActive = true
            label.layer.cornerRadius = 8
            label.clipsToBounds = true
            label.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self,
                                             action: #selector(handleTap(_:)))
            tap.name = "\(i)"
            label.addGestureRecognizer(tap)
            
            stackView.addArrangedSubview(label)
        }
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let indexString = gesture.name,
              let index = Int(indexString) else { return }
        
        let indexNumber = index - 1
        let item = items[indexNumber]
        
        let vc = DetailViewController()
        vc.textFromList = "\(item.title) \(item.number)"
        navigationController?.pushViewController(vc, animated: true)
    }
}

class DetailViewController: UIViewController {
    
    var textFromList: String = ""
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Detalhes"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Você abriu: \(textFromList)"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
