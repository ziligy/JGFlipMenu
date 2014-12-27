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

@IBDesignable class JGFlipMenuItem: UIView, UITextViewDelegate {

    let frontSideView = UIView()
    let backSideView = UIView()
    
    var frontSideTitle: UITextView!
    var backSideTitle: UITextView!
    
    var delegate: JGFlipMenuItemDelegate?
    
    var menuItemFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
    
    var frontFacing = true
    
    @IBInspectable var title: String = "Title" {
        didSet {
            frontSideTitle.text = title
            frontSideTitle = setTextConditionals(frontSideTitle)
        }
    }
    
    @IBInspectable var backTitle: String = "back side" {
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
    
    func setup() {
        
        menuItemFrame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        backSideView.frame = menuItemFrame
        backSideView.backgroundColor = UIColor.whiteColor()
        backSideTitle = makeText(backTitle)
        
        frontSideView.frame = menuItemFrame
        frontSideView.backgroundColor = UIColor.whiteColor()
        frontSideTitle = makeText(title)
        
        self.backSideView.addSubview(backSideTitle)
        self.addSubview(backSideView)
            
        self.frontSideView.addSubview(frontSideTitle)
        self.addSubview(frontSideView)
    }
    
    func makeText(text: String)-> UITextView {
        var textView = UITextView(frame: menuItemFrame)
        
        textView.delegate = self
        textView.backgroundColor = UIColor.clearColor()
        textView.text = text
        
        textView = setTextConditionals(textView)
    
        return textView
    }
    
    func setTextConditionals(textView: UITextView)-> UITextView {
        
        textView.font = boldFont ? UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline) : UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        textView.textAlignment = centerHorizontal ? .Center : .Left
        textView.frame = centerVertical ? resizeTextViewFrameToCenter(textView, fitToFrame: menuItemFrame) : menuItemFrame
        
        return textView
    }
    
    func resizeTextViewFrameToCenter(textView: UITextView, fitToFrame: CGRect)-> CGRect {
        
        let textViewCGSize = textView.sizeThatFits(CGSizeMake(fitToFrame.width, fitToFrame.height))
        let topInset: CGFloat = (fitToFrame.height - textViewCGSize.height)/2
        
        if topInset < 0 { return fitToFrame } // scroll is on
        
        let resizedTextFrame = CGRectMake(0, topInset, fitToFrame.width, fitToFrame.height-topInset)
        return resizedTextFrame
    }
    
    func flipToBackSide() {
    
        let transitionOptions = UIViewAnimationOptions.TransitionFlipFromRight
        
        UIView.transitionFromView(frontSideView, toView: backSideView, duration: 0.5, options: transitionOptions,
            
            completion: { finished in
                self.triggerFrontSideDelegate()
        })
    }
    
    func flipToFrontSide() {
        
        let transitionOptions = UIViewAnimationOptions.TransitionFlipFromLeft
        
        UIView.transitionFromView(backSideView, toView: frontSideView, duration: 0.5, options: transitionOptions,
            
            completion: { finished in
                self.triggerBackSideDelegate()
        })
    }
    
    // user touched! & dont allow textview editing
    func textViewShouldBeginEditing(textView: UITextView!)->Bool {
        
        if frontFacing {
            frontFacing = false
            flipToBackSide()
        } else {
            frontFacing = true
            flipToFrontSide()
        }
        
        return false
    }
    
    func triggerFrontSideDelegate() {
        self.delegate?.frontSideSelected(self.tag)
    }
    
    func triggerBackSideDelegate() {
        self.delegate?.backSideSelected(self.tag)
    }
    
}
