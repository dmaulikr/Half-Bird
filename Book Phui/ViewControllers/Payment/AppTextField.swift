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
    @IBInspectable var leftImage: UIImage? {
        didSet {
            self.leftImageView.image = leftImage
        }
    }
    
    @IBInspectable var text: String? {
        set {
            self.textField.text = newValue
        }
        get {
            return self.textField.text
        }
    }
    
    var attributedText: NSAttributedString?{
        set {
            self.textField.attributedText = newValue
        }
        get {
            return self.textField.attributedText
        }
    }
    
    @IBInspectable var textColor: UIColor? {
        set {
            self.textField.textColor = newValue
        }
        get {
            return self.textField.textColor
        }
    }
    
    @IBInspectable var font: UIFont? {
        set {
            self.textField.font = newValue
        }
        get {
            return self.textField.font
        }
    }
    
    @IBInspectable var textAlignment: NSTextAlignment {
        set {
            self.textField.textAlignment = newValue
        }
        get {
            return self.textField.textAlignment
        }
    }
    
    @IBInspectable var defaultTextAttributes: [String : Any] {
        set {
            self.textField.defaultTextAttributes = newValue
        }
        get {
            return self.textField.defaultTextAttributes
        }
    }
    
    
    @IBInspectable var placeholder: String? {
        set {
            self.textField.placeholder = newValue
        }
        get {
            return self.textField.placeholder
        }
    }
    
    var attributedPlaceholder: NSAttributedString? {
        set {
            self.textField.attributedPlaceholder = newValue
        }
        get {
            return self.textField.attributedPlaceholder
        }
    }
    
    @IBInspectable var clearsOnBeginEditing: Bool {
        set {
            self.textField.clearsOnBeginEditing = newValue
        }
        get {
            return self.textField.clearsOnBeginEditing
        }
    }
    
    @IBInspectable var adjustsFontSizeToFitWidth: Bool {
        set {
            self.textField.adjustsFontSizeToFitWidth = newValue
        }
        get {
            return self.textField.adjustsFontSizeToFitWidth
        }
    }
    
    @IBInspectable var minimumFontSize: CGFloat {
        set {
            self.textField.minimumFontSize = newValue
        }
        get {
            return self.textField.minimumFontSize
        }
    }
    
    @IBInspectable var background: UIImage? {
        set {
            self.textField.background = newValue
        }
        get {
            return self.textField.background
        }
    }
    
    @IBInspectable var disabledBackground: UIImage? {
        set {
            self.textField.disabledBackground = newValue
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
            self.textField.allowsEditingTextAttributes = newValue
        }
        get {
            return self.textField.allowsEditingTextAttributes
        }
    }
    
    @IBInspectable var typingAttributes: [String : Any]? {
        set {
            self.textField.typingAttributes = newValue
        }
        get {
            return self.textField.typingAttributes
        }
    }
    
    @IBInspectable var clearButtonMode: UITextFieldViewMode {
        set {
            self.textField.clearButtonMode = newValue
        }
        get {
            return self.textField.clearButtonMode
        }
    }
    
    @IBInspectable var keyboardType: UIKeyboardType {
        set {
            self.textField.keyboardType = newValue
        }
        get {
            return self.textField.keyboardType
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
    
    private lazy var leftImageView: UIImageView = {
        let view = UIImageView(image: self.leftImage)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(1000, for: .vertical)
        
        return view
    }()
    
    weak var delegate: AppTextFieldDelegate?
    
    private let startPoint = CGPoint(x: 0.0, y: 0.5)
    private let endPoint = CGPoint(x: 1.0, y: 0.5)
    
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
        self.addSubview(self.leftImageView)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print(self.textField.frame)
    }
    
    private func setConstraints() {
        let topImage = NSLayoutConstraint(item: leftImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let leadingImage = NSLayoutConstraint(item: leftImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        
        let topTv = NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let leadingTv = NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: self.leftImageView, attribute: .trailing, multiplier: 1, constant: 0)
        let trailingTv = NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let equalWidth = NSLayoutConstraint(item: textField, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
        
        let bottomLine = NSLayoutConstraint(item: underlineView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let heightLine = NSLayoutConstraint(item: underlineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
        let leadingLine = NSLayoutConstraint(item: underlineView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailingLine = NSLayoutConstraint(item: underlineView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        
        self.addConstraints([topImage, leadingImage, leadingTv, topTv, trailingTv, bottomLine, heightLine, leadingLine, trailingLine, equalWidth])
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
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: self.leftImageHorizontalPadding + self.leftImageView.bounds.width + self.textField.bounds.width + self.horizontalSpacing, height: self.leftImageView.bounds.width + self.verticalSpacing + self.underlineView.bounds.height)
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
