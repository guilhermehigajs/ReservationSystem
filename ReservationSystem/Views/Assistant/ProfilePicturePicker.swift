//
//  ProfilePicturePicker.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 8/17/25.
//

import SwiftUI
import PhotosUI
import UniformTypeIdentifiers

struct ProfilePicturePicker: View {
    
    @Binding var image: UIImage?
    
    @State private var photoItem: PhotosPickerItem?
    @State private var isLoading = false
    
    var title: String
    var size: CGFloat
    var allowsRemoval: Bool
    var placeholderSystemImage: String
    var contentType: UTType?
    
    public init(
        image: Binding<UIImage?>,
        title: String = ViewConstants.ProfilePicturePicker.title,
        size: CGFloat = 120,
        allowsRemoval: Bool = true,
    placeholderSystemImage: String = Constant.Image.ProfilePicturePicker.shape,
        contentType: UTType? = .image
    ) {
        self._image = image
        self.title = title
        self.size = size
        self.allowsRemoval = allowsRemoval
        self.placeholderSystemImage = placeholderSystemImage
        self.contentType = contentType
    }
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Group {
                    if let img = image {
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Image(systemName: placeholderSystemImage)
                            .resizable()
                            .scaledToFit()
                            .padding(14)
                            .opacity(0.85)
                    }
                }
                .frame(width: size, height: size)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .overlay(
                    Circle().strokeBorder(.white.opacity(0.3), lineWidth: 1)
                )
                .shadow(radius: 6)

                if isLoading {
                    ProgressView()
                        .controlSize(.large)
                }
            }

            HStack(spacing: 10) {
                PhotosPicker(
                    selection: $photoItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Label(image == nil ? ViewConstants.ProfilePicturePicker.addPicture : ViewConstants.ProfilePicturePicker.changePicture,
                          systemImage: Constant.Image.ProfilePicturePicker.systemImage)
                        .font(.callout.weight(.semibold))
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(.thinMaterial)
                        .clipShape(Capsule())
                }

                if allowsRemoval, image != nil {
                    Button {
                        image = nil
                    } label: {
                        Label(ViewConstants.ProfilePicturePicker.removeImage, systemImage: Constant.Image.ProfilePicturePicker.systemImage2)
                            .font(.callout.weight(.semibold))
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(.thinMaterial)
                            .clipShape(Capsule())
                    }
                    .tint(.red)
                }
            }
        }
        .onChange(of: photoItem) { _, newItem in
            guard let newItem else { return }
            isLoading = true
            Task {
                defer { isLoading = false }
                if let data = try? await newItem.loadTransferable(type: Data.self),
                   let ui = UIImage(data: data) {
                    image = ui
                } else {
                    image = nil
                }
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(Text(title))
    }
}
