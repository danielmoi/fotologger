//
//  DetailsViewController.swift
//  Fotologger
//
//  Created by Daniel Moi on 10/12/17.
//  Copyright © 2017 Daniel Moi. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    var item: Item? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if item != nil {
            itemImageView.image = UIImage(data: item!.image as Data!)
            titleTextField.text = item!.title
            
            addUpdateButton.setTitle("Update", for: .normal)
            
        } else {
            deleteButton.isHidden = true
        }
    }
    
    @IBOutlet weak var addUpdateButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        print(image)
        itemImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        print("HELLO")
    }
    
    
    
    
    @IBAction func addTapped(_ sender: Any) {
        
        if (item != nil) {
            item!.title = titleTextField.text;
            item!.image = UIImagePNGRepresentation(itemImageView.image!);
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let item = Item(context: context);
            item.title = titleTextField.text;
            item.image = UIImagePNGRepresentation(itemImageView.image!);
        }
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(item!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
    
}
