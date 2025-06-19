//
//  EditDiary.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 17/06/25.
//

import SwiftUI

struct EditDiary: View {

    @State private var pageTitle: String = ""
    @State private var journalText: String = ""
    let characterLimit = 300
    @State private var showDeleteModal = false
    @State private var showSaveModal = false
    @Environment(\.dismiss) var dismiss
   

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
                        .onChange(of: pageTitle) { newValue in
                            // Enforce character limit while typing
                            if newValue.count > characterLimit {
                                pageTitle = String(
                                    newValue.prefix(characterLimit))
                            }
                        }
                    //                        .onPasteCommand(of: [.plainText]) { items in
                    //            // Handle paste event and enforce character limit
                    //                            if let pastedText = items. {
                    //                let newText = pageTitle + pastedText
                    //                if newText.count > characterLimit {
                    //        // Limit the pasted content to fit within the character limit
                    //            pageTitle = String(newText.prefix(characterLimit))
                    //                } else {
                    //                pageTitle = newText
                    //                                }
                    //                            }
                    //                        }

                    //                    Text("\(pageTitle.count)/\(characterLimit) characters") // Optional: Shows character count
                    //                                    .font(.footnote)
                    //                                    .foregroundColor(pageTitle.count > characterLimit ? .red : .gray)
                    //                                    .padding(.top, 5)

                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.themeGreenDark)
                    // Journal body input

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
                        showDeleteModal = false
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
                        print("Saved")
                        showSaveModal = false
                    },
                    onDismiss: {
                        showSaveModal = false
                    }
                )
            }

        }.hideNavBar()

    }

}
//#Preview {
//    EditDiary()
//}
