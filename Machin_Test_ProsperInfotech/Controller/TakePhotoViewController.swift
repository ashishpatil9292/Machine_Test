//
//  TakePhotoViewController.swift
//  Machin_Test_ProsperInfotech
//
//  Created by ashish patil on 20/02/24.
//

import UIKit

class TakePhotoViewController: UIViewController {
    
    var alertController = UIAlertController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func TakePhotoBTTapped(_ sender:UIButton)
    {
        //Check if camera is available
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            //Capture photo using camera
            takePhoto()
        }else
        {
            let okAction = UIAlertAction(title: "OK", style: .default)
            AlertHelper.presentAlertOrActionSheet(title: "Warning", message: "You don't have camera", preferredStyle: .alert, actions: [okAction], sourceView: nil, sourceRect: nil, viewController: self)
        }
    }
    
   private func takePhoto()
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
}
extension TakePhotoViewController :UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    // Delegate method called when image is captured or selected
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Dismiss the image picker
        picker.dismiss(animated: true, completion: nil)
        
        // Get the captured image
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        // Present options for editing
        presentEditOptions(for: image)
    }
    
    // Delegate method called when user cancels capturing or selecting image
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Navigate to another screen for editing the captured image
    func presentEditOptions(for image: UIImage) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerId.editPhotoViewController)as! EditPhotoViewController
       
        vc.capturedImage = image
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

