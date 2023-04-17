//
//  SelectGenreTableViewController.swift
//  Whistle
//
//  Created by may on 4/16/23.
//

import UIKit

let reuseIdentifier = "Cell"


// a vc that was not created in storyboard
class SelectGenreTableViewController: UITableViewController {

	//When referencing the genres array we need to use SelectGenreViewController.genres because the array belongs to the class, not to our instance of the class.
	static var genres = ["Unknown", "Blues", "Classical", "Electronic", "Jazz", "Metal", "Pop", "Reggae", "RnB", "Rock", "Soul"]
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		title = "Select genre"
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "Genre", style: .plain, target: nil, action: nil)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SelectGenreTableViewController.genres.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
		
		// Configure the cell...
		var cellConfig = cell.defaultContentConfiguration()
		cellConfig.text = SelectGenreTableViewController.genres[indexPath.row]
		
		cell.contentConfiguration = cellConfig
		cell.accessoryType = .detailDisclosureButton
		
        return cell
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) {
			
			let storyboard = UIStoryboard(name: "Main", bundle: nil)
			let vc = storyboard.instantiateViewController(withIdentifier: "AddCommentsViewController") as! AddCommentsViewController
			
			// get the cell's text, the genre.
			// it is placed inside the contentConfig
			guard let config = cell.contentConfiguration as? UIListContentConfiguration, let text = config.text  else { return }
			vc.genre = text
			navigationController?.pushViewController(vc, animated: true)
		}
	}

}
