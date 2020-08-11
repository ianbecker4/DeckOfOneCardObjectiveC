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
        drawCardButton.layer.cornerRadius = drawCardButton.frame.height/2
        self.fetchCards()
    }
    
    //MARK: - Action
    @IBAction func drawCardButtonTapped(_ sender: Any) {
        self.fetchCards()
    }
    // MARK: - Helper Functions
    
    /**
     Fetches cards via our drawNewCard function on the model Controller as well as our fetchCardImage function and calls our updateViews function to display the recieved data
     
    This function takes in no parameters. fetch cards allows us to retrieve the card data from our API and then subsequently call the update views function to display the data that we retrieved
    */
    func fetchCards() {
        // Retrieve a card from the api
        DVMCardController.drawANewCard(1) { (cards) in
            // Unwrap our cards array that is completed with
            if let cards = cards {
                // Fetch the image for the first card (since we passed in 1 for the card count, we just need to access the first card in the array)
                DVMCardController.fetchCardImage(cards[0]) { (cardImage) in
                    // From the main queue, we call our update views function, passing in the card and it's image. This must be done from the main queue because our updateViews function is making changes to our UI.
                    DispatchQueue.main.async {
                        if let cardImage = cardImage {
                            self.updateViews(card: cards[0], image: cardImage)
                        }
                    }
                }
            }
        }
    }

    /**
     Updates our views based on card and image data passed in
     
    This function updates our views on our view controller. The imageView and suitLabel and adjusted properly for the passed in card and image along with the label color and button color are adjusted to match the suit color.
     

     - Parameter card: the card containing the suit string value for our suitLabel
     
     - Parameter image: the image to be displayed in our cardImageView
     */
    func updateViews(card: DVMCard, image: UIImage) {
        // Update the imageView with the passed in image
        self.cardImageView.image = image
        // update the label with the passed in card's suit value
        self.suitLabel.text = card.suit
        
        //Just for fun
        //Switch statement to match button and label to card color
        switch card.suit {
        case "DIAMONDS":
            self.drawCardButton.backgroundColor = .systemRed
            self.suitLabel.textColor = .systemRed
        case "HEARTS":
            self.drawCardButton.backgroundColor = .systemRed
            self.suitLabel.textColor = .systemRed
        case "SPADES":
            self.drawCardButton.backgroundColor = .black
            self.suitLabel.textColor = .black
        case "CLUBS":
            self.drawCardButton.backgroundColor = .black
            self.suitLabel.textColor = .black
        default:
            break
            
        }
    }
}
