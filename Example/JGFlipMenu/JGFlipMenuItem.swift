//
//  JGFlipMenuItem
//  JGFlipMenu
//
//  Created by Jeff on 12/22/14.
//  Copyright (c) 2014 Jeff Greenberg. All rights reserved.
//

import UIKit

protocol JGFlipMenuItemDelegate{
    func frontSideSelected(indexTag: Int)
    func backSideSelected(indexTag: Int)
}

@IBDesignable class JGFlipMenuItem: UIView,  UITextViewDelegate {

    internal var delegate: JGFlipMenuItemDelegate?
    
    internal var frontSideTitle: UITextView!
    internal var frontSideImageView: UIImageView!
    internal var backSideImageView: UIImageView!
    internal var backSideTitle: UITextView!
    
    private let frontSideView = UIView()
    internal var backSideView = UIView()
    
    private var menuItemFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
    
    private var frontFacing = true
    
    @IBInspectable  var frontImage: UIImage=UIImage() {
        didSet  {
            self.frontSideImageView.image = self.frontImage
               }
    }
    
    @IBInspectable  var backImage: UIImage=UIImage() {
        didSet  {
            self.backSideImageView.image = self.backImage
        }
    }
    
    @IBInspectable var title: String = "Title" {
        didSet {
            frontSideTitle.text = title
            frontSideTitle = setTextConditionals(frontSideTitle)
        }
    }
    
    @IBInspectable var backTitle: String = "" {
        didSet {
            backSideTitle.text = backTitle
            backSideTitle = setTextConditionals(backSideTitle)
        }
    }

    @IBInspectable var centerHorizontal: Bool = true {
        didSet {
            frontSideTitle = setTextConditionals(frontSideTitle)
            backSideTitle = setTextConditionals(backSideTitle)
        }
    }
    
    @IBInspectable var centerVertical: Bool = true {
        didSet {
            frontSideTitle = setTextConditionals(frontSideTitle)
            backSideTitle = setTextConditionals(backSideTitle)
        }
    }
    
    @IBInspectable var panelFrontColor: UIColor = UIColor.whiteColor() {
        didSet {
            frontSideView.backgroundColor = panelFrontColor
            
            
                    }
    }
    
    @IBInspectable var panelBackColor: UIColor = UIColor.whiteColor() {
        didSet {
            backSideView.backgroundColor = panelBackColor
        }
    }
    
    @IBInspectable var boldFont: Bool = false {
        didSet {
            frontSideTitle = setTextConditionals(frontSideTitle)
            backSideTitle = setTextConditionals(backSideTitle)
        }
    }
    
    @IBInspectable var fontFrontColor: UIColor = UIColor.blackColor() {
        didSet {
            frontSideTitle.textColor = fontFrontColor
        }
    }
    
    @IBInspectable var fontBackColor: UIColor = UIColor.blackColor() {
        didSet {
            backSideTitle.textColor = fontBackColor
        }
    }
    
    override func prepareForInterfaceBuilder() {
        menuItemFrame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        frontSideTitle.frame = menuItemFrame
        backSideImageView.frame = menuItemFrame
        frontSideImageView.frame = menuItemFrame
        
        title = frontSideTitle.text
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    internal func flipToBackSide() {
        
        if !self.frontFacing {return}
        
        let transitionOptions = UIViewAnimationOptions.TransitionFlipFromRight
        
        UIView.transitionFromView(frontSideView, toView: backSideView, duration: 0.5, options: transitionOptions,
            
            completion: { finished in
                self.frontFacing = false
                self.triggerFrontSideDelegate()
        })
        
    }
    
    internal func flipToFrontSide() {
        
        if self.frontFacing {return}
        
        let transitionOptions = UIViewAnimationOptions.TransitionFlipFromLeft | .OverrideInheritedOptions | .AllowAnimatedContent
        
        UIView.transitionFromView(backSideView, toView: frontSideView, duration: 0.5, options: transitionOptions,
            
            completion: { finished in
                self.frontFacing = true
                self.triggerBackSideDelegate()
        })
    }
    
    // user touched! & dont allow textview editing
    internal func textViewShouldBeginEditing(textView: UITextView!)->Bool {
        if frontFacing {
            flipToBackSide()
        } else {
            flipToFrontSide()
        }
        
        return false
    }
    
    private func setup() {
        
        menuItemFrame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        backSideView.frame = menuItemFrame
        backSideView.backgroundColor = UIColor.whiteColor()
        backSideTitle = makeText(backTitle)
        backSideImageView = makeImage(backImage)
        
        
        frontSideView.frame = menuItemFrame
        frontSideView.backgroundColor = UIColor.whiteColor()
        frontSideTitle = makeText(title)
        frontSideImageView = makeImage(frontImage)
        
        self.backSideView.addSubview(backSideImageView)
        self.backSideView.addSubview(backSideTitle)
        self.addSubview(backSideView)
            
        self.frontSideView.addSubview(frontSideImageView)
        self.frontSideView.addSubview(frontSideTitle)
        self.addSubview(frontSideView)
    }
    
    private func makeText(text: String)-> UITextView {
        var textView = UITextView(frame: menuItemFrame)
        
        textView.delegate = self
        textView.backgroundColor = UIColor.clearColor()
        textView.text = text
        
        textView = setTextConditionals(textView)
    
        return textView
    }
    private func makeImage(image: UIImage)-> UIImageView {
        var imageView = UIImageView(frame: menuItemFrame)
        
        imageView.image = image
        
        return imageView
    }

    
    private func setTextConditionals(textView: UITextView)-> UITextView {
        
        textView.font = boldFont ? UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline) : UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        textView.textAlignment = centerHorizontal ? .Center : .Left
        textView.frame = centerVertical ? resizeTextViewFrameToCenter(textView, fitToFrame: menuItemFrame) : menuItemFrame
        
        return textView
    }
    
    private func resizeTextViewFrameToCenter(textView: UITextView, fitToFrame: CGRect)-> CGRect {
        
        let textViewCGSize = textView.sizeThatFits(CGSizeMake(fitToFrame.width, fitToFrame.height))
        let topInset: CGFloat = (fitToFrame.height - textViewCGSize.height)/2
        
        if topInset < 0 { return fitToFrame } // scroll is on
        
        let resizedTextFrame = CGRectMake(0, topInset, fitToFrame.width, fitToFrame.height-topInset)
        return resizedTextFrame
    }
    
    private func triggerFrontSideDelegate() {
        self.delegate?.frontSideSelected(self.tag)
    }
    
    internal func triggerBackSideDelegate() {
        self.delegate?.backSideSelected(self.tag)
    }
    
}
