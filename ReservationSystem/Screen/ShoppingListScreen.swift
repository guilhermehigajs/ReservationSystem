//
//  ShopListScreen.swift
//  ReservationSystem
//
//  Created by Guilherme Higa on 6/9/25.
//

import SwiftUI

struct ShoppingItem: Identifiable {
    let id = UUID()
    let name: String
    var quantity: Int
}

struct ShoppingListScreen: View {
    @State private var shoppingItems: [ShoppingItem] = [
        ShoppingItem(name: "Napkins", quantity: 0),
        ShoppingItem(name: "Plates", quantity: 0),
        ShoppingItem(name: "Cutlery", quantity: 0),
        ShoppingItem(name: "Toilet Paper", quantity: 0),
        ShoppingItem(name: "Trash Bags", quantity: 0),
        ShoppingItem(name: "Cleaning Spray", quantity: 0),
        ShoppingItem(name: "Straws", quantity: 0),
        ShoppingItem(name: "Ice Bags", quantity: 0)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(ViewConstants.ShoppingList.nameScreen)
                .font(.title2)
                .bold()
                .padding(.horizontal)

            ScrollView {
                VStack(spacing: 12) {
                    ForEach($shoppingItems) { $item in
                        HStack {
                            Text(item.name)
                                .font(.body)

                            Spacer()

                            Stepper(value: $item.quantity, in: 0...99) {
                                Text("\(item.quantity)")
                                    .frame(width: 30, alignment: .trailing)
                            }
                            .labelsHidden()
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        .shadow(radius: 1)
                        .padding(.horizontal)
                    }
                }

                Button(action: {
                    let selectedItems = shoppingItems.filter { $0.quantity > 0 }
                    print(ViewConstants.ShoppingList.generatedList, selectedItems.map { "\($0.name): \($0.quantity)" })
                }) {
                    Text(ViewConstants.ShoppingList.generatedList)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 20)
                        .padding(.horizontal)
                }
            }

            Spacer()
        }
        .padding(.top)
        .background(
            BackgroundGradient(colors: [
                Color(red: 1.0, green: 0.976, blue: 0.769),
                Color(red: 0.773, green: 0.882, blue: 0.647)
            ])
        )
    }
}

#Preview {
    ShoppingListScreen()
}


