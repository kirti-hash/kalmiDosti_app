//
//  Meditation.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 18/06/25.
//

import SwiftUI

struct ListItemYoga: Identifiable {
    let id = UUID()
    let title: String
    let desc: String
    let image: String
}

struct CategoryItem: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let poses: String
}

struct Meditation: View {

    @State private var pageTitle: String = ""
    @State private var journalText: String = ""
    let characterLimit = 300
    @State private var showDeleteModal = false
    @State private var showSaveModal = false
    @Environment(\.dismiss) var dismiss

    let items: [ListItemYoga] = [
        ListItemYoga(
            title: "Stress relief yoga",
            desc: "30 min",
            image: "1"),
        ListItemYoga(
            title: "Anxiety relief yoga",
            desc:
                "10 min",
            image: "2"),
        ListItemYoga(
            title: "Insomnia yoga",
            desc:
                "30 min",
            image: "3"),
    ]

    var body: some View {
        ZStack {
            Color.themeGreen
                .ignoresSafeArea()

            VStack(alignment: .leading) {
                NavigationHeaderView(
                    title: "Meditation/Yoga",
                    showTitle: true,
                    showRightImage1: false,
                    showRightImage2: false,
                    rightImage1: Image("delete"),
                    rightImage2: Image("save"),
                    bgColor: Color.faceB5,
                    onBack: {
                        print("Back tapped")
                        dismiss()
                    },
                    onRightImage1Tap: {
                        print("Bell tapped")
                        showDeleteModal = true
                    },
                    onRightImage2Tap: {
                        print("Gear tapped")
                        showSaveModal = true
                    }
                )
                HorizontalListView()

                Text("Recommended for you")
                    .lexend(
                        size: 24, weight: 600, color: .black
                    )
                    .padding(.all, 20)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 7) {

                        ForEach(items) { item in

                            HStack(spacing: 10) {
                                Image("\(item.image)")
                                    .resizable()
                                    .frame(width: 128, height: 80)
                                    .cornerRadius(5)
                                    .onTapGesture {
                                        if let url = URL(
                                            string:
                                                "https://www.youtube.com/watch?v=xEWq8TamGNQ"
                                        ) {
                                            UIApplication.shared.open(url)
                                        }
                                    }

                                VStack(alignment: .leading, spacing: 3) {
                                    Text("\(item.title)")
                                        .lexend(
                                            size: 14, weight: 500, color: .black
                                        )
                                    Text("\(item.desc)")
                                        .winkySans(
                                            size: 13, weight: 400,
                                            color: .secondary
                                        )
                                }
                                Spacer()
                            }
                            .padding(15)
                            .frame(height: 110)
                            .background(Color.faceB5.opacity(0.8))
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .padding(.horizontal, 19)

                        }
                    }
                }
                Spacer()

            }
        }
    }
}

struct HorizontalListView: View {

    let sampleCategories: [CategoryItem] = [
        CategoryItem(title: "Seated backward", imageName: "7", poses: "4"),
        CategoryItem(title: "Happy baby", imageName: "8", poses: "5"),
        CategoryItem(title: "Relax spine", imageName: "9", poses: "6"),
        CategoryItem(title: "Stretch sitting", imageName: "10", poses: "2"),
        CategoryItem(
            title: "Arm stretch", imageName: "11", poses: "3"),
        CategoryItem(
            title: "Legs stretch", imageName: "12", poses: "4"),
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(sampleCategories) { item in
                    VStack(alignment: .leading, spacing: 4) {
                        Image(item.imageName)
                            .resizable()
                            .frame(width: 148, height: 88)
                            .cornerRadius(12)
                            .foregroundColor(.black)
                            .padding(.bottom, 6)
                            .onTapGesture {
                                if let url = URL(
                                    string:
                                        "https://en.wikipedia.org/wiki/List_of_asanas"
                                ) {
                                    UIApplication.shared.open(url)
                                }
                                
                            }

                        Text(item.title)
                            .lexend(size: 13, weight: 500, color: .black)
                            .foregroundColor(.black)
                        Text("\(item.poses) poses")
                            .lexend(
                                size: 13, weight: 500, color: .themeGreenDark
                            )
                            .foregroundColor(.black)
                    }
                    .padding()
                    // .frame(width: 100, height: 100)
                    .background(Color.faceB5)
                    .cornerRadius(16)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
        }.hideNavBar()
    }
}

