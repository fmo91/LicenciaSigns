//
//  ContentView.swift
//  LicenciaSigns
//
//  Created by Fernando Ortiz on 04/01/2023.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var viewModel = ContentViewModel()
  
  var body: some View {
    VStack(alignment: .center) {
      if let imageAssetName = viewModel.imageAssetName {
        VStack {
          Spacer()
          Image(imageAssetName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.main.bounds.width - 40)
          Spacer()
        }
      }
      Spacer()
      Button(action: {
        viewModel.produceNextImage()
      }) {
        Text(viewModel.buttonTitle)
          .font(.headline)
          .frame(width: 400)
          .padding()
      }
    }
  }
}

final class ContentViewModel: ObservableObject {
  private static let maxNumberOfImages = 196
  
  @Published var imageAssetName: String?
  var buttonTitle: String {
    if isWaitingForSolution {
      return "VER SOLUCIÓN"
    } else {
      return "SIGUIENTE SEÑAL"
    }
  }
  
  private var isWaitingForSolution = false
  
  init() {
    produceNextImage()
  }
  
  func produceNextImage() {
    if isWaitingForSolution {
      imageAssetName = getNextQuizResultImage()
    } else {
      imageAssetName = getNextQuizImage()
    }
    
    isWaitingForSolution.toggle()
  }
  
  private func getNextQuizImage() -> String? {
    return (1...Self.maxNumberOfImages).randomElement()?.description
  }
  
  private func getNextQuizResultImage() -> String? {
    guard let imageAssetName = imageAssetName else {
      return nil
    }
    
    return "\(imageAssetName)r"
  }
}
