//
//  HeroImageView.swift
//  SwiftUiApp
//
//  Created by Hamza Jerbi on 9/9/24.
//

import SwiftUI

struct HeroImageView: View {
    let imageURL: String
      
      var body: some View {
          AsyncImage(url: URL(string: imageURL)) { phase in
              switch phase {
              case .success(let image):
                  image
                      .resizable()
                      .scaledToFit()
                      .frame(width: 60, height: 60)
                      .clipShape(Circle())
              case .failure(_):
                  Image(systemName: "xmark.circle")
                      .resizable()
                      .scaledToFit()
                      .frame(width: 60, height: 60)
                      .foregroundColor(.red)
              case .empty:
                  ProgressView()
                      .frame(width: 60, height: 60)
              @unknown default:
                  EmptyView()
              }
          }
      }
  }

  struct HeroImageView_Previews: PreviewProvider {
      static var previews: some View {
          HeroImageView(imageURL: "https://example.com/spiderman.jpg")
              .previewLayout(.sizeThatFits)
      }
  }
