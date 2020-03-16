//
//  Question.swift
//  OneMillion
//
//  Created by Anastasia Romanova on 25/09/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

import Foundation

/// Структура для создания вопроса
public struct Question: Codable {
  /// Текст вопроса
  public let question: String
  /// Варианты ответов
  public let answers: [Answer]
  /// Индекс ответа для подсказки "помощь зала"
  public let audienceChoiceIndex: Int
  /// Индекс ответа для подсказки "звонок другу"
  public let friendChoiceIndex: Int
}

/// Структура ответа
public struct Answer: Codable, Equatable {
  /// Текст ответа
  public let text: String
  /// Верный ли ответ
  public let isCorrect: Bool
}
