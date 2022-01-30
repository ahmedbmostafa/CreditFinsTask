//
//  View Ex.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 29/01/2022.
//

import UIKit

class RoundViewShadow: UIView {
    override func awakeFromNib() {
        setupView()
    }
    func setupView() {
        self.layer.cornerRadius =  8
        self.layer.shadowColor = #colorLiteral(red: 0.0862745098, green: 0.5647058824, blue: 0.6901960784, alpha: 1)
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
    }
}
