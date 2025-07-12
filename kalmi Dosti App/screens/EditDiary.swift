//
//  EditDiary.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 17/06/25.
//

import SwiftData
import SwiftUI

struct EditDiary: View {

    var existingJournal: Journal?
    @State private var pageTitle: String = ""
    @State private var journalText: String = ""
    let characterLimit = 300
    @State private var showDeleteModal = false
    @State private var showSaveModal = false
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query var users: [User]

    // Custom init to prefill fields if editing
    init(journal: Journal? = nil) {
        self.existingJournal = journal
        _pageTitle = State(initialValue: journal?.title ?? "")
        _journalText = State(initialValue: journal?.summary ?? "")
    }

    var body: some View {
        ZStack {
            Color.faceB5
                .ignoresSafeArea()

            VStack {
                NavigationHeaderView(
                    title: "",
                    showTitle: false,
                    showRightImage1: true,
                    showRightImage2: true,
                    rightImage1: Image("delete"),
                    rightImage2: Image("save"),
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

                Spacer()

                VStack(alignment: .leading, spacing: 10) {

                    TextField("Title", text: $pageTitle, axis: .vertical)
                        .lineLimit(1...3)
                        .font(.custom("winkySans", size: 32).weight(.medium))
                        .multilineTextAlignment(.leading)
                        .padding(.top, 40)
                        .padding(.horizontal, 18)
                        .onChange(of: pageTitle) { oldValue, newValue in
                            // Enforce character limit while typing
                            if newValue.count > characterLimit {
                                pageTitle = String(
                                    newValue.prefix(characterLimit))
                            }
                        }
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.themeGreenDark)

                    TextField(
                        "Type Something...", text: $journalText, axis: .vertical
                    )
                    .lineLimit(1...3)
                    .font(.custom("winkySans", size: 20).weight(.regular))
                    .padding(.horizontal, 20)
                    .background(Color.faceB5)
                    .scrollContentBackground(.hidden)

                    Spacer()
                }

            }.background(Color.clear)

            if showDeleteModal {
                CustomModalView(
                    image: Image("info"),
                    title: "Are you sure you want to discard changes?",
                    onDiscard: {
                        print("Discarded")
                        showDeleteModal = false
                    },
                    onSave: {
                        print("Saved")
                        showDeleteModal = false
                    },
                    onDismiss: {
                        pageTitle = ""
                        journalText = ""
                        showDeleteModal = false
                        dismiss()
                    }

                )
            }

            if showSaveModal {
                CustomModalView(
                    image: Image("info"),
                    title: "Save changes ?",
                    onDiscard: {
                        print("Discarded")
                        showSaveModal = false
                    },
                    onSave: {
                        if let currentUser = users.first(where: {
                            $0.email
                                == UserDefaults.standard.string(
                                    forKey: "loggedInEmail")
                        }) {
                            if let journal = existingJournal {
                                // Update existing journal
                                journal.title = pageTitle
                                journal.summary = journalText
                                print("Updated journal")
                            } else {
                                // Create new journal
                                let newEntry = Journal(
                                    title: pageTitle, summary: journalText)
                                currentUser.diary.append(newEntry)
                                print("Created new journal")
                            }

                            do {
                                try modelContext.save()
                                print("Saved journal")
                                dismiss()
                            } catch {
                                print("Error saving: \(error)")
                            }
                        }
                    },
                    onDismiss: {
                        showSaveModal = false
                    }
                )
            }

        }.hideNavBar()

    }

}
