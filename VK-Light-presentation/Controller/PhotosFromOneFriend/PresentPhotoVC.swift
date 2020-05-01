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
    private var bool: Bool = true
    private let blur = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
    
    let activityIndicator: UIActivityIndicatorView = {
        var activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = #colorLiteral(red: 0.5544524193, green: 0.9462211728, blue: 0.01620966755, alpha: 1)
        return activityIndicator
    }()
    
    private let buttonShared: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action:  #selector(tapButton), for:.touchDown)
        button.backgroundColor = #colorLiteral(red: 0.7742344141, green: 1, blue: 0.7226980925, alpha: 0.2679526969)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemGreen
        button.setTitle("Shared", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.isHidden = true
        return button
    }()
    
    private var photoImage: WebImageView = {
        var photo = WebImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.contentMode = .scaleAspectFit
        return photo
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async{
            self.addPhoto()
        }
        downloadImage(photoURL: photoURL)
        // жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(toolBarAlfa))
        view.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewDidLayoutSubviews() {
        buttonShared.clipsToBounds = true
        buttonShared.layer.cornerRadius = 8
    }
    
    private func downloadImage(photoURL: UrlPhotoCoreData?) {
        guard let photoURL = photoURL?.url else {return}
        activityIndicator.startAnimating()
        self.photoImage.set(imageUrl: photoURL)
        activityIndicator.stopAnimating()
    }
    
    private func addPhoto() {
//        размытый фон
        
        blur.frame = view.bounds
        blur.isUserInteractionEnabled = false
        view.insertSubview(blur, at: 0)
        
        view.addSubview(photoImage)
        view.addSubview(buttonShared)
        view.addSubview(activityIndicator)
        
        photoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        photoImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        photoImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        photoImage.bottomAnchor.constraint(equalTo: buttonShared.topAnchor, constant: -4).isActive = true
        
        buttonShared.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        buttonShared.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonShared.widthAnchor.constraint(equalToConstant: 120).isActive = true
        buttonShared.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc private func toolBarAlfa() {
        self.bool = !bool
        if bool {
            self.buttonShared.isHidden = true
        } else {
            self.buttonShared.isHidden = false
        }
    }
    
    @objc private func tapButton () {
        guard let image = self.photoImage.image else {return}
        let shareController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        shareController.completionWithItemsHandler = {_, bool, _, _ in
        }
        present(shareController, animated: true, completion: nil)
    }
    
}
