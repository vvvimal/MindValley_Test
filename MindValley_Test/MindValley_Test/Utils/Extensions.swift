//
//  Extensions.swift
//  MindValley_Test
//
//  Created by Venugopalan, Vimal on 17/08/19.
//  Copyright © 2019 Venugopalan, Vimal. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Showing alert for generic messages
    ///
    /// - Parameters:
    ///   - title: title of the message
    ///   - message: message body
    func showAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .cancel) { action in}
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// Activity Indicator start animation
    func activityStartAnimating() {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        backgroundView.backgroundColor = UIColor.white
        backgroundView.tag = 475647
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.color = UIColor.gray
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator)
        
        self.view.addSubview(backgroundView)
        self.view.bringSubviewToFront(backgroundView)
    }
    
    /// Activity Indicator stop animation
    func activityStopAnimating() {
        if let background = self.view.viewWithTag(475647){
            background.removeFromSuperview()
        }
        self.view.isUserInteractionEnabled = true
    }
}

extension UIColor {
    
    /// Hex String to UIColor init method
    ///
    /// - Parameter hex: hex format string
    public convenience init?(hex: String) {
        let r, g, b: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: 1.0)
                    return
                }
            }
        }
        return nil
    }
}
