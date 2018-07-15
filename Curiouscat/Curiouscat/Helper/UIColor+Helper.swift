//
//  UIColor+Helper.swift
//  Curiouscat
//
//  Created by Harry Twan on 2018/7/15.
//  Copyright © 2018年 Harry Twan. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(rgbString: String) {
        var cString: String = rgbString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            self.init(cgColor: UIColor.gray.cgColor)
            return
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    convenience init(rgb: UInt32, alpha: Double = 1.0) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
    convenience init(color: UIColor, alpha: CGFloat = 1.0) {
        self.init(
            red: color.r(),
            green: color.g(),
            blue: color.b(),
            alpha: alpha
        )
    }

    func r() -> CGFloat {
        return self.cgColor.components![0]
    }
    
    func g() -> CGFloat {
        let count = self.cgColor.numberOfComponents
        if (count == 2) {
            return self.cgColor.components![0]
        } else {
            return self.cgColor.components![1]
        }
    }
    
    func b() -> CGFloat {
        let count = self.cgColor.numberOfComponents
        if (count == 2) {
            return self.cgColor.components![0]
        } else {
            return self.cgColor.components![2]
        }
    }
    
    func a() -> CGFloat {
        let count = self.self.cgColor.numberOfComponents
        return self.cgColor.components![count - 1]
    }
    
    func hex() -> String {
        guard let colorRef = self.cgColor.components else {
            return "#FFFFFF"
        }
        let r:CGFloat = colorRef[0]
        let g:CGFloat = colorRef[1]
        let b:CGFloat = colorRef[2]
        
        return String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
    }
}
