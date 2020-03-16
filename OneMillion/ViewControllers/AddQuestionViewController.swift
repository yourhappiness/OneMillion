//
//  AddQuestionViewController.swift
//  OneMillion
//
//  Created by Anastasia Romanova on 29/09/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

import UIKit

/// Контроллер для добавления пользовательского вопроса
public class AddQuestionViewController: UIViewController {

  @IBOutlet weak var questionTextField: UITextField!
  @IBOutlet weak var variantATextField: UITextField!
  @IBOutlet weak var variantBTextField: UITextField!
  @IBOutlet weak var variantCTextField: UITextField!
  @IBOutlet weak var variantDTextField: UITextField!
  @IBOutlet weak var variantAIsRight: UISwitch!
  @IBOutlet weak var variantBIsRight: UISwitch!
  @IBOutlet weak var variantCIsRight: UISwitch!
  @IBOutlet weak var variantDIsRight: UISwitch!
  
  private lazy var switches: [UISwitch] = [self.variantAIsRight,
                                           self.variantBIsRight,
                                           self.variantCIsRight,
                                           self.variantDIsRight]
  
  override public func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func addQuestionButtonWasPressed(_ sender: Any) {
    guard let questionText = self.questionTextField.text,
          !questionText.isEmpty,
          let variantA = self.variantATextField.text,
          !variantA.isEmpty,
          let variantB = self.variantBTextField.text,
          !variantB.isEmpty,
          let variantC = self.variantCTextField.text,
          !variantC.isEmpty,
          let variantD = self.variantDTextField.text,
          !variantD.isEmpty,
          self.variantAIsRight.isOn ||
          self.variantBIsRight.isOn ||
          self.variantCIsRight.isOn ||
          self.variantDIsRight.isOn
    else {
      let alertVC = UIAlertController(
        title: "Ошибка",
        message: "Пожалуйста, заполните все поля и выберите верный вариант ответа",
        preferredStyle: .alert)
      let action = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertVC.addAction(action)
      self.present(alertVC, animated: true, completion: nil)
      return
    }
    let answerA = Answer(text: variantA, isCorrect: self.variantAIsRight.isOn)
    let answerB = Answer(text: variantB, isCorrect: self.variantBIsRight.isOn)
    let answerC = Answer(text: variantC, isCorrect: self.variantCIsRight.isOn)
    let answerD = Answer(text: variantD, isCorrect: self.variantDIsRight.isOn)
    let audienceChoice = Int(arc4random_uniform(4))
    let friendsChoice = Int(arc4random_uniform(4))
    let question = Question(question: questionText,
                            answers: [answerA, answerB, answerC, answerD],
                            audienceChoiceIndex: audienceChoice,
                            friendChoiceIndex: friendsChoice)
    let questionMoney = (QuestionsArray.shared.questionMoney.last ?? 0) + 500000
    QuestionsArray.shared.addQuestion(question: question, money: questionMoney)
    let alertVC = UIAlertController(
      title: "Поздравляем!",
      message: "Ваш вопрос добавлен в игру",
      preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
      self.dismiss(animated: true, completion: nil)
    })
    alertVC.addAction(action)
    self.present(alertVC, animated: true, completion: nil)
  }
  
  @IBAction func variantASwitchValueWasChanged(_ sender: Any) {
    self.switchOtherSwitches(except: self.variantAIsRight)
  }
  
  @IBAction func variantBSwitchValueWasChanged(_ sender: Any) {
    self.switchOtherSwitches(except: self.variantBIsRight)
  }
  
  @IBAction func variantCSwitchValueWasChanged(_ sender: Any) {
    self.switchOtherSwitches(except: self.variantCIsRight)
  }
  
  @IBAction func variantDSwitchValueWasChanged(_ sender: Any) {
    self.switchOtherSwitches(except: self.variantDIsRight)
  }
  
  @IBAction func cancelButtonWasPressed(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  private func switchOtherSwitches(except theSwitch: UISwitch) {
    let switchIndex = self.switches.firstIndex(of: theSwitch)
    for item in self.switches {
      guard let itemIndex = self.switches.firstIndex(of: item) else {return}
      guard itemIndex != switchIndex else {continue}
      self.switches[itemIndex].isOn = false
    }
  }
}
