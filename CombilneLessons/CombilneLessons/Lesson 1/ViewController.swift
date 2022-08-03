//
//  ViewController.swift
//  CombilneLessons
//
//  Created by Александр Кох on 03.08.2022.
//

import UIKit
import Combine

class FirstPipelineViewController: UIViewController {

    var viewModel = FirstPipelineViewModel()
    
    let label = UILabel()
    let textField = UITextField()
    
    var anyCancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.frame = CGRect(x: 250, y: 100, width: 100, height: 50)
        textField.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        textField.placeholder = "Ваше имя"
        view.addSubview(label)
        view.addSubview(textField)
        
        textField.delegate = self
        
       anyCancellable = viewModel.$validation
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: label)
    }
}

extension FirstPipelineViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        viewModel.name = string
        
        return true
    }
}

class FirstPipelineViewModel: ObservableObject {
    @Published var name = ""
    @Published var validation: String? = ""
    
    init() {
        $name
            .map { $0 .isEmpty ? "❌" : "✅" }
            .assign(to: &$validation)
    }
}
