//
//  FirebaseImage.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-13.
//

import Foundation
import SwiftUI

let placeholder = UIImage(named: "placeholder.jpg")!

struct FirebaseImage : View {

    init(id: String, viewModel: ProfileViewModel) {
        self.imageLoader = Loader(id)
        self.viewModel = viewModel
    }

    @ObservedObject private var imageLoader : Loader
    @State private var showSheet = false
    @State var isLoading = false
    var viewModel: ProfileViewModel

    @State var imageBinding: UIImage = UIImage()
    
    var image: UIImage? {
        imageLoader.data.flatMap(type(of: imageBinding).init)
    }

    var body: some View {
        if imageLoader.isLoading {
            ProgressView()
        } else {
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(uiImage: image!).resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 140, height: 140)
                        .clipShape(Circle())
                        .padding(4)
                    Image(systemName: "pencil")
                        .font(.system(size: 24))
                        .padding(8)
                        .foregroundColor(.white)
                        .background(.blue)
                        .clipShape(Circle())
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .onTapGesture {
                            showSheet = true
                            isLoading = true
                        }
                }
                if isLoading {
                    ProgressView()
                }
            }
            .sheet(isPresented: $showSheet) {
                ImagePicker(selectedImage: $imageBinding)
            }
            .onChange(of: imageBinding, perform: { image in
                self.isLoading = true
                StorageManager().upload(image: image) { url in
                    viewModel.imageURL = url
                    self.isLoading = false
                }
            })
        }
    }
}
