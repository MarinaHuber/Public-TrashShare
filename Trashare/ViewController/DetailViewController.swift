//
//  DetailViewController.swift
//  Trashare
//
//  Created by Marina Huber on 4/18/19.
//  Copyright © 2019 The App Academy. All rights reserved.
//

import UIKit
// TODO: Find localized string solution for all the strings for Parse

@objc class DetailViewController: UIViewController, UINavigationControllerDelegate, UIScrollViewDelegate {
	@IBOutlet weak var gradientView: UIView!
	@IBOutlet private var dateTrash: UILabel!
	@objc var currentObject : PFObject?

	// PFFileObject representes a file of binary data stored on the Parse servers.
	@IBOutlet var showImage: UIImageView!
	@IBOutlet private var titleTrash: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
		setGradientBackground()
		if let object = currentObject {
			self.titleTrash.text = object["titleTrashare"] as? String
		if let fileImage = object["imageFile"] as? PFFileObject {
			getImageFromData(data: fileImage)
			}
		}
	}

	func getImageFromData(data: PFFileObject) {
		data.getDataInBackground {(data: Data?, error: Error?) in
			if let data = data, let image = UIImage(data: data) {
				self.showImage.image = image
			} else {}
		}
	}


	func setGradientBackground() {
		let colorTop =  UIColor(red: 209.0/255.0, green: 255.0/255.0, blue: 100.0/255.0, alpha: 1.0).cgColor
		let colorBottom = UIColor(red: 174.0/255.0, green: 255.0/255.0, blue: 158.0/255.0, alpha: 1.0).cgColor

		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = [colorTop, colorBottom]
		gradientLayer.locations = [0.7, 1.0]
		gradientLayer.frame = self.view.bounds

		self.gradientView.layer.insertSublayer(gradientLayer, at: 0)
	}

	@IBAction func cancel(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}


}
