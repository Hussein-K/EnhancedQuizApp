//
//  QuizQuestions.swift
//  TrueFalseStarter
//
//  Created by Hussein Kheireddine on 1/6/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import GameKit

// Struct outlining the basic format of each Questin Object

struct QuizFormat {
    var question: String
    var answerChoices: [String]
    var answer: String
}

// Struct holding each individual question object, with their answer choices and the correct responses

struct QuizQuestions {
    var questions: [QuizFormat] = [
        QuizFormat(question: "How many continents are there on planet Earth?", answerChoices: ["8", "2", "7", "5"], answer: "7"),
        QuizFormat(question: "Which of the following continents has the largest land mass?", answerChoices: ["Asia", "Americas", "Europe", "Africa"], answer: "Asia"),
        QuizFormat(question: "What country is known as the 'Hermit Kingdom'?", answerChoices: ["Montenegro", "Vatican City", "Madagascar", "North Korea"], answer: "North Korea"),
        QuizFormat(question: "Which of the following mountains has the highest elevation above sea level?", answerChoices: ["K2", "Mt. Everest", "Makalu", "Annapurna 1"], answer: "Mt. Everest"),
        QuizFormat(question: "The Appalachian Mountains are a system of mountains in Eastern _?", answerChoices: ["South America", "North America", "Australia", "Russia"], answer: "North America"),
        QuizFormat(question: "Which of the following is an island nation?", answerChoices: ["El Salvador", "Lebanon", "Croatia", "Ireland"], answer: "Ireland"),
        QuizFormat(question: "Russia borders countries on which two continents?", answerChoices: ["Antarctica & Europe", "North America & South America", "Australia & New Zealand", "Europe & Asia"], answer: "Europe & Asia"),
        QuizFormat(question: "Which of the following is considered a 'Microstate'?", answerChoices: ["Vatican City", "Barbados", "Singapore", "All Of The Above"], answer: "All Of The Above"),
        QuizFormat(question: "What was the largest contiguous land empire in history?", answerChoices: ["The Spanish Empire", "The Mongol Empire", "The Portuguese Empire", "The British Empire"], answer: "The Mongol Empire"),
        QuizFormat(question: "'Montblanc' is the highest mountain in the _?", answerChoices: ["Alps", "Appalachians", "Himalayas", "Andes"], answer: "Alps")]
    
    // Random selection of an instance from the array of questions
    func randomIndexOfSelectedQuestion() -> Int {
        let indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
        return indexOfSelectedQuestion
    }
    
    // Function that pulls the 'Question' value
    func randomQuestion(indexOfSelectedQuestion: Int) -> String {
        let questionCollection = questions[indexOfSelectedQuestion]
        return questionCollection.question
    }
    
    // Randomizes the answers on each of the provided buttons
    func randomAnswer(indexOfSelectedQuestion: Int) -> [String] {
        let questionCollection = questions[indexOfSelectedQuestion]
        return questionCollection.answerChoices
    }
    
    // Function to return the correct answer to the Check Answer action
    func correctAnswerToQuestion(indexOfSelectedQuestion: Int) -> String {
        let questionCollection = questions[indexOfSelectedQuestion]
        return questionCollection.answer
    }
}

// Collection that will temporarily hold the used questions so that they aren't repeated during the same round
var answeredQuestionIndexesCollection = [QuizFormat]()

