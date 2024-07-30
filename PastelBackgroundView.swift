//
//  PastelBackgroundView.swift
//  ment.me
//
//  Created by Zaynah Alam on 22/04/2024.
//

import SwiftUI

struct PastelBackgroundView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.orange.opacity(0.3), .blue.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)

                Circle()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.7)
                    .offset(x: geometry.size.width * 0.5, y: -geometry.size.height * 0.3)

                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.5)
                    .offset(x: -geometry.size.width * 0.3, y: geometry.size.height * 0.4)
            }
        }
    }
}

struct PastelBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        PastelBackgroundView()
    }
}
