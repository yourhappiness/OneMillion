//
//  QuestionsArray.swift
//  OneMillion
//
//  Created by Anastasia Romanova on 30/09/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

import Foundation

/// Синглтон с массивом вопросов
public class QuestionsArray {
  private init() {
    self.userQuestions = self.questionsCaretaker.retrieveQuestions()
    self.userQuestionMoney = Observable(value: self.questionsMoneyCaretaker.retrieveQuestionsMoney())
    self.userQuestionMoney.addObserver(anyObject: self, callback: { (_, newValue) in
        self.questionMoney = self.defailtQuestionMoney + newValue
      })
  }
  
  private let questionsCaretaker = QuestionCaretaker()
  private let questionsMoneyCaretaker = QuestionsMoneyCaretaker()

  static let shared = QuestionsArray()

  private let defaultQuestions: [Question] = [
    Question(
      question: "Что растёт в огороде?",
      answers: [
        Answer(text: "Лук", isCorrect: true),
        Answer(text: "Пистолет", isCorrect: false),
        Answer(text: "Пулемёт", isCorrect: false),
        Answer(text: "Ракета СС-20", isCorrect: false)],
      audienceChoiceIndex: 3,
      friendChoiceIndex: 0),
    Question(
      question: "Какой специалист занимается изучением неопознанных летающих объектов?",
      answers: [
        Answer(text: "Кинолог", isCorrect: false),
        Answer(text: "Уфолог", isCorrect: true),
        Answer(text: "Сексопатолог", isCorrect: false),
        Answer(text: "Психиатр", isCorrect: false)],
      audienceChoiceIndex: 1,
      friendChoiceIndex: 0),
    Question(
      question: "Как называется разновидность воды, в которой атом водорода замещён его изотопом дейтерием?",
      answers: [
        Answer(text: "Лёгкая", isCorrect: false),
        Answer(text: "Средняя", isCorrect: false),
        Answer(text: "Тяжёлая", isCorrect: true),
        Answer(text: "Невесомая", isCorrect: false)],
      audienceChoiceIndex: 2,
      friendChoiceIndex: 2),
    Question(
      question: "Что в России 19 века делали в дортуаре?",
      answers: [
        Answer(text: "Ели", isCorrect: false),
        Answer(text: "Спали", isCorrect: true),
        Answer(text: "Ездили верхом", isCorrect: false),
        Answer(text: "Купались", isCorrect: false)],
      audienceChoiceIndex: 3,
      friendChoiceIndex: 1),
    Question(
      question: "На что кладут руку члены английского общества лысых во время присяги?",
      answers: [
        Answer(text: "Баскетбольный мяч", isCorrect: false),
        Answer(text: "Бильярдный шар", isCorrect: true),
        Answer(text: "Апельсин", isCorrect: false),
        Answer(text: "Кокосовый орех", isCorrect: false)],
      audienceChoiceIndex: 1,
      friendChoiceIndex: 3)
  ]
  
  private(set) var userQuestions: [Question] {
    didSet {
      self.questionsCaretaker.save(questions: self.userQuestions)
    }
  }
  
  private(set) lazy var questions: [Question] = self.defaultQuestions + self.userQuestions
  
  private let defailtQuestionMoney: [Int] = [5000, 40000, 100000, 400000, 1000000]
  
  private(set) var userQuestionMoney: Observable<[Int]> {
    didSet {
      self.questionsMoneyCaretaker.save(questionsMoney: self.userQuestionMoney.value)
    }
  }
  
  private(set) lazy var questionMoney: [Int] = self.defailtQuestionMoney + self.userQuestionMoney.value
  
  /// Добавление вопроса и его стоимости
  ///
  /// - Parameter question: пользовательский вопрос
  public func addQuestion(question: Question, money: Int) {
    self.userQuestions.append(question)
    self.userQuestionMoney.value.append(money)
  }
  
  /// Очистка пользовательских вопросов и их стоимости
  public func clearQuestionsAndMoney() {
    self.userQuestions = []
    self.userQuestionMoney.value = []
  }
}
