//
//  Diary.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 07/06/25.
//

import SwiftData
import SwiftUI

struct Diary: View {

    @State private var username = ""
    @State private var password = ""
    @Environment(\.dismiss) var dismiss
    @State private var goToNewDiary = false
    @Query var users: [User]
    @State private var selectedJournal: Journal? = nil

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
                if let currentUser = users.first(where: {
                    $0.email
                        == UserDefaults.standard.string(forKey: "loggedInEmail")
                }) {
                    if currentUser.diary.isEmpty {
                        Spacer()

                        Image("writing")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200, alignment: .center)
                        Text("Create.your.first.Journal")
                            .lexend(size: 20, weight: 400, color: .black)
                            .padding(.top, 6)

                        Spacer()
                    } else {
                        List(currentUser.diary) { journal in
                            EntryRow(journal: journal)
                                .listRowSeparator(.hidden)
                                .listRowBackground(
                                    Capsule()
                                        .fill(Color.themeGreen)
                                        .padding(2)
                                )
                                //                            VStack(alignment: .leading, spacing: 4) {
                                //                                Text(journal.title)
                                //                                    .font(.headline)
                                //                                Text(journal.summary)
                                //                                    .font(.subheadline)
                                //                                    .foregroundColor(.gray)
                                //                            }
                                .onTapGesture {
                                    selectedJournal = journal
                                    goToNewDiary = true
                                }
                        }
                        .environment(\.defaultMinListRowHeight, 70)
                        .scrollContentBackground(.hidden)
                    }
                    HStack {
                        Spacer()

                        Button(action: {
                            print("Plus icon tapped")

                            selectedJournal = nil
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
                        .navigationDestination(isPresented: $goToNewDiary) {
                            EditDiary(journal: selectedJournal)
                        }
                    }.padding(.horizontal, 33)
                        .padding(.vertical, 30)

                }
            }
        }.hideNavBar()
    }
}

struct EntryRow: View {
    let journal: Journal

    var body: some View {
        HStack {
            Image("heartBrain")
                .resizable()
                .frame(width: 33, height: 30)
                .font(.title)

            VStack(alignment: .leading, spacing: 1) {

                Text(journal.title)
                    .font(.headline)
                    .lineLimit(1)

                Text(journal.summary)
                    .font(.subheadline)
                    .lineLimit(1)

            }

            Spacer()

        }
    }
}
