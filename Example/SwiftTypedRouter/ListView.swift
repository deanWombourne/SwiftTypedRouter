//
//  ListView.swift
//  SwiftTypedRouter_Example
//
//  Created by Sam Dean on 03/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI

import struct SwiftTypedRouter.Path
import SwiftTypedRouter

extension Template {

    static let productList = TemplateFactory.start().path("list").placeholder("category", String.self).template()
}

extension Path {

    static func productList(category: String) -> Path { Template.productList.path(category) }
}

struct ListView: View {

    let clients = nameList

    var body: some View {
        List(self.clients, id:\.self) {
            ListCell(client: $0)
        }.navigationBarTitle("Client List")
    }
}

struct ListCell: View {

    let client: String

    var body: some View {
        Text(self.client)
    }
}

private let nameList: [String] = [
    "Ehsan Donovan",
    "Kimberly Reeves",
    "Honey Fox",
    "Kamron Shah",
    "Hamaad Kinney",
    "Ayaz Charles",
    "Ralphy Glass",
    "Tanisha Hubbard",
    "Rhiana Lowery",
    "Shona Haney",
    "Dylan Flynn",
    "Harun Holden",
    "Rudi Costa",
    "Gilbert Penn",
    "Colton Arroyo",
    "Kalum Bonner",
    "Evie-Mai Ramirez",
    "Mikail Johns",
    "Toni Melton",
    "Tracy Rangel",
    "Nayan Ashton",
    "Monty Robles",
    "Albie Bravo",
    "Mahir Suarez",
    "Elif Gilmore",
    "Roy Slater",
    "Christine Cornish",
    "Tess Cruz",
    "Barnaby Delgado",
    "Jozef Pratt",
    "Sullivan Merritt",
    "Jagdeep Contreras",
    "Marguerite Palmer",
    "Jules Stein",
    "Tulisa Vinson",
    "Carol Buchanan",
    "Saad Morin",
    "Gurveer Beltran",
    "Elleanor Molina",
    "Antoinette Webber",
    "Lukas Bauer",
    "Shayne Muir",
    "Lilly-May Head",
    "Kaylie Weiss",
    "Jace Wagstaff",
    "Holli Harding",
    "Mehak Espinoza",
    "Allan Grimes",
    "Aiden Chadwick",
    "Saoirse Rowe"
]
