JGFlipMenu
==========

Flipping menu system written in Swift. Uses @IBDesignable for quick and easy implementation. 

## Screen Example
<img src="https://raw.githubusercontent.com/ziligy/JGFlipMenu/master/JGFlipMenu.gif" alt="JGFlipMenu"/>

## Menu System:
- [x] menu items flip front & back side from user touch
- [x] menu controller automatically registers the delegate & tracking tags
- [x] IBDesignable elements for text, font, text alignment, and colors

## Requirements
1. Xcode 6.1
2. iOS 7.0+

## Usage
1. Copy JGFlipMenuItem.swift & JGFlipMenuController.swift files to your Xcode project
2. Create UIViewController in Interface Builder and assign JGFlipMenuController as class
3. Drop UIViews for each menu option, and assign JGFlipMenuItem as class for each
4. Use the Identity Inspector to modify the IBInspectable elements: Title, Back Title, vertical & horizontal text centering, front & back panel runtime colors, font style and colors.

## Example
Included is an example.


