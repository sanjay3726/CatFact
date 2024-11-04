//
//  CatViewModel.swift
//  CatFact
//
//  Created by Sanjay Kumar Yadav on 04/11/24.
//


import Foundation

class CatViewModel {
    var isLoadingImage: Bool = false
    var onFactFetched: ((String) -> Void)?
    var onImageFetched: ((URL) -> Void)?
    var onError: ((String) -> Void)?
    private let apiService: CatAPIServiceProtocol // Dependency on the protocol

    init(apiService: CatAPIServiceProtocol) {
        self.apiService = apiService
    }

    func fetchCatContent() {
        isLoadingImage = true
        
        apiService.fetchCatFact { [weak self] result in
            switch result {
            case .success(let fact):
                DispatchQueue.main.async {
                    self?.onFactFetched?(fact)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.onError?(error.localizedDescription)
                }
            }
        }

        apiService.fetchCatImage { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoadingImage = false
                switch result {
                case .success(let imageUrl):
                    self?.onImageFetched?(imageUrl)
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
}

