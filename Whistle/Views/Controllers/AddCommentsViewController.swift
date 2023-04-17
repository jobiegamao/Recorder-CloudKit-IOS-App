//
//  AddCommentsViewController.swift
//  Whistle
//
//  Created by may on 4/17/23.
//

import UIKit

class AddCommentsViewController: UIViewController {

	var genre: String!
	let placeholder = "If you have any additional comments that might help identify your tune, enter them here."
	@IBOutlet var commentTextView: UITextView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		title = "Add Comments"
		
		commentTextView.delegate = self
		commentTextView.text = placeholder
    }

	// storyboard way of sending data to the pushed VC
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "didTapSubmitBtn" {
			let destinationVC = segue.destination as! SubmitAudioViewController
			destinationVC.genre = genre
			destinationVC.comments = commentTextView.text != placeholder ? commentTextView.text : ""
		}
	}
	
}


extension AddCommentsViewController: UITextViewDelegate {
	
	// clear out placeholder
	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.text == placeholder {
			textView.text = ""
		}
	}
}
