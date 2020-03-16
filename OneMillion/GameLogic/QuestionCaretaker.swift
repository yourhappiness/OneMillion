//
//  QuestionCaretaker.swift
//  OneMillion
//
//  Created by Anastasia Romanova on 30/09/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

import Foundation

/// Для записи пользовательских вопросов
final public class QuestionCaretaker {
  
  private let encoder = JSONEncoder()
  private let decoder = JSONDecoder()
  
  private let key = "questions"
  
  /// Сохранение пользовательских вопросов
  ///
  /// - Parameter questions: вопросы пользователя
  public func save(questions: [Question]) {
    do {
      let data = try self.encoder.encode(questions)
      UserDefaults.standard.set(data, forKey: key)
    } catch {
      print(error)
    }
  }
  
  /// Извлечение пользовательских вопросов
  ///
  /// - Returns: пользовательские вопросы
  public func retrieveQuestions() -> [Question] {
    guard let data = UserDefaults.standard.data(forKey: key) else {
      return []
    }
    do {
      return try self.decoder.decode([Question].self, from: data)
    } catch {
      print(error)
      return []
    }
  }
}
