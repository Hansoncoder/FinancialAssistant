//
//  InputView.swift
//  FinancialAssistant
//
//  Created by Hanson on 2018/4/14.
//  Copyright © 2018 Hanson. All rights reserved.
//

import UIKit

@objc protocol InputViewDelegate : NSObjectProtocol {
    @objc optional func inputViewEndInput()
}

class InputView: UIStackView {

    var delegate: InputViewDelegate?
    @IBOutlet weak var currentInterestRateTextField: UITextField!
    @IBOutlet weak var investmentRateTextField: UITextField!
    @IBOutlet weak var investmentDayTextField: UITextField!
    @IBOutlet weak var investmentMoneyTextField: UITextField!


    override func awakeFromNib() {
        super.awakeFromNib()
        investmentMoneyTextField.delegate = self
    }

    func currentInterestRate() -> Double {
        return Double(currentInterestRateTextField.text ?? "0") ?? 0
    }

    func investmentRate() -> Double {
        return Double(investmentRateTextField.text ?? "0") ?? 0
    }

    func investmentDay() -> Int {
        return Int(investmentDayTextField.text ?? "0") ?? 0
    }

    func investmentMoney() -> Double {
        return Double(investmentMoneyTextField.text ?? "0") ?? 0
    }
}

extension InputView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == currentInterestRateTextField {
            investmentRateTextField.becomeFirstResponder()
        } else if textField == investmentRateTextField {
            investmentDayTextField.becomeFirstResponder()
        } else if textField == investmentDayTextField {
            investmentMoneyTextField.becomeFirstResponder()
        } else if textField == investmentMoneyTextField {
            delegate?.inputViewEndInput?()
            investmentMoneyTextField.endEditing(true)
        }
        return true
    }
}
