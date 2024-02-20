//
//  Extension.swift
//  Machin_Test_ProsperInfotech
//
//  Created by ashish patil on 20/02/24.
//

import Foundation
import UIKit

 
extension UIView
{
    func makeCircular()
    {
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0
    }
}


class MovableLabel: UILabel {
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let superview = self.superview else { return }
        let touchLocation = touch.location(in: superview)
        self.center = touchLocation
    }
}

enum AlertStyle {
    case alert
    case actionSheet
}

class AlertHelper {
    static func presentAlertOrActionSheet(title: String?, message: String?, preferredStyle: UIAlertController.Style, actions: [UIAlertAction], sourceView: UIView?, sourceRect: CGRect?, viewController: UIViewController) {
        var alertController = UIAlertController()
        alertController =  UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for action in actions {
            alertController.addAction(action)
        }

        // For iPad, present as a popover
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = alertController.popoverPresentationController {
                if let sourceView = sourceView {
                    popoverController.sourceView = sourceView
                }
                if let sourceRect = sourceRect {
                    popoverController.sourceRect = sourceRect
                }
                popoverController.permittedArrowDirections = [.up, .down]
            }
        }
        
        viewController.present(alertController, animated: true, completion: nil)
    }
     
}
 

extension UIActivityViewController
{
    func BoundsToAlert(sourceView:UIView)
    {
        if let popoverController = self.popoverPresentationController {
            popoverController.sourceView = sourceView
            popoverController.sourceRect = sourceView.bounds
        }
        
    }
}
