//
//  ViewController.swift
//  Life-Counter
//
//  Created by Tristan Khieu on 4/21/25.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var addPlayerButton: UIButton!

    // Player Labels
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var player3Label: UILabel!
    @IBOutlet weak var player4Label: UILabel!
    @IBOutlet weak var player5Label: UILabel!
    @IBOutlet weak var player6Label: UILabel!
    @IBOutlet weak var player7Label: UILabel!
    @IBOutlet weak var player8Label: UILabel!

    // Player HPs
    @IBOutlet weak var player1HP: UILabel!
    @IBOutlet weak var player2HP: UILabel!
    @IBOutlet weak var player3HP: UILabel!
    @IBOutlet weak var player4HP: UILabel!
    @IBOutlet weak var player5HP: UILabel!
    @IBOutlet weak var player6HP: UILabel!
    @IBOutlet weak var player7HP: UILabel!
    @IBOutlet weak var player8HP: UILabel!

    // Player Inputs
    @IBOutlet weak var player1Input: UITextField!
    @IBOutlet weak var player2Input: UITextField!
    @IBOutlet weak var player3Input: UITextField!
    @IBOutlet weak var player4Input: UITextField!
    @IBOutlet weak var player5Input: UITextField!
    @IBOutlet weak var player6Input: UITextField!
    @IBOutlet weak var player7Input: UITextField!
    @IBOutlet weak var player8Input: UITextField!

    // Player StackViews
    @IBOutlet weak var player3StackView: UIStackView!
    @IBOutlet weak var player4StackView: UIStackView!
    @IBOutlet weak var player5StackView: UIStackView!
    @IBOutlet weak var player6StackView: UIStackView!
    @IBOutlet weak var player7StackView: UIStackView!
    @IBOutlet weak var player8StackView: UIStackView!
    
    var historyLog: [String] = []
    var playerLives = [20, 20, 20, 20, 20, 20, 20, 20]
    var activePlayers = 2
    var gameStarted = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide players 3-8
        player3StackView.isHidden = true
        player4StackView.isHidden = true
        player5StackView.isHidden = true
        player6StackView.isHidden = true
        player7StackView.isHidden = true
        player8StackView.isHidden = true

        // Clear all inputs
        clearAllInputs()

        updateUI()
    }

    @IBAction func addPlayerTapped(_ sender: UIButton) {
        guard activePlayers < 8 && !gameStarted else { return }

        switch activePlayers {
        case 2: player3StackView.isHidden = false
        case 3: player4StackView.isHidden = false
        case 4: player5StackView.isHidden = false
        case 5: player6StackView.isHidden = false
        case 6: player7StackView.isHidden = false
        case 7: player8StackView.isHidden = false
        default: break
        }

        activePlayers += 1
    }

    @IBAction func customAddTapped(_ sender: UIButton) {
        let index = sender.tag
        let inputField = getPlayerInput(index: index)
        let value = Int(inputField.text ?? "") ?? 0
        playerLives[index] += value
        historyLog.append("Player \(index + 1) gained \(value) life.")
        gameStarted = true
        addPlayerButton.isEnabled = false
        updateUI()
    }

    @IBAction func customSubtractTapped(_ sender: UIButton) {
        let index = sender.tag
        let inputField = getPlayerInput(index: index)
        let value = Int(inputField.text ?? "") ?? 0
        playerLives[index] -= value
        gameStarted = true
        addPlayerButton.isEnabled = false
        historyLog.append("Player \(index + 1) lost \(value) life.")
        updateUI()
    }

    @IBAction func smallStepTapped(_ sender: UIButton) {
        let index = sender.tag
        guard let symbol = sender.titleLabel?.text else { return }
        let value = (symbol == "+") ? 1 : -1
        playerLives[index] += value
        gameStarted = true
        addPlayerButton.isEnabled = false
        let action = value > 0 ? "gained" : "lost"
        historyLog.append("Player \(index + 1) \(action) \(abs(value)) life.")
        updateUI()
    }

    func updateUI() {
        let hpLabels = [player1HP, player2HP, player3HP, player4HP, player5HP, player6HP, player7HP, player8HP]

        for i in 0..<activePlayers {
            hpLabels[i]?.text = "\(playerLives[i])"
            if playerLives[i] <= 0 {
                resultLabel.text = "Player \(i + 1) LOSES!"
                resultLabel.isHidden = false
            }
        }
    }

    func getPlayerInput(index: Int) -> UITextField {
        let inputs = [player1Input, player2Input, player3Input, player4Input, player5Input, player6Input, player7Input, player8Input]
        return inputs[index] ?? UITextField()
    }

    func clearAllInputs() {
        player1Input.text = ""
        player2Input.text = ""
        player3Input.text = ""
        player4Input.text = ""
        player5Input.text = ""
        player6Input.text = ""
        player7Input.text = ""
        player8Input.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHistory",
           let destination = segue.destination as? HistoryViewController {
            destination.historyText = historyLog.joined(separator: "\n")
        }
    }
}

