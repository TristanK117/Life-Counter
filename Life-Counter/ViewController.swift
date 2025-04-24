//
//  ViewController.swift
//  Life-Counter
//
//  Created by Tristan Khieu on 4/21/25.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var PlayerOne: UILabel!
    @IBOutlet weak var PlayerTwo: UILabel!
    
    @IBOutlet weak var HealthPointsOne: UILabel!
    @IBOutlet weak var HealthPointsTwo: UILabel!
    
    @IBOutlet weak var ResultLabel: UILabel!
    
    @IBOutlet weak var customInputOne: UITextField!
    @IBOutlet weak var customInputTwo: UITextField!
    
    

    var player1Life = 20
    var player2Life = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        customInputOne.text = ""
        customInputTwo.text = ""
    }

    @IBAction func player1ButtonTapped(_ sender: UIButton) {
        adjustLife(for: 1, using: sender)
    }

    @IBAction func player2ButtonTapped(_ sender: UIButton) {
        adjustLife(for: 2, using: sender)
    }
    
    @IBAction func player1CustomAddTapped(_ sender: UIButton) {
        let value = Int(customInputOne.text ?? "") ?? 0
        player1Life += value
        updateUI()
    }

    @IBAction func player1CustomSubtractTapped(_ sender: UIButton) {
        let value = Int(customInputOne.text ?? "") ?? 0
        player1Life -= value
        updateUI()
    }

    @IBAction func player2CustomAddTapped(_ sender: UIButton) {
        let value = Int(customInputTwo.text ?? "") ?? 0
        player2Life += value
        updateUI()
    }

    @IBAction func player2CustomSubtractTapped(_ sender: UIButton) {
        let value = Int(customInputTwo.text ?? "") ?? 0
        player2Life -= value
        updateUI()
    }

    // MARK: - Logic
    func adjustLife(for player: Int, using button: UIButton) {
        guard let change = button.titleLabel?.text else { return }

        let amount: Int
        switch change {
        case "+": amount = 1
        case "-": amount = -1
        default: amount = 0
        }

        if player == 1 {
            player1Life += amount
        } else {
            player2Life += amount
        }

        updateUI()
    }


    func updateUI() {
        HealthPointsOne.text = "\(player1Life)"
        HealthPointsTwo.text = "\(player2Life)"

        if player1Life <= 0 {
            ResultLabel.text = "Player 1 LOSES!"
            ResultLabel.isHidden = false
        } else if player2Life <= 0 {
            ResultLabel.text = "Player 2 LOSES!"
            ResultLabel.isHidden = false
        } else {
            ResultLabel.isHidden = true
        }
    }
}

