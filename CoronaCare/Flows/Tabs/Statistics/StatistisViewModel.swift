//
//  StatistisViewModel.swift
//  VirusCare
//
//  Created by Behrad Kazemi on 3/12/20.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Foundation
import Domain
import RxCocoa
import RxSwift

struct StatistisViewModel: ViewModelType {
    let navigator: StatisticsNavigator
  let dataBase: DataBaseManagerInterface
  init(navigator: StatisticsNavigator, dataBase: DataBaseManagerInterface) {
        self.navigator = navigator
    self.dataBase = dataBase
    }
    
    func transform(input: Input) -> Output {
      let behaviour = BehaviorSubject(value: [StatisticsItemViewModel]())
      dataBase.getStatistics(response: { [behaviour](items) in
				
        let viewModels = items.compactMap { (stat) -> StatisticsItemViewModel in
          return StatisticsItemViewModel(model: stat)
        }
        behaviour.onNext(viewModels)
      }) { [navigator](error) in
        navigator.logError(error: error, navigatorName: "StatistisViewModel")
      }
      
      let items = behaviour.asObservable()
			return Output(items: items, showEmpty: items.map({ (items) -> Bool in
				return items.isEmpty
				}).asDriver(onErrorJustReturn: false))
    }
}
extension StatistisViewModel {
    struct Input {
        
    }
    
    struct Output {
        let items: Observable<[StatisticsItemViewModel]>
			let showEmpty: Driver<Bool>
    }
}
