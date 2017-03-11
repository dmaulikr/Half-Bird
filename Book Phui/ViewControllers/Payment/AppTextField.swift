//
//  AppTextField.swift
//  Exclusiv
//
//  Created by Thanh Tran on 1/18/17.
//  Copyright © 2017 SotaTek. All rights reserved.
//

import UIKit

@IBDesignable
class AppTextField: UIView {
    
    @IBInspectable var text: String? {
        set {
            self.textField.text = text
        }
        get {
            return self.textField.text
        }
    }
    
    var attributedText: NSAttributedString?{
        set {
            self.textField.attributedText = attributedText
        }
        get {
            return self.textField.attributedText
        }
    }
    
    @IBInspectable var textColor: UIColor? {
        set {
            self.textField.textColor = textColor
        }
        get {
            return self.textField.textColor
        }
    }
    
    @IBInspectable var font: UIFont? {
        set {
            self.textField.font = font
        }
        get {
            return self.textField.font
        }
    }
    
    @IBInspectable var textAlignment: NSTextAlignment {
        set {
            self.textField.textAlignment = textAlignment
        }
        get {
            return self.textField.textAlignment
        }
    }
    
    @IBInspectable var defaultTextAttributes: [String : Any] {
        set {
            self.textField.defaultTextAttributes = defaultTextAttributes
        }
        get {
            return self.textField.defaultTextAttributes
        }
    }
    
    
    @IBInspectable var placeholder: String? {
        set {
            self.textField.placeholder = placeholder
        }
        get {
            return self.textField.placeholder
        }
    }
    
    var attributedPlaceholder: NSAttributedString? {
        set {
            self.textField.attributedPlaceholder = attributedPlaceholder
        }
        get {
            return self.textField.attributedPlaceholder
        }
    }
    
    @IBInspectable var clearsOnBeginEditing: Bool {
        set {
            self.textField.clearsOnBeginEditing = clearsOnBeginEditing
        }
        get {
            return self.textField.clearsOnBeginEditing
        }
    }
    
    @IBInspectable var adjustsFontSizeToFitWidth: Bool {
        set {
            self.textField.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        }
        get {
            return self.textField.adjustsFontSizeToFitWidth
        }
    }
    
    @IBInspectable var minimumFontSize: CGFloat {
        set {
            self.textField.minimumFontSize = minimumFontSize
        }
        get {
            return self.textField.minimumFontSize
        }
    }
    
    @IBInspectable var background: UIImage? {
        set {
            self.textField.background = background
        }
        get {
            return self.textField.background
        }
    }
    
    @IBInspectable var disabledBackground: UIImage? {
        set {
            self.textField.disabledBackground = disabledBackground
        }
        get {
            return self.textField.disabledBackground
        }
    }
    
    
    var isEditing: Bool {
        get {
            return self.textField.isEditing
        }
    }
    
    @IBInspectable var allowsEditingTextAttributes: Bool {
        set {
            self.textField.allowsEditingTextAttributes = allowsEditingTextAttributes
        }
        get {
            return self.textField.allowsEditingTextAttributes
        }
    }
    
    @IBInspectable var typingAttributes: [String : Any]? {
        set {
            self.textField.typingAttributes = typingAttributes
        }
        get {
            return self.textField.typingAttributes
        }
    }
    
    @IBInspectable var clearButtonMode: UITextFieldViewMode {
        set {
            self.textField.clearButtonMode = clearButtonMode
        }
        get {
            return self.textField.clearButtonMode
        }
    }
    
    private var horizontalSpacing: CGFloat = 15.0
    private var verticalSpacing: CGFloat = 15.0
    private var leftImageHorizontalPadding: CGFloat = 5.0
    
    lazy var textField: UITextField = {
        let view = UITextField()
        view.font = UIFont.systemFont(ofSize: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .none
        view.setContentHuggingPriority(249, for: .horizontal)
        view.setContentHuggingPriority(1000, for: .vertical)
        return view
    }()
    
    weak var delegate: AppTextFieldDelegate?
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
        self.addSubview(self.textField)
        self.textField.delegate = self
        setupLayer()
        setConstraints()
        self.clipsToBounds = true
    }
    
    private func setupLayer() {
        underlineView = UIView()
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = Constants.deselectedColor
        self.addSubview(underlineView)
    }

    private func setConstraints() {
        let topTv = NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let leadingTv = NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 15)
        let trailingTv = NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        
        let bottomLine = NSLayoutConstraint(item: underlineView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let heightLine = NSLayoutConstraint(item: underlineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
        let leadingLine = NSLayoutConstraint(item: underlineView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailingLine = NSLayoutConstraint(item: underlineView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        self.addConstraints([leadingTv, topTv, trailingTv, bottomLine, heightLine, leadingLine, trailingLine])
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

@objc protocol AppTextFieldDelegate: class {
    @objc @available(iOS 2.0, *)
    optional func textFieldShouldBeginEditing(_ textField: AppTextField) -> Bool // return NO to disallow editing.
    
    @objc @available(iOS 2.0, *)
    optional func textFieldDidBeginEditing(_ textField: AppTextField) // became first responder
    
    @objc @available(iOS 2.0, *)
    optional func textFieldShouldEndEditing(_ textField: AppTextField) -> Bool // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    
    @objc @available(iOS 2.0, *)
    optional func textFieldDidEndEditing(_ textField: AppTextField) // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
}

extension AppTextField: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.didFocus()
        return self.delegate?.textFieldShouldBeginEditing?(self) ?? true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.didLoseFocus()
        self.delegate?.textFieldDidEndEditing?(self)
    }
}
