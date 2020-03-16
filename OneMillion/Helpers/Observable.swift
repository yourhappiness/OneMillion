//
//  Observable.swift
//  OneMillion
//
//  Created by Anastasia Romanova on 29/09/2019.
//  Copyright © 2019 Anastasia Romanova. All rights reserved.
//

import Foundation

/// Класс-обертка для наблюдения за изменением свойства
public class Observable<Type> {
  
  /// Значение наблюдаемого свойства
  public var value: Type {
    didSet {
      self.didChanded(oldValue: oldValue, newValue: value)
    }
  }
  
  private var observers: [Observer<Type>] = []
  
  init(value: Type) {
    self.value = value
  }
  
  fileprivate class Observer<Type> {
    weak var object: AnyObject?
    var callback: ( (_ oldValue: Type, _ newValue: Type) -> Void )?
  }
  
  /// Добавление наблюдателя за свойством
  ///
  /// - Parameters:
  ///   - anyObject: наблюдатель
  ///   - callback: замыкание, вызываемое при изменении свойства
  public func addObserver(anyObject: AnyObject?, callback: @escaping ( (_ oldValue: Type, _ newValue: Type) -> Void )) {
    let observer = Observer<Type>()
    observer.object = anyObject
    observer.callback = callback
    self.observers.append(observer)
  }
  
  private func didChanded(oldValue: Type, newValue: Type) {
    self.observers.removeAll { (observer) -> Bool in
      return nil == observer.object
    }
    
    for observer in self.observers {
      guard let callback = observer.callback else { continue }
      callback(oldValue, newValue)
    }
  }
}
