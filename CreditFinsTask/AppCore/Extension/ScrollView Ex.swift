//
//  ScrollView Ex.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 28/01/2022.
//

import UIKit

extension UIScrollView {

    func isAtBottom() -> Bool {
        return  contentOffset.y > (contentSize.height - frame.height)
    }
}
