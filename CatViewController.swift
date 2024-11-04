//
//  ViewController.swift
//  CatFact
//
//  Created by Sanjay Kumar Yadav on 04/11/24.
//

import UIKit

class CatViewController: UIViewController {
    private var viewModel: CatViewModel // Dependency Injection

    private var catImageView: UIImageView!
    private var factLabel: UILabel!
    private var activityIndicator: UIActivityIndicatorView!

    // Initializer accepting the ViewModel
    init(viewModel: CatViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI() // Set up the UI components
        fetchCatContent() // Fetch initial cat content
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fetchNewCatContent))
        self.view.addGestureRecognizer(tapGesture)
        self.view.isUserInteractionEnabled = true
    }
    
    @objc private func fetchNewCatContent() {
        fetchCatContent() // Call fetch when image is tapped
    }
    
    private func setupUI() {
        view.backgroundColor = .white

        // Setup Cat Image View
        catImageView = UIImageView()
        catImageView.contentMode = .scaleAspectFit
        catImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(catImageView)

        // Setup Fact Label
        factLabel = UILabel()
        factLabel.textAlignment = .center
        factLabel.numberOfLines = 0
        factLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(factLabel)

        // Setup Activity Indicator
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        catImageView.addSubview(activityIndicator)

        // Layout Constraints
        NSLayoutConstraint.activate([
            catImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            catImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            catImageView.widthAnchor.constraint(equalToConstant: 200),
            catImageView.heightAnchor.constraint(equalToConstant: 200),

            factLabel.topAnchor.constraint(equalTo: catImageView.bottomAnchor, constant: 20),
            factLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            factLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            activityIndicator.centerXAnchor.constraint(equalTo: catImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: catImageView.centerYAnchor)
        ])
    }

    private func fetchCatContent() {
        viewModel.fetchCatContent()
        
        // Binding callbacks from ViewModel to update UI
        viewModel.onFactFetched = { [weak self] fact in
            self?.factLabel.text = fact
        }
        
        viewModel.onImageFetched = { [weak self] imageUrl in
            self?.loadImage(from: imageUrl)
        }
        
        viewModel.onError = { [weak self] errorMessage in
            self?.showError(message: errorMessage)
        }
    }

    private func loadImage(from url: URL) {
        activityIndicator.startAnimating() // Start loading indicator
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async { [weak self] in
                    self?.catImageView.image = image
                    self?.activityIndicator.stopAnimating() // Stop loading indicator when image is loaded
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.activityIndicator.stopAnimating() // Ensure it stops if loading fails
                }
            }
        }
    }
}

extension UIViewController {
     func showError(message: String) {
        let alert = UIAlertController(title: message, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
