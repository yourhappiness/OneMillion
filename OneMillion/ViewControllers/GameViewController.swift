//
//  GameViewController.swift
//  OneMillion
//
//  Created by Anastasia Romanova on 25/09/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

import UIKit

/// Контроллер игры
public class GameViewController: UIViewController {

  @IBOutlet weak var questionNumber: UILabel!
  @IBOutlet weak var questionDescription: UILabel!
  @IBOutlet weak var questionText: UILabel!
  @IBOutlet weak var variantAButton: UIButton!
  @IBOutlet weak var variantBButton: UIButton!
  @IBOutlet weak var variantCButton: UIButton!
  @IBOutlet weak var variantDButton: UIButton!
  @IBOutlet weak var friendsChoiceButton: UIButton!
  @IBOutlet weak var fiftyFiftyButton: UIButton!
  @IBOutlet weak var audienceChoiceButton: UIButton!
  
  private var questions: [Question]?
  private var questionMoney: [Int]?
  private let gameSession: GameSession? = Game.shared.gameSession
  private let questionsSequence: QuestionsSequence = Game.shared.questionsSequence
  private var questionIndex: Int = 0
  private var wasFriendsChoiceUsed: Bool = false
  private var wasAudienceChoiceUsed: Bool = false
  private var wasFiftyFiftyUsed: Bool = false
  private lazy var buttons: [UIButton] = [self.variantAButton,
                                          self.variantBButton,
                                          self.variantCButton,
                                          self.variantDButton]
  weak var gameDelegate: GameSessionDelegate?
  
  private var secondsToDelay = 1.0
  
  private var questionsSequenceStrategy: QuestionsSequenceStrategy {
    switch self.questionsSequence {
    case .predetermined:
      return PredeterminedSequenceStrategy()
    case .random:
      return RandomSequenceStrategy()
    }
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    self.gameDelegate = self.gameSession
    self.questions = self.questionsSequenceStrategy.getQuestions()
    self.questionMoney = QuestionsArray.shared.questionMoney
    guard let gameSession = self.gameSession else {return}
    self.questionNumber.text =
      "\(gameSession.questionNumber.value) вопрос. Процент правильных ответов: \(gameSession.result.value)%."
    gameSession.questionNumber.addObserver(anyObject: self) { (_: Int, newValue: Int) in
      DispatchQueue.main.asyncAfter(deadline: .now() + self.secondsToDelay) {
        guard Game.shared.gameSession != nil else {return}
        self.questionNumber.text =
        "\(newValue) вопрос. Процент правильных ответов: \(round(gameSession.result.value))%."
      }
    }
    gameSession.result.addObserver(anyObject: self) { (_: Double, newValue: Double) in
      DispatchQueue.main.asyncAfter(deadline: .now() + self.secondsToDelay) {
        guard Game.shared.gameSession != nil else {return}
        self.questionNumber.text =
        "\(gameSession.questionNumber.value) вопрос. Процент правильных ответов: \(round(newValue))%."
      }
    }
    self.loadQuestion()
  }
  
  @IBAction func friendsChoiceButtonPressed(_ sender: Any) {
    guard let questions = self.questions else {return}
    self.wasFriendsChoiceUsed = true
    self.friendsChoiceButton.isHidden = true
    let friendChoiceIndex = questions[self.questionIndex].friendChoiceIndex
    self.buttons[friendChoiceIndex].backgroundColor = .orange
  }
  
  @IBAction func fiftyFiftyButtonPressed(_ sender: Any) {
    guard let questions = self.questions else {return}
    self.wasFiftyFiftyUsed = true
    self.fiftyFiftyButton.isHidden = true
    let answers = questions[self.questionIndex].answers
    var incorrectAnswersIndexes: [Int] = []
    for answer in answers {
      guard let index = answers.firstIndex(of: answer) else {return}
      if !answer.isCorrect {
        incorrectAnswersIndexes.append(index)
      }
    }
    incorrectAnswersIndexes = incorrectAnswersIndexes.shuffled()
    self.buttons[incorrectAnswersIndexes[0]].isHidden = true
    self.buttons[incorrectAnswersIndexes[1]].isHidden = true
  }
  
  @IBAction func audienceChoiceButtonPressed(_ sender: Any) {
    guard let questions = self.questions else {return}
    self.wasAudienceChoiceUsed = true
    self.audienceChoiceButton.isHidden = true
    let audienceChoiceIndex = questions[self.questionIndex].audienceChoiceIndex
    self.buttons[audienceChoiceIndex].backgroundColor = .magenta
  }
  
