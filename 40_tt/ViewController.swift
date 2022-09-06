

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let passwordButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "password")
        button.setImage(buttonImage, for: .normal)
        return button
    }()
    
    private let tableSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .medium
        spinner.color = .black
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        layout.scrollDirection = .vertical
        return collectionView
    }()
    
    private let listOfDoorsLabel: UILabel = {
        let label = UILabel()
        label.text = "My doors"
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        return label
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.font = UIFont.systemFont(ofSize: 35, weight: UIFont.Weight.semibold)
        return label
    }()
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "home")
        return imageView
    }()
    
    private let appNameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "appName")
        return imageView
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "settings")
        button.setImage(buttonImage, for: .normal)
        button.layer.cornerRadius = 13
        button.layer.borderColor = CGColor(red: 225/255, green: 232/255, blue: 232/255, alpha: 1)
        button.layer.borderWidth = 1
        return button
    }()
    
    // MARK: - ViewController LifeCicle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupCollectionView()
    }

    // MARK: - Actions
    
    @objc func settingsButtonTapped() {
        makeAlert(alertTitle: "Settings", message: "Setting actions", buttonTitle: "Ok")
    }
    
    @objc func passwordButtonTapped() {
        makeAlert(alertTitle: "Password", message: "Password actions", buttonTitle: "Ok")
    }
    
    // MARK: - Private
    
    private func setupHeader() {
        view.backgroundColor = .white
        
        view.addSubview(passwordButton)
        passwordButton.addTarget(self, action: #selector(passwordButtonTapped), for: .touchUpInside)
        passwordButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(46)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        view.addSubview(tableSpinner)
        tableSpinner.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(550)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(appNameImageView)
        appNameImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(77)
        }
        
        view.addSubview(settingsButton)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        settingsButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.centerY.equalTo(appNameImageView)
            make.size.equalTo(CGSize(width: 45, height: 45))
        }
        
        view.addSubview(mainImageView)
        mainImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(-4)
            make.top.equalTo(settingsButton.snp_bottomMargin)
        }
        
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(appNameImageView).inset(75)
        }
        
        view.addSubview(listOfDoorsLabel)
        listOfDoorsLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(25)
            make.top.equalTo(mainImageView.snp_bottomMargin).inset(-31)
        }
    }
    
    private func makeAlert(alertTitle: String, message: String, buttonTitle: String) {
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in }
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell else { return }
        cell.changeStatus()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.width/3)
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    private func setupCollectionView() {
        tableSpinner.startAnimating()
        DispatchQueue.main.async {
            Thread.sleep(forTimeInterval: 2)
            self.view.addSubview(self.collectionView)
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.collectionView.showsVerticalScrollIndicator = false
            self.collectionView.snp.makeConstraints { make in
                make.top.equalTo(self.listOfDoorsLabel.snp_bottomMargin).inset(-30)
                make.left.equalToSuperview().inset(16)
                make.right.equalToSuperview().inset(16)
                make.bottom.equalTo(self.passwordButton.snp_topMargin).inset(-10)
            }
            self.tableSpinner.stopAnimating()
            self.tableSpinner.isHidden = true
        }
    }
}

