//
//  SubmitAudioViewController.swift
//  Whistle
//
//  Created by may on 4/17/23.
//

import UIKit


class SubmitAudioViewController: UIViewController {
	
	var genre: String!
	var comments = ""
	
	@IBOutlet var statusLabel: UILabel!
	@IBOutlet var spinnerLoad: UIActivityIndicatorView!
	override func viewDidLoad() {
        super.viewDidLoad()
		title = "You're all set!"
		navigationItem.hidesBackButton = true
		statusLabel.text = "Submitting"
		
		doSubmission()
    }
	
	private func doSubmission() {

	}
	
	@objc private func doneTapped() {
		_ = navigationController?.popToRootViewController(animated: true)
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
