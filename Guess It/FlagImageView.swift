//
//  FlagImageView.swift
//  Guess It
//
//  Created by MAC on 05/03/2023.
//

import SwiftUI

struct FlagImageView: View {
    var number: Int
    var image : String
    var method: (Int) -> Void
    
    
    
    var body: some View {
        //How to pass a parameter to the action of Button with SwiftUI and using "action" with "Label" in Button.
        Button(action: {method(number)}) {
        Image(image)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 5)
            
        //use this to give it a capsule shape -->.clipShape(Capsule())
      }
    }
}

/* A BUTTON WITHOUT ACTION
 ------------
 Button {
     flagTapped(number)
 } label: {
     Image(countries[number])
         .renderingMode(.original)
         .clipShape(RoundedRectangle(cornerRadius: 20))
         .shadow(radius: 5)
     //use this to give it a capsule shape -->.clipShape(Capsule())
 }
 ------------
 
 
 
 A BUTTON WITH ACTION::
 
 If you want the button label to be an image, you can simply use the Image view directly as the label, like this:
 
 ------------
 Button(action: { method(number) }) {
     Image(image)
         .renderingMode(.original)
         .clipShape(RoundedRectangle(cornerRadius: 20))
         .shadow(radius: 5)
 }
 ------------
 Note that you don't need to use the Label initializer in this case, since the Button view has a constructor that accepts an image directly.
 
 
 
 If you want both text and image at the same time, SwiftUI has a dedicated type called Label.
 If you do need to use the Label initializer, you can pass the Image view as the second argument to the initializer, like this:
 
 ------------
 Button(action: { method(number) }) {
     Label(
         title: { Text("") }, // Empty text
         icon: {
             Image(image)
                 .renderingMode(.original)
                 .clipShape(RoundedRectangle(cornerRadius: 20))
                 .shadow(radius: 5)
         }
     )
 }
 ------------
 In this case, the empty text is used as the button's accessibility label, while the image is used as the visual label.
 
 
 
 How to use Label in a Button that has no action::
 ---------
 Button {
     print("Edit button was tapped")
 } label: {
     Label("Edit", systemImage: "pencil")
 }
---------
 
 
 NOTE: label is different from Label.
 */
