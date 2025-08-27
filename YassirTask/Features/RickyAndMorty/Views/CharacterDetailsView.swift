//
//  CharacterDetailsView.swift
//  YassirTask
//
//  Created by Ahmed Salaheldin on 26/08/2025.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
                        ZStack(alignment: .topLeading) {
                AsyncImage(url: URL(string: character.image)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 300)
                            .frame(maxWidth: .infinity)
                    case .success(let img):
                        img
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300)
                            .frame(maxWidth: .infinity)
                            .clipped()
                    case .failure:
                        Image(systemName: "person.fill.questionmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.gray)
                            .frame(height: 300)
                            .frame(maxWidth: .infinity)
                    @unknown default:
                        EmptyView()
                    }
                }
                .clipShape(RoundedCorner(radius: 30, corners: [.bottomLeft, .bottomRight, .topLeft, .topRight]))
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .padding(10)
                        .background(Circle().fill(Color.white))
                        .shadow(radius: 2)
                }
                .padding(.leading, 16)
                .padding(.top, 50)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(character.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        
                    
                    Spacer()
                    
                    Text(character.status.capitalized)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(Color(red:97/255, green:203/255, blue:244/255))
                        )
                        .foregroundColor(.black)
                    
                }
                
                Text("\(character.species) • ")
                    .font(.subheadline)
                    .foregroundColor(Color(red: 80/255, green: 73/255, blue: 116/255))
                    .fontWeight(.semibold)
                + Text(character.gender.capitalized)
                    .font(.subheadline)
                    .foregroundColor(Color(red: 130/255, green: 124/255, blue: 156/255))
                    .fontWeight(.semibold)
                
                Text("Location : ")
                    .fontWeight(.semibold)
                + Text(character.location.name)
                    .fontWeight(.regular)

            }
            .padding()
            
            Spacer()
        }
        .ignoresSafeArea(edges: .top)
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = 0.0
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
