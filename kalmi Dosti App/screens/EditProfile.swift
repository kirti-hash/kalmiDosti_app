//
//  EditProfile.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 18/06/25.
//

import PhotosUI
import SwiftData
import SwiftUI
import UIKit

struct EditProfile: View {

    @Query var users: [User]
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker = false
    @State private var useCamera = false
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        ZStack {
            Color.themeGreen
                .ignoresSafeArea()

            VStack {
                NavigationHeaderView(
                    title: "Edit Profile",
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
                        //  showDeleteModal = true
                    },
                    onRightImage2Tap: {
                        print("Gear tapped")
                        //  showSaveModal = true
                    }
                )

                VStack(alignment: .center, spacing: 0) {
                    ZStack(alignment: .bottomTrailing) {
                        // Default or selected image
                        Group {
                            if let selectedImage = selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                            } else if let imageData = users.first(where: {
                                $0.email
                                    == UserDefaults.standard.string(
                                        forKey: "loggedInEmail")
                            })?.imageData, let image = UIImage(data: imageData)
                            {
                                Image(uiImage: image)
                                    .resizable()
                            } else {
                                Image("user")
                                    .resizable()
                                    .foregroundColor(.gray)
                            }
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 3))
                        .padding(.top, 25)

                        // Upload button
                        Menu {
                            Button("Choose from Gallery") {
                                useCamera = false
                                showImagePicker = true
                            }
                            Button("Take Photo") {
                                useCamera = true
                                showImagePicker = true
                            }
                        } label: {
                            Image(systemName: "camera.fill")
                                .padding(8)
                                .background(Color.themeGreen)
                                .foregroundStyle(Color.black)
                                .clipShape(Circle())
                                .shadow(radius: 2)
                        }
                        .offset(x: -0, y: -4)
                    }

                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(
                        image: $selectedImage,
                        sourceType: useCamera ? .camera : .photoLibrary)
                }

                CustomTextfieldProfile(
                    title: "Name",
                    placeholder: "Enter your name",
                    text: $username,
                    backgroundColor: Color.white,
                    borderColor: .green,
                    cornerRadius: 12,
                    borderWidth: 2
                )
                CustomTextfieldProfile(
                    title: "Email",
                    placeholder: "Enter your email",
                    text: $email,
                    backgroundColor: Color.white,
                    borderColor: .green,
                    cornerRadius: 12,
                    borderWidth: 2
                )
                CustomTextfieldProfile(
                    title: "Password",
                    placeholder: "Enter your password",
                    text: $password,
                    backgroundColor: Color.white,
                    borderColor: .green,
                    cornerRadius: 12,
                    borderWidth: 2,
                    isPassword: true
                )

                CustomButton(
                    title: "Save Changes", backgroundColor: .faceB5,
                    action: {
                        // Validate inputs
                        guard !username.isEmpty,
                            !email.isEmpty,
                            !password.isEmpty
                        else {
                            print("All fields are required.")
                            return
                        }

                        guard email.contains("@"), email.contains(".") else {
                            print("Invalid email format.")
                            return
                        }

                        guard password.count >= 8 else {
                            print("Password must be at least 8 characters.")
                            return
                        }

                        if let index = users.firstIndex(where: {
                            $0.email
                                == UserDefaults.standard.string(
                                    forKey: "loggedInEmail")
                        }) {
                            // Update values in SwiftData
                            users[index].username = username
                            users[index].email = email
                            users[index].password = password

                            if let selectedImage = selectedImage {
                                users[index].imageData = selectedImage.jpegData(
                                    compressionQuality: 0.8)
                            }

                            do {
                                try modelContext.save()
                                dismiss()
                            } catch {
                                print(
                                    "Error saving user: \(error.localizedDescription)"
                                )
                            }

                        } else {
                            print("User not found.")
                        }
                    }
                ).padding(.horizontal, 34)
                    .padding(.vertical, 40)
                Spacer()

            }.onAppear {
                if let currentUser = users.first(where: {
                    $0.email
                        == UserDefaults.standard.string(forKey: "loggedInEmail")
                }) {
                    self.username = currentUser.username
                    self.email = currentUser.email
                    self.password = currentUser.password

                    // You can also prefill other fields like image, bio, etc.
                }
            }
        }.hideNavBar()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType = .photoLibrary

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate,
        UIImagePickerControllerDelegate
    {
        let parent: ImagePicker
        init(_ parent: ImagePicker) { self.parent = parent }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController
                .InfoKey: Any]
        ) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(
        _ uiViewController: UIImagePickerController, context: Context
    ) {}
}
