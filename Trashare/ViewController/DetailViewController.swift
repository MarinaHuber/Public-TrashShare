//
//  DetailViewController.swift
//  Trashare
//
//  Created by Marina Huber on 4/18/19.
//  Copyright © 2019 The App Academy. All rights reserved.
//

import UIKit
//import Parse

@objc class DetailViewController: UIViewController, UINavigationControllerDelegate, UIScrollViewDelegate {
	@IBOutlet weak var gradientView: UIView!
	@IBOutlet private var dateTrash: UILabel!
	@objc var currentObject : PFObject?

	// PFFileObject representes a file of binary data stored on the Parse servers.
	@IBOutlet var showImage: UIImageView!
	@IBOutlet var titleTrash: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
		setGradientBackground()
		if let object = currentObject {
			titleTrash.text = object["titieTrash"] as? String
		if let fileImage = object["imageFile"] as? PFFileObject {
			getImageFromData(dataImage: fileImage)
			}
		}
	}

}
