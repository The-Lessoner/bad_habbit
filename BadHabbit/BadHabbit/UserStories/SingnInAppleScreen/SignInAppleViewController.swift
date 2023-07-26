//
//  SignInAppleViewController.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 14.07.23.
//

import UIKit
import SnapKit
import AuthenticationServices

protocol SignInDataViewProtocol: AnyObject { }

final class SignInAppleViewController: BaseViewController, SignInDataViewProtocol {
    private lazy var authorizationButton = ASAuthorizationAppleIDButton()
    private lazy var titleLabel = UILabel()
    private lazy var imageLogo = UIImageView()
    private lazy var imageMountains = UIImageView()

    private let presenter: SignInDataPresenterProtocol?

    init(presenter: SignInDataPresenterProtocol) {
        self.presenter = presenter
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performExistingAccountSetupFlows()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension SignInAppleViewController {

    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1.00)
        imageMountains = createImageView(name: "mountains")
        imageLogo = createImageView(name: "logo")
        createAuthorizationButton()
        createTitleLabel()
        setupConstraints()
    }

    private func createImageView(name: String) -> UIImageView {
        let imageName = name
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        return imageView
    }

    private func createTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: Font.SFProDisplayBold.rawValue, size: 24)
        titleLabel.text = String(localized: "appTitle").uppercased()
        titleLabel.textAlignment = .center
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea).inset(TitleLabelConstraints.topOffset)
            make.leading.trailing.equalToSuperview().inset(TitleLabelConstraints.leadingOffset)
        }

        imageLogo.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea)
            make.centerY.equalTo(safeArea).inset(35)
            make.size.equalTo(196)
        }

        imageMountains.snp.makeConstraints { make in
            let multiplier: CGFloat = 445/844
            make.height.equalToSuperview().multipliedBy(multiplier)
            make.bottom.leading.trailing.equalToSuperview()
        }

        authorizationButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeArea).inset(ActionButton.bottomOffset)
            make.height.equalTo(ActionButton.height)
            make.leading.trailing.equalTo(safeArea).inset(ActionButtonConstants.trailingOffset)
        }
    }

    private func createAuthorizationButton() {
        view.addSubview(authorizationButton)
        authorizationButton.layer.cornerRadius = ActionButton.cornerRadius
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
    }

    @objc
    func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]

        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

}

extension SignInAppleViewController: ASAuthorizationControllerDelegate {

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            saveUserInKeychain(userIdentifier)
            //presenter?.authorizationButtonDidTap() Present next Screen
        case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password
            showPasswordCredentialAlert(username: username, password: password)

        default:
            break
        }
    }

    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "com.the-lessoner.BadHabbit", account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }

    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Credential Received", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
    }
}

extension SignInAppleViewController: ASAuthorizationControllerPresentationContextProviding {

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