  @IBAction func variantAButtonPressed(_ sender: Any) {
    self.checkAnswer(buttonPressed: self.variantAButton)
  }
  
  @IBAction func variantBButtonPressed(_ sender: Any) {
    self.checkAnswer(buttonPressed: self.variantBButton)
  }
  
  @IBAction func variantCButtonPressed(_ sender: Any) {
    self.checkAnswer(buttonPressed: self.variantCButton)
  }
  
  @IBAction func variantDButtonPressed(_ sender: Any) {
    self.checkAnswer(buttonPressed: self.variantDButton)
  }
  
  private func checkAnswer(buttonPressed: UIButton) {
    guard !buttonPressed.isHidden else {return}
    buttonPressed.backgroundColor = UIColor.white
    DispatchQueue.main.asyncAfter(deadline: .now() + self.secondsToDelay) {
      guard let buttonIndex = self.buttons.firstIndex(of: buttonPressed),
            let questions = self.questions
        else {return}
      let isRightAnswer = questions[self.questionIndex].answers[buttonIndex].isCorrect
      if isRightAnswer {
        buttonPressed.backgroundColor = UIColor.green
        self.gameDelegate?.answerSelected(
          isRight: true,
          wasFriendsChoiceUsed: self.wasFriendsChoiceUsed,
          wasAudienceChoiceUsed: self.wasAudienceChoiceUsed,
          wasFiftyFiftyUsed: self.wasFiftyFiftyUsed)
        DispatchQueue.main.asyncAfter(deadline: .now() + self.secondsToDelay) {
          self.loadQuestion()
        }
      } else {
        buttonPressed.backgroundColor = UIColor.red
        self.gameOver()
      }
    }
  }
  
  private func loadQuestion() {
    guard let gameSession = self.gameSession,
          let questions = self.questions,
          let questionMoney = self.questionMoney
      else {return}
    guard self.questionIndex + 1 != QuestionsArray.shared.questions.count else {
      self.gameOver()
      return
    }
    if self.wasFriendsChoiceUsed {
      
    }
    self.questionIndex = gameSession.numberOfQuestionsAsked
    self.questionDescription.text = "\(questionMoney[self.questionIndex]) рублей"
    self.questionText.text = questions[self.questionIndex].question
    let titleAButton = "A: " + questions[self.questionIndex].answers[0].text
    let titleBButton = "B: " + questions[self.questionIndex].answers[1].text
    let titleCButton = "C: " + questions[self.questionIndex].answers[2].text
    let titleDButton = "D: " + questions[self.questionIndex].answers[3].text
    self.variantAButton.setTitle(titleAButton, for: .normal)
    self.variantAButton.backgroundColor = UIColor.yellow
    self.variantAButton.isHidden = false
    self.variantBButton.setTitle(titleBButton, for: .normal)
    self.variantBButton.backgroundColor = UIColor.yellow
    self.variantBButton.isHidden = false
    self.variantCButton.setTitle(titleCButton, for: .normal)
    self.variantCButton.backgroundColor = UIColor.yellow
    self.variantCButton.isHidden = false
    self.variantDButton.setTitle(titleDButton, for: .normal)
    self.variantDButton.backgroundColor = UIColor.yellow
    self.variantDButton.isHidden = false
  }
  
  private func gameOver() {
    guard let gameSession = self.gameSession else {return}
    let record = Record(date: Date(), value: gameSession.result.value)
    Game.shared.addRecord(record)
    Game.shared.gameSession = nil
    var prize: Int = 0
    if gameSession.numberOfQuestionsAsked != 0 {
      prize = QuestionsArray.shared.questionMoney[gameSession.numberOfQuestionsAsked - 1]
    }
    let alertVC = UIAlertController(
      title: "Игра окончена",
      message: "Вы ответили верно на \(round(gameSession.result.value))% вопросов и выиграли \(prize) рублей",
      preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
      self.dismiss(animated: true, completion: nil)
      })
    alertVC.addAction(action)
    self.present(alertVC, animated: true, completion: nil)
  }
  
}

/// Делегат игры
public protocol GameSessionDelegate: class {
  func answerSelected(
    isRight: Bool,
    wasFriendsChoiceUsed: Bool,
    wasAudienceChoiceUsed: Bool,
    wasFiftyFiftyUsed: Bool)
}
