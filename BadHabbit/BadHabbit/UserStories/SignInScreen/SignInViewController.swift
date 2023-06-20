//
//  SignInViewController.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 17.06.23.
//

import UIKit
import AuthenticationServices

class SignInViewController: UIViewController {
    private let userIdentifierLabel = UILabel()
    private  let givenNameLabel = UILabel()
    private let familyNameLabel = UILabel()
    private let emailLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAuthorizationButton()
    }
}

extension SignInViewController {
    private func setupAuthorizationButton() {
        view.backgroundColor = .white
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        authorizationButton.center = view.center
        view.addSubview(authorizationButton)
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
    }

    private func setupUserLables() {
        userIdentifierLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userIdentifierLabel)
        NSLayoutConstraint.activate([
            userIdentifierLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15.0),
            userIdentifierLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15.0),
            userIdentifierLabel.heightAnchor.constraint(equalToConstant: 50.0),
            userIdentifierLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0)
        ])

        givenNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(givenNameLabel)
        NSLayoutConstraint.activate([
            givenNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15.0),
            givenNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15.0),
            givenNameLabel.heightAnchor.constraint(equalToConstant: 50.0),
            givenNameLabel.topAnchor.constraint(equalTo: userIdentifierLabel.bottomAnchor, constant: 15.0)
        ])

        familyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(familyNameLabel)
        NSLayoutConstraint.activate([
            familyNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15.0),
            familyNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15.0),
            familyNameLabel.heightAnchor.constraint(equalToConstant: 50.0),
            familyNameLabel.topAnchor.constraint(equalTo: givenNameLabel.bottomAnchor, constant: 15.0)
        ])

        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailLabel)
        NSLayoutConstraint.activate([
            emailLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15.0),
            emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15.0),
            emailLabel.heightAnchor.constraint(equalToConstant: 50.0),
            emailLabel.topAnchor.constraint(equalTo: familyNameLabel.bottomAnchor, constant: 15.0)
        ])

    }

    private func showUserData(userIdentifier: String, givenName: String?, familyName: String?, email: String?) {
        setupUserLables()
        userIdentifierLabel.text = userIdentifier
        givenNameLabel.text = givenName
        familyNameLabel.text = familyName
        emailLabel.text = email
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
}

extension SignInViewController: ASAuthorizationControllerDelegate {

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            showUserData(userIdentifier: userIdentifier, givenName: fullName?.givenName, familyName: fullName?.familyName, email: email)
        case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password
            showPasswordCredentialAlert(username: username, password: password)

        default:
            break
        }
    }

    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Credential Received", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
