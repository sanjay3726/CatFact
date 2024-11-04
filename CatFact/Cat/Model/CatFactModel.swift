//
//  CatFactModel.swift
//  CatFact
//
//  Created by Sanjay Kumar Yadav on 04/11/24.
//


struct CatFact: Decodable {
    let data: [String]
}

struct CatImage: Decodable {
    let url: String
    let id: String
    let width: Int
    let height: Int
}
