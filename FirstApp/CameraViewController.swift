//
//  CameraViewController.swift
//  FirstApp
//
//  Created by vlad on 21/11/2020.
//

import UIKit

class CameraViewController: UIViewController {
    
    let cameraButton = UIButton()
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        cameraButton.setTitleColor(.systemBlue, for: .normal)
        cameraButton.setTitle("Take a picture", for: .normal)
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.addTarget(self, action: #selector(cameraButtonHandler), for: .touchUpInside)
        view.addSubview(cameraButton)
        
        
        imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: cameraButton.topAnchor, constant: 40).isActive = true
        
        
//        cameraButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40).isActive = true
        cameraButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -25).isActive = true
        cameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let directoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileUrl = directoryUrl.appendingPathComponent("image.jpg")
            if let image = UIImage(contentsOfFile: fileUrl.relativePath) {
                imageView.image = image
            }
        }
    }

    @objc private func cameraButtonHandler() {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .camera
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
}

extension CameraViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            
            if let data = image.jpegData(compressionQuality: 0.8),
               let directoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileUrl = directoryUrl.appendingPathComponent("image.jpg")
                try? data.write(to: fileUrl)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}
