//
//  BackgroundView.swift
//  ment.me
//
//  Created by Zaynah Alam on 20/04/2024.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height

            ZStack {
                
                Path { path in
                    path.move(to: CGPoint(x: 0, y: height * 0.6))
                    path.addCurve(to: CGPoint(x: width, y: height * 0.4),
                                  control1: CGPoint(x: width * 0.2, y: height * 0.8),
                                  control2: CGPoint(x: width * 0.8, y: height * 0.2))
                    path.addLine(to: CGPoint(x: width, y: height))
                    path.addLine(to: CGPoint(x: 0, y: height))
                    path.closeSubpath()
                }
                .fill(Color(red: 1.0, green: 0.7, blue: 0.4).opacity(0.2))

                Path { path in
                    path.move(to: CGPoint(x: 0, y: height * 0.2))
                    path.addCurve(to: CGPoint(x: width, y: 0),
                                  control1: CGPoint(x: width * 0.2, y: height * 0.4),
                                  control2: CGPoint(x: width * 0.8, y: -height * 0.2))
                    path.addLine(to: CGPoint(x: width, y: height * 0.4))
                    path.addCurve(to: CGPoint(x: 0, y: height * 0.6),
                                  control1: CGPoint(x: width * 0.8, y: height * 0.2),
                                  control2: CGPoint(x: width * 0.2, y: height * 0.8))
                    path.closeSubpath()
                }
                .fill(Color.pink.opacity(0.2))

                Path { path in
                    path.move(to: CGPoint(x: 0, y: height * 0.6))
                    path.addCurve(to: CGPoint(x: width, y: height * 0.4),
                                  control1: CGPoint(x: width * 0.2, y: height * 0.8),
                                  control2: CGPoint(x: width * 0.8, y: height * 0.2))
                    path.addLine(to: CGPoint(x: width, y: height * 0.8))
                    path.addCurve(to: CGPoint(x: 0, y: height * 1.0),
                                  control1: CGPoint(x: width * 0.8, y: height * 0.6),
                                  control2: CGPoint(x: width * 0.2, y: height * 1.2))
                    path.closeSubpath()
                }
                .fill(Color.blue.opacity(0.3))
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
