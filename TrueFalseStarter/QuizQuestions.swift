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

struct QuizQuestions {
    var question: String
    var Choice1: String
    var Choice2: String
    var Choice3: String
    var Choice4: String
    var answer: String
}

// Struct holding each individual question object, with their answer choices and the correct responses

struct QuestionCollection {
    let questionsAndAnswers: [QuizQuestions] = [QuizQuestions(question: "How many continents are there on planet Earth?", Choice1: "8", Choice2: "2", Choice3: "7", Choice4: "5", answer: "7"), QuizQuestions(question: "Which of the following continents has the largest land mass?", Choice1: "Asia", Choice2: "Americas", Choice3: "Europe", Choice4: "Africa", answer: "Asia"), QuizQuestions(question: "What country is known as the 'Hermit Kingdom'?", Choice1: "Montenegro", Choice2: "Vatican City", Choice3: "Madagascar", Choice4: "North Korea", answer: "North Korea"), QuizQuestions(question: "Which of the following mountains has the highest elevation above sea level?", Choice1: "K2", Choice2: "Mt. Everest", Choice3: "Makalu", Choice4: "Annapurna 1", answer: "Mt. Everest"), QuizQuestions(question: "The Appalachian Mountains are a system of mountains in Eastern _?", Choice1: "South America", Choice2: "North America", Choice3: "Australia", Choice4: "Russia", answer: "North America"), QuizQuestions(question: "Which of the following is an island nation?", Choice1: "El Salvador", Choice2: "Lebanon", Choice3: "Croatia", Choice4: "Ireland", answer: "Ireland"), QuizQuestions(question: "Russia borders countries on which two continents?", Choice1: "Antarctica & Europe", Choice2: "North America & South America", Choice3: "Australia & New Zealand", Choice4: "Europe & Asia", answer: "Europe & Asia"), QuizQuestions(question: "Which of the following is considered a 'Microstate'?", Choice1: "Vatican City", Choice2: "Barbados", Choice3: "Singapore", Choice4: "All Of The Above", answer: "All Of The Above"), QuizQuestions(question: "What was the largest contiguous land empire in history?", Choice1: "The Spanish Empire", Choice2: "The Mongol Empire", Choice3: "The Portuguese Empire", Choice4: "The British Empire", answer: "The Mongol Empire"), QuizQuestions(question: "'Montblanc' is the highest mountain in the _?", Choice1: "Alps", Choice2: "Appalachians", Choice3: "Himalayas", Choice4: "Andes", answer: "Alps")]
    
// Method for randomizing the questions in-game
    
    func randomQuestion() -> [QuizQuestions] {
        let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: questionsAndAnswers.count)
        return [questionsAndAnswers[randomNumber]]
    }
}
