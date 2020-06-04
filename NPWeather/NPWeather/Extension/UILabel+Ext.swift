//
//  UILabel+Ext.swift
//  NPWeather
//
//  Created by Arvin Quiliza on 6/4/20.
//  Copyright © 2020 arvinq. All rights reserved.
//

import UIKit

extension UILabel {
    func setImageAndText(usingImage image: UIImage, andText text: String) {
        //Create Attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        //Set bound to reposition
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        //Create string with attachment
        let attachmentStringWithImage = NSAttributedString(attachment: imageAttachment)
        
        //Initialize mutable string
        let mutableAttributedString = NSMutableAttributedString()
        //Add image to mutable string
        mutableAttributedString.append(attachmentStringWithImage)
        
        //Add the text to mutable string
        let textString = NSAttributedString(string: " " + text)
        mutableAttributedString.append(textString)
        
        self.textAlignment = .left;
        self.attributedText = mutableAttributedString
    }
}
