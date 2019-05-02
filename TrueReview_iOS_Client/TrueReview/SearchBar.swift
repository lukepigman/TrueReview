//
//  SearchBar.swift
//  TrueReview
//
//  Created by Luke Pigman on 4/15/19.
//  Copyright © 2019 Billy Lim. All rights reserved.
//

import UIKit

class SearchBar: UISearchBar {

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        searchBarStyle = UISearchBarStyle.minimal
        
        // Configure text field
        let textField = value(forKey: "_searchField") as! UITextField
        
        // This will remove the border style, we need to do this
        // in order to configure border style through `textField.layer`
        // otherwise we'll have 2 borders.
        // You can remove `textField.borderStyle = .none` to see it yourself.
        textField.borderStyle = .none
        textField.clipsToBounds = true
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.layer.cornerRadius = 6.0
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textColor = UIColor(named: "#555555")
    }
}
