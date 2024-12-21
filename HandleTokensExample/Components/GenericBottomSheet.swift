//
//  GenericBottomSheet.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 29/11/24.
//

import UIKit

class GenericBottomSheet : UIView {
        
    static let shared = GenericBottomSheet()
        
    let contentView: UIView = {
        let it = UIView()
        it.translatesAutoresizingMaskIntoConstraints = false
        it.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        it.layer.cornerRadius = 16
        it.layer.masksToBounds = true
        return it
        
    }()
    
    private let primaryButton: UIButton = {
        let it = UIButton()
        it.backgroundColor = .black
        it.layer.cornerRadius = 10
        it.setTitle("ok", for: .normal)
        it.setTitleColor(UIColor.white, for: .normal)
        it.translatesAutoresizingMaskIntoConstraints = false
        it.addTarget(nil, action: #selector(buttonTouchDown), for: .touchDown)
        it.addTarget(nil, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside])
        return it
    }()
    
     private init() {
        super.init(frame: .zero)
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
        it.text = "Your session has expired. Please log in again to continue."
        it.font = UIFont.systemFont(ofSize: 25)
        it.numberOfLines = 0
        it.lineBreakMode = .byWordWrapping
        return it
    }()
    
    
    
    private func addSubViews() {
        addSubview(contentView)
        contentView.addSubview(contentText)
        contentView.addSubview(primaryButton)
//        addSubview(contentText)
//        addSubview(primaryButton)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        resetConstraints()
        setup()
        setupConstraints()
    }
    
    private func resetConstraints() {
         self.removeConstraints(self.constraints)
     }
    
    @objc private func buttonTouchDown() {
        primaryButton.alpha = 0.5
    }

    @objc private func buttonTouchUp() {
        primaryButton.alpha = 1.0
        dismiss()
    }
    
    func show() {
        NotificationCenter.default.post(name: .showBottomSheet, object: nil)
    }
    
    func dismiss() {
        NotificationCenter.default.post(name: .hideBottomSheet, object: nil)
    }
    
    func handleBottomSheetAnimation() {
        guard let window = UIApplication.shared.windows.first else { return }
        
        contentView.frame.origin.y = bounds.height
        UIView.animate(withDuration: 0.3) {
            self.contentView.frame.origin.y = self.bounds.height - 448
//            self.dimmingView.alpha = 1
        }

    }
    
    
    func handleDismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.frame.origin.y = self.bounds.height
            self.backgroundColor = .clear
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    private func setupConstraints() {
        guard let superview = self.superview else { return }
        
        print("test heigth: \(superview.heightAnchor)")
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: superview.widthAnchor),
            self.heightAnchor.constraint(equalTo: superview.heightAnchor),
            

            
            contentView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            
            
            contentText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentText.bottomAnchor.constraint(equalTo: primaryButton.topAnchor, constant: -80),
            
            primaryButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            primaryButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            primaryButton.heightAnchor.constraint(equalToConstant: 50),
            primaryButton.widthAnchor.constraint(equalToConstant: 150)
        

            
        ])
    }
    
}
