//
//  RatingControl.swift
//  FirstApp
//
//  Created by maxim on 15.03.16.
//  Copyright © 2016 Profit Software. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    // Properties part
    var rating = 0 {
        didSet {    // Property observer didSet is called immediately before or after the value changes
            setNeedsLayout()    // Layoute update is triggered
        }
    }
    var ratingButtons = [UIButton]() // Array of UIButton type declared
    var spacing = 5
    var stars = 5
    
    // Initialization
    override func layoutSubviews() {
        // Set the button's width and height to a square the size of the frame's height.
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus some spacing.
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        //let spacing = Int(frame.size.height)
        //let stars = Int(frame.size.height)
        let width = (buttonSize + spacing) * stars
        
        return CGSize(width: width, height: buttonSize)
    }
    
    // Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        for _ in 0..<stars { // half-open range operator '_' - wildcard of execution times
        let button = UIButton()
        button.setImage(emptyStarImage, forState: .Normal)
        button.setImage(filledStarImage, forState: .Selected)
        button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)
        ratingButtons += [button]
        addSubview(button)
        }
    }
    
    // Button handler
    func ratingButtonTapped(button: UIButton){
        rating = ratingButtons.indexOf(button)! + 1
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates(){
        for (index, button) in ratingButtons.enumerate() {
        // If the index of a button is less than the rating, that button shouldn't be selected
        button.selected = index < rating
        }
    }

}