//
//  Diary.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 07/06/25.
//

import SwiftUI

struct Diary: View {

    @State private var username = ""
    @State private var password = ""
    @Environment(\.dismiss) var dismiss
    @State private var goToNewDiary = false

    var body: some View {
        ZStack {
            Color.faceB5
                .ignoresSafeArea()

            VStack {
                NavigationHeaderView(
                    title: "Diary",
                    showTitle: true,
                    showRightImage1: false,
                    showRightImage2: false,
                    rightImage1: Image("delete"),
                    rightImage2: Image("save"),
                    onBack: {
                        print("Back tapped")
                        dismiss()
                    },
                    onRightImage1Tap: {
                        print("Bell tapped")
                    },
                    onRightImage2Tap: {
                        print("Gear tapped")
                    }
                )

                Spacer()

                Image("writing")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200, alignment: .center)
                Text("Create.your.first.Journal")
                    .lexend(size: 20, weight: 400, color: .black)
                    .padding(.top, 6)

                Spacer()

                HStack {
                    Spacer()

                    Button(action: {
                        print("Plus icon tapped")
                        goToNewDiary = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .background(Color.black)
                            .clipShape(Circle())
                            .foregroundStyle(Color.themeGreen)
                    }
                    
                    NavigationLink(
                        "", destination: EditDiary(), isActive: $goToNewDiary
                    )
                    .hidden()
                    
                }.padding(.horizontal, 33)
                    .padding(.vertical, 30)

            }
        }.hideNavBar()
    }
}

//#Preview {
//    Diary()
//}
