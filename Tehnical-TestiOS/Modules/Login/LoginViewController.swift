//
//  LoginViewController.swift
//  Tehnical-TestiOS
//
//  Created by Dito on 17/10/23.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    let authManager = AuthManager.shared
    let loginView = LoginView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        // Jika data pengguna belum ada di UserDefaults, maka akan membuat data pengguna awal.
        if UserDefaults.standard.string(forKey: "userData") == nil {
            authManager.signup(username: "dami", password: "dito123")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Login"
        
        view.addSubview(loginView)
        setupLayout()
        
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func loginButtonTapped() {
        let username = loginView.usernameTextField.text ?? ""
        let password = loginView.passwordTextField.text ?? ""
        
        if let user = authManager.signin(username: username, password: password) {
            // Login berhasil
            let mealListViewController = MealListViewController()
            navigationController?.pushViewController(mealListViewController, animated: true)
        } else {
            // Login gagal
            let alertController = UIAlertController(title: "Login Error", message: "Username or password is incorrect. Please try again.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
}



class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    func signup(username: String, password: String) {
        let user = User(username: username, password: password)
        let encoder = JSONEncoder()
        if let encodedUser = try? encoder.encode(user) {
            let userString = String(data: encodedUser, encoding: .utf8)
            UserDefaults.standard.set(userString, forKey: "userData")
        }
    }

    func signin(username: String, password: String) -> User? {
        if let userString = UserDefaults.standard.string(forKey: "userData"), let userData = userString.data(using: .utf8) {
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(User.self, from: userData)
                if user.username == username && user.password == password {
                    return user
                }
            } catch {
        
            }
        }
        return nil
    }
}
