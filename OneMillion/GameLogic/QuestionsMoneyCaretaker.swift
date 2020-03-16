//
//  QuestionsMoneyCaretaker.swift
//  OneMillion
//
//  Created by Anastasia Romanova on 30/09/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

import Foundation

/// Для записи стоимости пользовательских вопросов
final public class QuestionsMoneyCaretaker {
  
  private let encoder = JSONEncoder()
  private let decoder = JSONDecoder()
  
  private let key = "questionsMoney"
  
  /// Сохранение стоимости пользовательских вопросов
  ///
  /// - Parameter questionsMoney: стоимость вопросов пользователя
  public func save(questionsMoney: [Int]) {
    do {
      let data = try self.encoder.encode(questionsMoney)
      UserDefaults.standard.set(data, forKey: key)
    } catch {
      print(error)
    }
  }
  
  /// Извлечение стоимости пользовательских вопросов
  ///
  /// - Returns: стоимость пользовательских вопросов
  public func retrieveQuestionsMoney() -> [Int] {
    guard let data = UserDefaults.standard.data(forKey: key) else {
      return []
    }
    do {
      return try self.decoder.decode([Int].self, from: data)
    } catch {
      print(error)
      return []
    }
  }
}
