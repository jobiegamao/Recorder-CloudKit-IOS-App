//
//  RecordViewController.swift
//  Whistle
//
//  Created by may on 4/15/23.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController {

	
	@IBOutlet var mainView: UIView!
	@IBOutlet var messageLabel: UILabel!
	@IBOutlet var errorMessage: UILabel!
	
	var recordingSession: AVAudioSession!
	var audioRecorder: AVAudioRecorder!
	
	private let startRecMessage = "Tap mic button to record"
	private let stopRecMessage = "Tap mic to Stop"
	
	private var originalBackgroundColor: UIColor!
	
	// MARK: - Main
	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Record your audio"
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "Record", style: .plain, target: nil, action: nil)
		originalBackgroundColor = view.backgroundColor

		recordingSession = AVAudioSession.sharedInstance()

		do {
			try recordingSession.setCategory(.playAndRecord, mode: .default)
			try recordingSession.setActive(true)
			// add to plist.file Privacy - Microphone Usage Description
			recordingSession.requestRecordPermission() { [weak self] allowed in
				DispatchQueue.main.async {
					if allowed {
						self?.mainView.isHidden = false
					} else {
						self?.errorMessage.isHidden = false
					}
				}
			}
		} catch {
			errorMessage.isHidden = false
		}
	}

	@IBAction func didTapRecord(_ sender: Any) {
		audioRecorder == nil ? startRecording() : finishRecording(success: true)
	}
	
	func startRecording(){
		// update UI
		view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
		messageLabel.text = stopRecMessage
		
		// create URL for the recorded audio to be saved
		let audioURL = RecordViewController.getAudioURL()
		print(audioURL.absoluteString)
		
		// setup settings for audio
		let settings = [
		   AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
		   AVSampleRateKey: 12000,
		   AVNumberOfChannelsKey: 1,
		   AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
		]
		
		do {
			//
			audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
			audioRecorder.delegate = self
			audioRecorder.record()
		} catch {
			finishRecording(success: false)
		}
	}
	
	func finishRecording(success: Bool) {
		
		audioRecorder.stop()
		audioRecorder = nil
		
		// update UI, change back to its storyboard state
		view.backgroundColor = originalBackgroundColor
		messageLabel.text = startRecMessage

	
		if success {
			navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
		} else {
			let ac = UIAlertController(title: "Record failed", message: "There was a problem recording; please try again.", preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "OK", style: .default))
			present(ac, animated: true)
		}
	}
	
	@objc func nextTapped() {

	}
	
	
	
	// Class keyword before func - call them on the class not on instances of the class. This is important, because it means we can find the whistle URL from anywhere in our app rather than typing it in everywhere.
	
	
	//returns the path to a writeable directory owned by your app. This is a great place to save the audio,
	class func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		let documentsDirectory = paths[0]
		return documentsDirectory
	}

	class func getAudioURL() -> URL {
		return getDocumentsDirectory().appendingPathComponent("audio.m4a")
	}

}


extension RecordViewController: AVAudioRecorderDelegate {
	
	func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
		!flag ? finishRecording(success: false) : nil
	}
	
}
