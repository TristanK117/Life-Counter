//
//  History.swift
//  Life-Counter
//
//  Created by Tristan Khieu on 4/24/25.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyTextView: UITextView!
    var historyText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        historyTextView.text = historyText ?? "No history yet."
    }
}
