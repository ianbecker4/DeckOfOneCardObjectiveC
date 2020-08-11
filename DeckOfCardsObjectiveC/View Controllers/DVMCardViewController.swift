//
//  DVMCardViewController.swift
//  DeckOfCardsObjectiveC
//
//  Created by Marcus Armstrong on 11/18/19.
//  Copyright © 2019 Marcus Armstrong. All rights reserved.
//

import UIKit

class DVMCardViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var suitLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var drawCardButton: UIButton!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchCards()
    }
    
    //MARK: - Action
    @IBAction func drawCardButtonTapped(_ sender: Any) {
        self.fetchCards()
    }
    // MARK: - Helper Functions
    func fetchCards() {
        DVMCardController.drawANewCard(1) { (cards) in
            if let cards = cards {
                DVMCardController.fetchCardImage(cards[0]) { (cardImage) in
                    DispatchQueue.main.async {
                        if let cardImage = cardImage {
                            self.updateViews(card: cards[0], image: cardImage)
                        }
                    }
                }
            }
        }
    }
    
    func updateViews(card: DVMCard, image: UIImage) {
        self.cardImageView.image = image
        self.suitLabel.text = card.suit
    }
}
