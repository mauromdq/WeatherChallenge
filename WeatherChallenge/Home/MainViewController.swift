//
//  ViewController.swift
//  WeatherChallenge
//
//  Created by Mauro Sebastian Garcia on 11/06/2020.
//  Copyright © 2020 Mauro Sebastian Garcia. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ViewController {
    
    typealias ViewModel = MainViewModel
    
    @IBOutlet private weak var currentButton: UIButton!
    @IBOutlet private weak var dailyButton: UIButton!
    @IBOutlet private weak var cityTextfield: UITextField!
    
    private var tabViewControllers: [UIViewController] = []
    private var cityPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTextfield.delegate = self
        configUI()
        bindSettings()
    }
    
    private var viewModel: MainViewModel!

    func configure(with viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    func bindSettings() {
        _ = viewModel.selectedCity.bidirectionalBind(to: cityTextfield.reactive.text)        
        _ = currentButton.reactive.isEnabled.bind(signal: viewModel.canContinue.toSignal())
        _ = currentButton.reactive.tap.observeNext { [weak self] in
            self?.viewModel.toCurrent()
            self?.cityTextfield.resignFirstResponder()
        }
        _ = dailyButton.reactive.isEnabled.bind(signal: viewModel.canContinue.toSignal())
        _ = dailyButton.reactive.tap.observeNext { [weak self] in
            self?.viewModel.toDaily()
            self?.cityTextfield.resignFirstResponder()
        }
        _ = view.reactive.tapGesture().observeNext { [weak self] _ in
            self?.view.endEditing(true)
        }
        viewModel.cityNames.bind(to: cityPickerView) { (cities, row, _, _) -> String? in
            cities[row]
        }
        _ = cityPickerView.reactive.selectedRow.observeNext { [weak self] in
            self?.viewModel.onUpdate(withStateAtIndex: $0.0)
        }
    }
    
    func configUI() {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .gray
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Listo", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneTapped))
        let hiddenButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([hiddenButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
                
        cityPickerView.backgroundColor = .white
        cityTextfield.inputView = cityPickerView
        cityTextfield.tintColor = .clear
        cityTextfield.inputAccessoryView = toolBar        
    }
}

extension MainViewController: UITextFieldDelegate {
    @objc func doneTapped() {
        self.cityTextfield.resignFirstResponder()
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
