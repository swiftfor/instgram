//
//  PostViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Hamada on 8/8/18.
//  Copyright © 2018 Parse. All rights reserved.
//

import UIKit
import Parse
class PostViewController: UIViewController {
    var activityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   
    @IBAction func chooseImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    func alertController ( _ title : String , _ message : String){
        let alert = UIAlertController(title: title , message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func postImage(_ sender: Any) {
        activityIndicator =  UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        let post = PFObject(className: "Posts")
        post["message"] = textField.text
        post["userId"] = PFUser.current()?.objectId!
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.5)
        let imageFile = PFFile(name: "photo.jpeg", data: imageData!)
        post["imageFile"] = imageFile
        post.saveInBackground
            { (sucess, error) in
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
            if error != nil {
                self.alertController("image cannot posted", "please try again later")
            }
            else
            {
                self.alertController("image Posted!", "image has been posted")
                self.imageView.image = UIImage(named: "2754582.png")
                self.textField.text = ""
            }
        }
        
        
    }
    
    
    
   
}
extension PostViewController : UINavigationControllerDelegate , UIImagePickerControllerDelegate {
    
}
