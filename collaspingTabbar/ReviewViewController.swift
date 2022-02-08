//
//  ReviewViewController.swift
//  collaspingTabbar
//
//  Created by macbook on 9/2/2565 BE.
//

import UIKit

class ReviewViewController: UIViewController {
    @IBOutlet private var submitBtn: UIButton!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var userName: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var reviewEditText: UITextView!
    
    var userImage: String?
    var userNameText: String?
    var dateText: String?
    var timeText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let nameTxt = userNameText, let image = userImage, let date = dateText, let timeTxt = timeText {
            imageView.image = UIImage(named: image)
            userName.text = nameTxt
            dateLabel.text = date
            timeLabel.text = timeTxt
            
        }
        reviewEditText.text = "Write you review here ..."
        reviewEditText.textColor = UIColor.lightGray
        reviewEditText.delegate = self
        reviewEditText.becomeFirstResponder()
        reviewEditText.selectedTextRange = reviewEditText.textRange(from: reviewEditText.beginningOfDocument, to: reviewEditText.beginningOfDocument)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension ReviewViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Combine the textView text and the replacement text to
            // create the updated text string
            let currentText:String = textView.text
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

            // If updated text view will be empty, add the placeholder
            // and set the cursor to the beginning of the text view
            if updatedText.isEmpty {

                textView.text = "Write you review here ..."
                textView.textColor = UIColor.lightGray

                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }

            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, set
            // the text color to black then set its text to the
            // replacement string
             else if textView.textColor == UIColor.lightGray && !text.isEmpty {
                textView.textColor = UIColor.black
                textView.text = text
            }

            // For every other case, the text should change with the usual
            // behavior...
            else {
                return true
            }

            // ...otherwise return false since the updates have already
            // been made
            return false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if self.view.window != nil {
              if textView.textColor == UIColor.lightGray {
                  textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
              }
          }
    }
}
