//
//  EditPhotoViewController.swift
//  Machin_Test_ProsperInfotech
//
//  Created by ashish patil on 20/02/24.
//

import UIKit

class EditPhotoViewController: UIViewController {

    //MARK: Outlets :
    @IBOutlet weak var editImageView :UIImageView!
    @IBOutlet weak var filterBTView :UIView!
    @IBOutlet weak var shareBTView :UIView!
    @IBOutlet weak var textBTView :UIView!
    @IBOutlet weak var backBTView :UIView!

    var capturedImage: UIImage?
    var filteredImage:UIImage?{
        didSet
        {
            editImageView.image = filteredImage != nil ? filteredImage : capturedImage
        }
    }
    var ciImage: CIImage? {
        guard let cgImage = capturedImage?.cgImage else { return nil }
        return CIImage(cgImage: cgImage)
    }
    var alertController = UIAlertController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign captured image to the ImageView
        editImageView.image = capturedImage
  
    }
    override func viewDidAppear(_ animated: Bool) {
        
        //Make circular background
        filterBTView.makeCircular()
        shareBTView.makeCircular()
        textBTView.makeCircular()
        backBTView.makeCircular()
   
    }
    //Filter list popup:
    func showFilterPopup() {
        
        let enumCases = ImageFilterType.allCases.map { $0.description }
        
        // Add actions for each enum case
        var actions  = [UIAlertAction]()
        for enumCase in enumCases {
            let action = UIAlertAction(title: enumCase, style: .default) { _ in
                // Handle selection
                let selectedFilter = ImageFilterType(rawValue: enumCase) ?? .none
                guard let ciImage = self.ciImage else {return}
                self.filteredImage = Filter.getFilteredImage(selectedFilter: selectedFilter,ciImage:ciImage)
            }
            actions.append(action)
         }
        
      AlertHelper.presentAlertOrActionSheet(title: "Select a Filter", message: "", preferredStyle: .actionSheet, actions: actions, sourceView: filterBTView, sourceRect: filterBTView.bounds, viewController: self)
    }
    
    //Remove all filter to get original image:
    func removeFilter() {
        editImageView.image = capturedImage
    }
    //Back Button action
    @IBAction func NavigateBack(_ sender:UIButton)
    {
        //Navigate back
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    //Press on filter that will display of list of verious filters:
    @IBAction func ApplyFilter(_ sender:UIButton)
    {
        //Select the filter from list to apply on image
        showFilterPopup()
    }
    
    
    //Press on Textfield and add text on the imageView.
    @IBAction func ApplyText(_ sender: Any) {
 
        alertController = UIAlertController(title: "Enter Text", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Text Here"
        }
        
         let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
             if let textField = self.alertController.textFields?.first {
 
                if textField.text != nil
                {
                    // Create a movable label
                    let movableLabel = MovableLabel(frame: CGRect(x: 200, y: 100, width: 200, height: 50))
                    movableLabel.font = UIFont.systemFont(ofSize: 24,weight: .bold)
                    movableLabel.text = textField.text ?? ""
                    movableLabel.isUserInteractionEnabled = true
                    self.editImageView.addSubview(movableLabel)
                }
            }
        }
        // Add cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
 
    }
    
    //Share the edited image on various platforms:
    @IBAction func ShareFilteredImage(_ sender:UIButton)
    {
        // let aView = ImageView.image
        UIGraphicsBeginImageContextWithOptions(CGSize(width: editImageView.frame.width, height: editImageView.frame.height), true, 0)
        editImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // set up activity view controller
        let imageToShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        
        activityViewController.BoundsToAlert(sourceView: shareBTView)

        present(activityViewController, animated: true, completion: nil)
    }
    
    
}
