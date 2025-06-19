//
//  EditProfile.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 18/06/25.
//

import PhotosUI
import SwiftUI
import UIKit

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

struct EditProfile: View {

    @State private var username: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker = false
    @State private var useCamera = false
    @Environment(\.dismiss) var dismiss

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
                    text: $username,
                    backgroundColor: Color.white,
                    borderColor: .green,
                    cornerRadius: 12,
                    borderWidth: 2
                )
                CustomTextfieldProfile(
                    title: "Password",
                    placeholder: "Enter your password",
                    text: $username,
                    backgroundColor: Color.white,
                    borderColor: .green,
                    cornerRadius: 12,
                    borderWidth: 2
                )
                
                CustomButton(title: "Save Changes", backgroundColor: .faceB5, action: {
                    
                }).padding(.horizontal, 34)
                    .padding(.vertical, 40)
                Spacer()

            }
        }.hideNavBar()
    }
}

//#Preview {
//    EditProfile()
//}
