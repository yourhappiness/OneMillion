//
//  QuestionsSequenceStrategy.swift
//  OneMillion
//
//  Created by Anastasia Romanova on 28/09/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

import Foundation

/// Варианты последовательности вопросов в игре
///
/// - predetermined: по порядку
/// - random: в случайном порядке
public enum QuestionsSequence {
  case predetermined, random
}

/// Стратегия отображения вопросов в игре
public protocol QuestionsSequenceStrategy {
  func getQuestions () -> [Question]
}

/// Стратегия для отображения вопросов в заданном порядке
public class PredeterminedSequenceStrategy: QuestionsSequenceStrategy {
  /// Функция для получения массива вопросов
  ///
  /// - Returns: массив вопросов в заданном порядке
  public func getQuestions() -> [Question] {
    return QuestionsArray.shared.questions
  }
}

/// Стратегия для отображения вопросов в случайном порядке
public class RandomSequenceStrategy: QuestionsSequenceStrategy {
  /// Функция для получения массива вопросов
  ///
  /// - Returns: массив вопросов в случайном порядке
  public func getQuestions() -> [Question] {
    let questions = QuestionsArray.shared.questions
    return questions.shuffled()
  }
}
