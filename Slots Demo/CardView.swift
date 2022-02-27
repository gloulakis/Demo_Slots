//
//  CardView.swift
//  Slots Demo
//
//  Created by Georgios Loulakis on 25.02.22.
//

import SwiftUI

struct CardView: View {

    @Binding var symbol:String
    @Binding var background:Color
    var body: some View {
        Image(symbol)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .background(background.opacity(0.5))
            .border(background)
            .cornerRadius(20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(symbol: Binding.constant("chery"),background: Binding.constant(.green))
    }
}
