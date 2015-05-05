JGFlipMenu
==========

Flipping menu system written in Swift. Uses @IBDesignable for quick and easy implementation. 

## Screen Example
<img src="https://raw.githubusercontent.com/ziligy/JGFlipMenu/master/JGFlipMenu.gif" alt="JGFlipMenu"/>

## Menu System:
* uses Interface Builder *no coding required* 
* menu items flip and expand/display linked UIViewControllers
* when the linked controller completes, it is contracted back in the menu item  
* menu controller automatically registers the delegate & tracking tags
* IBDesignable elements for text, font, text alignment, and colors
* uses custom transition to expand & contract linked UIViewControllers  

## Requirements
1. Xcode 6.1
2. iOS 8.0+

## Usage
1. Copy these class files to your Xcode Project 
	* JGFlipMenuItem.swift
	* JGFlipMenuController.swift
	* JGTransitionExpandContract.swift
2. Create a UIViewController in Interface Builder and assign JGFlipMenuController as class
3. Embed in a Navigation Controller (i.e. from Interface Builder menu: Editor->Embed In->Navigation Controller)
3. Drag UIViews *for each menu option*, and assign JGFlipMenuItem as class for each
4. For each JGMenuItem use the Attributes Inspector to modify the default IBInspectable elements as desired:
    * Front & back images
	* Title
	* Vertical & horizontal text centering
	* Front & back panel runtime colors
	* Font style and colors.
5. Create or assign UIViewControllers to link your menu options to.
6. **Important:** for each UIViewController it is *required* that you assign a Storyboard ID that *matches exactly* the JGMenuItem Title.

## Example
Included is an example.


