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

	var tap: UIPinchGestureRecognizer?
	var isFullScreen: Bool = false
	var prevFrame = CGRect.zero

	var myScrollView: UIScrollView?
	@IBOutlet var dateTrash: UILabel!

	// PFFileObject representes a file of binary data stored on the Parse servers.
	@IBOutlet var showImage: UIImageView!
	@IBOutlet var titleTrash: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()

		let query = PFQuery(className: "trashareData")
		query.findObjectsInBackground { (objects, error) in
				if let returnedObjects = objects {
					for object in returnedObjects {

						let fileA = object["imageFile"] as? PFFileObject
						fileA?.getDataInBackground {
							(imageData, error) -> Void in

							if error == nil {
								let image = UIImage(data: imageData!)

								self.showImage.image = image

							} else {}
						}}
					}
			}

	}


	@IBAction func cancel(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}


	@objc func tap(_ sender: Any) {

		if !isFullScreen {
			UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
//				prevFrame = self.showImage.frame
//				self.showImage.frame = UIScreen.main.bounds
			}) { finished in
				self.isFullScreen = true
			}
			return
		} else {
			titleTrash.alpha = 1.0
			dateTrash.alpha = 1.0

			navigationController?.setNavigationBarHidden(false, animated: true)
			UIView.animate(withDuration: 4, delay: 0, options: [], animations: {
//				self.showImage.frame = prevFrame
			}) { finished in
				self.isFullScreen = false
			}
			return
		}
	}

}
