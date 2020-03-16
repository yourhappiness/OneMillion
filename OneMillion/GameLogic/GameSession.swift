//
//  GameSession.swift
//  OneMillion
//
//  Created by Anastasia Romanova on 25/09/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

import Foundation

/// Текущая игровая сессия
public class GameSession: GameSessionDelegate {
  /// Общее количество вопросов
  public let numberOfQuestions: Int = QuestionsArray.shared.questions.count
  /// Количество заданных вопросов
  public var numberOfQuestionsAsked: Int = 0
  /// Номер вопроса
  public var questionNumber: Observable<Int> = Observable(value: 1)
  /// Количество правильных ответов
  public var numberOfQuestionsSolved: Int = 0
  /// Возможность воспользоваться подсказкой "Звонок другу"
  public var isFriendsChoiceAvailable: Bool = true
  /// Возможность воспользоваться подсказкой "Помощь зала"
  public var isAudienceChoiceAvailable: Bool = true
  /// Возможность воспользоваться подсказкой "50/50"
  public var isFiftyFiftyAvailable: Bool = true
  /// Процент правильных ответов
  public var result: Observable<Double> = Observable(value: 0.0)
  
  /// Обновляет данные игры при выборе ответа
  ///
  /// - Parameter isRight: верный ли ответ
  public func answerSelected(
    isRight: Bool,
    wasFriendsChoiceUsed: Bool,
    wasAudienceChoiceUsed: Bool,
    wasFiftyFiftyUsed: Bool) {
    self.numberOfQuestionsAsked += 1
    if self.isFiftyFiftyAvailable {
      self.isFiftyFiftyAvailable = !wasFiftyFiftyUsed
    }
    if self.isAudienceChoiceAvailable {
      self.isAudienceChoiceAvailable = !wasAudienceChoiceUsed
    }
    if self.isFriendsChoiceAvailable {
      self.isFriendsChoiceAvailable = !wasFriendsChoiceUsed
    }
    if isRight {
      self.numberOfQuestionsSolved += 1
    }
    self.result.value = Double(self.numberOfQuestionsSolved) / Double(self.numberOfQuestions) * 100
    if self.questionNumber.value < QuestionsArray.shared.questions.count {
      self.questionNumber.value += 1
    }
  }
}

