//
//  AppTextView.swift
//  Exclusiv
//
//  Created by Thanh Tran on 1/18/17.
//  Copyright © 2017 SotaTek. All rights reserved.
//

import UIKit

@IBDesignable
class AppTextView: UIView {
    @IBInspectable var text: String! {
        set {
            self.textView.text = text
        }
        get {
            return self.textView.text
        }
    }
    @IBInspectable var font: UIFont? {
        set {
            self.textView.font = font
        }
        get {
            return self.textView.font
        }
    }
    
    @IBInspectable var textColor: UIColor? {
        set {
            self.textView.textColor = textColor
        }
        get {
            return self.textView.textColor
        }
    }
    
    @IBInspectable var textAlignment: NSTextAlignment {
        set {
            self.textView.textAlignment = textAlignment
        }
        get {
            return self.textView.textAlignment
        }
    }
    
    @IBInspectable var isEditable: Bool {
        set {
            self.textView.isEditable = isEditable
        }
        get {
            return self.textView.isEditable
        }
    }
    
    @IBInspectable var isSelectable: Bool {
        set {
            self.textView.isSelectable = isSelectable
        }
        get {
            return self.textView.isSelectable
        }
    }
    
    @IBInspectable var dataDetectorTypes: UIDataDetectorTypes {
        set {
            self.textView.dataDetectorTypes = dataDetectorTypes
        }
        get {
            return self.textView.dataDetectorTypes
        }
    }
    
    @IBInspectable var allowsEditingTextAttributes: Bool {
        set {
            self.textView.allowsEditingTextAttributes = allowsEditingTextAttributes
        }
        get {
            return self.textView.allowsEditingTextAttributes
        }
    }
    
    var attributedText: NSAttributedString! {
        set {
            self.textView.attributedText = attributedText
        }
        get {
            return self.textView.attributedText
        }
    }
    
    @IBInspectable var typingAttributes: [String : Any] {
        set {
            self.textView.typingAttributes = typingAttributes
        }
        get {
            return self.textView.typingAttributes
        }
    }

    @IBInspectable var maxLength: Int = 0
    
    
    private var horizontalSpacing: CGFloat = 15.0
    private var verticalSpacing: CGFloat = 15.0
    private var leftImageHorizontalPadding: CGFloat = 5.0
    
    lazy var textView: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 14)
        view.borderWidth = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var delegate: AppTextViewDelegate?
    
    private var underlineView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize() {
        self.addSubview(self.textView)
        self.textView.delegate = self
        
        setupLayer()
        setConstraints()
        self.clipsToBounds = true
    }
    
    private func setupLayer() {
        underlineView = UIView()
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = Constants.deselectedBrightColor
        self.addSubview(underlineView)
    }
    
    private func setConstraints() {
        let topTv = NSLayoutConstraint(item: textView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let leadingTv = NSLayoutConstraint(item: textView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let trailingTv = NSLayoutConstraint(item: textView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomTv = NSLayoutConstraint(item: textView, attribute: .bottom, relatedBy: .equal, toItem: self.underlineView, attribute: .top, multiplier: 1, constant: 15)
        
        let bottomLine = NSLayoutConstraint(item: underlineView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let heightLine = NSLayoutConstraint(item: underlineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
        let leadingLine = NSLayoutConstraint(item: underlineView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailingLine = NSLayoutConstraint(item: underlineView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        
        self.addConstraints([leadingTv, topTv, trailingTv, bottomTv, bottomLine, heightLine, leadingLine, trailingLine])
    }
    
    @objc fileprivate func didFocus() {
        UIView.animate(withDuration: 0.2) {
            self.underlineView.backgroundColor = Constants.selectedColor
        }
    }
    
    @objc fileprivate func didLoseFocus() {
        UIView.animate(withDuration: 0.2) {
            self.underlineView.backgroundColor = Constants.deselectedColor
        }
    }
}

@objc protocol AppTextViewDelegate: class {
    @available(iOS 2.0, *)
    @objc optional func textViewShouldBeginEditing(_ textView: AppTextView) -> Bool
    
    @available(iOS 2.0, *)
    @objc optional func textViewShouldEndEditing(_ textView: AppTextView) -> Bool
    
    @objc @available(iOS 2.0, *)
    optional func textViewDidBeginEditing(_ textView: AppTextView)
    
    @objc @available(iOS 2.0, *)
    optional func textViewDidEndEditing(_ textView: AppTextView)
}

extension AppTextView: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.didFocus()
        return self.delegate?.textViewShouldBeginEditing?(self) ?? true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.didLoseFocus()
        self.delegate?.textViewDidEndEditing?(self)
    }

    func textField(_ textView: UITextView, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textView.text ?? "") as NSString
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        return maxLength <= 0 || updatedText.characters.count <= maxLength
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = (textView.text ?? "") as NSString
        let updatedText = currentText.replacingCharacters(in: range, with: text)
        return maxLength <= 0 || updatedText.characters.count <= maxLength
    }
}
