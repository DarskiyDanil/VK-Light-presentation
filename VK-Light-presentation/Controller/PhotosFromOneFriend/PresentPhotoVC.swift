//
//  PresentPhotoVC.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 11.04.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit


class PresentPhotoVC: UIViewController {
    
    var photoURL: UrlPhotoCoreData?
    var bool: Bool = true
    var image: UIImage?
    
    let buttonShared: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = #colorLiteral(red: 0.8214086294, green: 1, blue: 0.6834984422, alpha: 1)
        button.addTarget(self, action:  #selector(tapButton), for:.touchDown)
        button.backgroundColor = #colorLiteral(red: 0.7742344141, green: 1, blue: 0.7226980925, alpha: 0.2679526969)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.setTitle("Shared", for: .normal)
        button.tintColor = .systemGreen
        button.setTitleColor(.systemGreen, for: .normal)
        button.isHidden = true
        return button
    }()
    
    var photoImage: UIImageView = {
        var photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.clipsToBounds = true
        photo.contentMode = .scaleAspectFit
        return photo
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async{
            self.addPhoto()
        }
        downloadImage()
        // жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(toolBarAlfa))
        view.addGestureRecognizer(hideKeyboardGesture)
    }
    
    func downloadImage() {
        guard let photoURL = photoURL?.url else {return}
        guard let imageURL:URL = URL(string: photoURL) else {return}
        DispatchQueue.global(qos: .userInitiated).async {
            guard let imgData = try? Data(contentsOf: imageURL) else {return}
            DispatchQueue.main.async {
                self.image = UIImage(data: imgData)
                self.photoImage.image = UIImage(data: imgData)
            }
        }
    }
    
    func addPhoto() {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
        blur.frame = view.bounds
        blur.isUserInteractionEnabled = false
        self.view.insertSubview(blur, at: 0)
        self.view.addSubview(self.photoImage)
        self.view.addSubview(buttonShared)
        photoImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        photoImage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        photoImage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true
        photoImage.bottomAnchor.constraint(equalTo: self.buttonShared.topAnchor, constant: -4).isActive = true
        
        buttonShared.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        buttonShared.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonShared.widthAnchor.constraint(equalToConstant: 120).isActive = true
        buttonShared.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30).isActive = true
    }
    
    @objc func toolBarAlfa() {
        self.bool = !bool
        if bool {
            self.buttonShared.isHidden = true
        } else {
            self.buttonShared.isHidden = false
        }
    }
    
    @objc func tapButton () {
        guard let image = self.image else {return}
        let shareController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        shareController.completionWithItemsHandler = {_, bool, _, _ in
            //            if bool {
            //                print("успешно")
            //            }
        }
        present(shareController, animated: true, completion: nil)
    }
    
}
