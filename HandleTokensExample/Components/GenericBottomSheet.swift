//
//  GenericBottomSheet.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 29/11/24.
//

import UIKit

class GenericBottomSheet : UIView {
        
    private let contentView: UIView = {
        let it = UIView()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.backgroundColor = .white
        it.layer.cornerRadius = 16
        it.layer.masksToBounds = true
        return it
        
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        addSubViews()
    }
    
    private let contentText: UILabel = {
        let it = UILabel()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        it.font = UIFont.systemFont(ofSize: 25)
        it.numberOfLines = 0
        it.lineBreakMode = .byWordWrapping
        return it
    }()
    
    
    
    private func addSubViews() {
        addSubview(contentView)
        addSubview(contentText)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupConstraints()
    }
    
    
    private func setupConstraints() {
        guard let superview = self.superview else { return }
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: superview.widthAnchor),
            self.heightAnchor.constraint(equalTo: superview.heightAnchor),
            

            
            contentView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            
            
            contentText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -120)
            
        ])
    }
    
}
