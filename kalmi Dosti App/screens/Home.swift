//
//  Home.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 06/06/25.
//

import SwiftUI

struct ListItem: Identifiable {
    let id = UUID()
    let title: String
    let desc: String
    let image: String
}

struct Home: View {

    @State private var username = ""
    @State private var password = ""
    let items: [ListItem] = [
        ListItem(
            title: "Chatbot",
            desc: "Express yourself to AI companion – your trusted listener.",
            image: "chatbot"),
        ListItem(
            title: "Journal",
            desc:
                "Capture your thoughts, memories, and reflections in the diary.",
            image: "notebook"),
        ListItem(
            title: "Meditation",
            desc:
                "Boost your well-being  – whether it's stress or mental health, and stay fit.",
            image: "meditation"),
    ]

    var body: some View {
        ZStack {
            Color.faceB5
                .ignoresSafeArea()

            VStack(spacing: 0) {

                ZStack(alignment: .bottomLeading) {

                    Color.themeGreen
                        .frame(height: 179)
                        .cornerRadius(48, corners: [.bottomLeft, .bottomRight])

                    HStack(alignment: .center, spacing: 17) {
                        Image("user")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 54, height: 54)

                        Text("Hi, Sara")
                            .winkySans(
                                size: 36, weight: 400, color: .black
                            )
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom, 25)

                }

                Spacer()

                //   NavigationView {
                VStack(spacing: 16) {
                    ForEach(items) { item in

                        //                                    NavigationLink(destination: destinationView(for: index)
                        //                                    ) {
                        HStack(spacing: 0) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(item.title)")
                                    .winkySans(
                                        size: 20, weight: 500, color: .black
                                    )
                                Text("\(item.desc)")
                                    .winkySans(
                                        size: 10, weight: 300, color: .black
                                    )
                                    .padding(.trailing, 30)

                            }
                            Spacer()
                            Image("\(item.image)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                            //  .foregroundColor(.white)
                        }
                        .padding(25)
                        .frame(height: 123)
                        .background(Color.themeGreen.opacity(0.8))
                        .cornerRadius(25)
                        .shadow(radius: 3)
                        //  }
                        // }

                        //  }
                        .padding(.horizontal, 32)

                    }
                }
                //  .background(Color.red)
                Spacer()
                FloatingBottomTabBar()

            }.edgesIgnoringSafeArea(.top)

        }

    }
}

#Preview {
    Home()
}
