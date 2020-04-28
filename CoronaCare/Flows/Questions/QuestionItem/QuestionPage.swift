//
//  QuestionPage.swift
//  
//
//  Created by Behrad Kazemi on 3/22/20.
//

import UIKit

class QuestionPage: UIViewController {
	
	var index = 0
	let viewModel: QuestionPageViewModel
	var currentModel: QuestionViewModel! {
		return viewModel.models.count > index ? viewModel.models[index] : .init(model: .defaultModel)
	}
	//
	init(viewModel: QuestionPageViewModel) {
		self.viewModel = viewModel
		super.init(nibName: "QuestionPage", bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@IBOutlet weak var noLabel: UILabel!
	@IBOutlet weak var yesLabel: UILabel!
	@IBOutlet weak var questionImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var yesButton: UIButton!
	@IBOutlet weak var noButton: UIButton!
	@IBOutlet weak var visualEffectView: UIVisualEffectView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		refreshUI()
		// Do any additional setup after loading the view.
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		yesButton.layer.cornerRadius = 8
		noButton.layer.cornerRadius = 8
		noLabel.layer.borderColor = UIColor.lightGray.cgColor
		noLabel.layer.borderWidth = 0.5
		noLabel.layer.cornerRadius = 8
	}
	override func viewWillDisappear(_ animated: Bool) {
		if viewModel.models.count > index {
			viewModel.navigator.toHomeWithAds()
		}
		super.viewWillDisappear(animated)
			
	}
	
	func refreshUI() {
		guard let selectedViewModelItem = viewModel.models.count > index ? viewModel.models[index] : nil else {
			viewModel.navigator.questionsCompleted()
			return
		}
		UIView.animate(withDuration: 0.5) {
			self.questionImageView.image = UIImage(named: selectedViewModelItem.imageName)
			self.titleLabel.text = selectedViewModelItem.title
			self.yesLabel.text = selectedViewModelItem.acceptButtonTitle
			self.noLabel.text = selectedViewModelItem.ignoreButtonTitle
		}
	}
	func nextQuestion(){
		
		index = index + 1
		refreshUI()
	}
	@IBAction func noAction(_ sender: Any) {
		viewModel.setAnswer(answer: .no, forViewModel: currentModel)
		let eventId = currentModel.model.event.asEventProtocol().id
		viewModel.models.forEach { (item) in
			if eventId == item.model.event.asEventProtocol().id {
				viewModel.setAnswer(answer: .no, forViewModel: item)
			}
		}
		viewModel.models.removeAll { (item) -> Bool in
			return eventId == item.model.event.asEventProtocol().id
		}
		nextQuestion()
		Vibrator.vibrate(hardness: 1)
	}
	@IBAction func yesAction(_ sender: Any) {
		viewModel.setAnswer(answer: .done, forViewModel: currentModel)
		let eventId = currentModel.model.event.asEventProtocol().id
		viewModel.models.forEach { (item) in
			if eventId == item.model.event.asEventProtocol().id {
				viewModel.setAnswer(answer: .done, forViewModel: item)
			}
		}
		viewModel.models.removeAll { (item) -> Bool in
			return eventId == item.model.event.asEventProtocol().id
		}
		nextQuestion()
		Vibrator.vibrate(hardness: 2)
	}
}
