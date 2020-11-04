//
//  ResultView.swift
//  FirstApp
//
//  Created by Ioan-Vlad Vamos on 2020-11-04.
//

import UIKit

class ResultView: UIView {

    private let titleLabel = UILabel()
    let resultLabel = UILabel()
    let backButton = UIButton()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
            
        
        
        // Title set-up
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = NSLocalizedString("Your Result", comment: "Result title")
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        // Result set-up
        resultLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        resultLabel.adjustsFontForContentSizeCategory = true
        addSubview(resultLabel)

        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        resultLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        
        //Go back button set-up
        backButton.setTitleColor(.systemBlue, for: .normal)
        backButton.setTitle("Back to start", for: .normal)
        addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        backButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        //image
        
    }
    
    
    
    
}
