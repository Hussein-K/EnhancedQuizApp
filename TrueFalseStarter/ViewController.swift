//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // We have our initial variables here
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    
    var gameSound: SystemSoundID = 0
    
    var quizQuestions = QuizQuestions()
    
    var correctAnswer = ""
    
    
    // Outlets for the labels and buttons
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var ChoiceA: UIButton!
    @IBOutlet weak var ChoiceB: UIButton!
    @IBOutlet weak var ChoiceC: UIButton!
    @IBOutlet weak var ChoiceD: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
        displayAnswer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Function used to call a question from the QuizQuestions object
    func displayQuestion() {
        indexOfSelectedQuestion = quizQuestions.randomIndexOfSelectedQuestion()
        let question = quizQuestions.randomQuestion(indexOfSelectedQuestion: indexOfSelectedQuestion)
        questionField.text = question
        enableAnswers()
        displayAnswerChoices()
        playAgainButton.isHidden = true
        
    }
    
    // Function used to display the answer choices for each question
    func displayAnswer() {
        let answerArray = quizQuestions.randomAnswer(indexOfSelectedQuestion: indexOfSelectedQuestion)

        if answerArray.count == 4 {
            ChoiceA.setTitle(answerArray[0], for: .normal)
            ChoiceB.setTitle(answerArray[1], for: .normal)
            ChoiceC.setTitle(answerArray[2], for: .normal)
            ChoiceD.setTitle(answerArray[3], for: .normal)
        }
    }
    
    
    // Function used to show the user's final score along with a message
    func displayScore() {
        // Hide the answer buttons
        ChoiceA.isHidden = true
        ChoiceB.isHidden = true
        ChoiceC.isHidden = true
        ChoiceD.isHidden = true
        
        // Statement to change the endgame text depending on the user's score
        if correctQuestions == 4 {
            questionField.text = "Looks like you know your way around! You got \(correctQuestions) out of \(questionsPerRound) correct!"
        } else {
            questionField.text = "Looks like we've still got things to learn! You got \(correctQuestions) out of \(questionsPerRound) correct!"
        }
        
        // Display play again button
        playAgainButton.isHidden = false
    }
    
    // Action that checks the user's input with the correct answer according to the QuizQuestions object
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        correctAnswer = quizQuestions.correctAnswerToQuestion(indexOfSelectedQuestion: indexOfSelectedQuestion)
        
        if (sender === ChoiceA && ChoiceA.titleLabel?.text == correctAnswer) || (sender === ChoiceB && ChoiceB.titleLabel?.text == correctAnswer) || (sender == ChoiceC && ChoiceC.titleLabel?.text == correctAnswer) || (sender == ChoiceD && ChoiceD.titleLabel?.text == correctAnswer) {
            correctQuestions += 1
            questionField.text = "Correct!"
        } else {
            questionField.text = "Sorry, wrong answer!"
        }
        
        disableAnswerChoices(sender)
        removeQuestionFromGame()
        loadNextRoundWithDelay(seconds: 2)
    }
    
    // Function that allows the user to play another round
    func nextRound() {
        if questionsAsked == questionsPerRound {
            
            // Game is over
            displayScore()
        } else {
            
            displayQuestion()
            displayAnswer()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        ChoiceA.isHidden = true
        ChoiceB.isHidden = true
        ChoiceC.isHidden = true
        ChoiceD.isHidden = true
        
        resetQuestionsInGame()
        questionsAsked = 0
        correctQuestions = 0
        
        nextRound()
    }
    
    // Function which ensures that no questions repeat during the round
    func removeQuestionFromGame() {
        answeredQuestionIndexesCollection.append(quizQuestions.questions[indexOfSelectedQuestion])
        quizQuestions.questions.remove(at: indexOfSelectedQuestion)
    }
    
    // Function that resets the list of possible questions for each round
    func resetQuestionsInGame() {
        quizQuestions.questions.append(contentsOf: answeredQuestionIndexesCollection)
        answeredQuestionIndexesCollection.removeAll()
    }

    // Action that disables the buttons and dims them until the next question is asked
    @IBAction func disableAnswerChoices(_ sender: UIButton) {
        let answerButtons = [ChoiceA, ChoiceB, ChoiceC, ChoiceD]
        
        // Lowers the opacity of each button until the next question is asked
        for button in answerButtons {
            button?.isEnabled = false
            button?.alpha = 0.2
        }
        
        // Keeps the correct answer clear
        for selectedButton in answerButtons {
            if sender == selectedButton {
                selectedButton?.alpha = 1.0
            }
        }
    }
    
    // Function that is used to reset the opacity of each button and make sure they are usable
    func enableAnswers() {
        // Enables the buttons
        ChoiceA.isEnabled = true
        ChoiceB.isEnabled = true
        ChoiceC.isEnabled = true
        ChoiceD.isEnabled = true
        
        // Keeps the buttons fully visible
        ChoiceA.alpha = 1.0
        ChoiceB.alpha = 1.0
        ChoiceC.alpha = 1.0
        ChoiceD.alpha = 1.0
    }
    
    func displayAnswerChoices() {
        // Shows the answer choices
        ChoiceA.isHidden = false
        ChoiceB.isHidden = false
        ChoiceC.isHidden = false
        ChoiceD.isHidden = false
    }
    
    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}

