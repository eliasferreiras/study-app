//
//  LottieViewController.swift
//  StudyApp
//
//  Created by Elias Ferreira on 16/04/26.
//

import UIKit
import Lottie

class LottieViewController: UIViewController {
    
    // MARK: - Properties
    
    private var isPlaying: Bool = true
    private var group = DispatchGroup()
    private var isAnimating = true
    
    // MARK: - UI
    
    private(set) lazy var lottieView: LottieAnimationView = {
        let view = LottieAnimationView(name: "star")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tap me", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        play()
        
        group.enter()
        
        startAnimation()
        
        notify()
        
        fetch()
    }
    
    // MARK: - Actions
    
    @objc
    func buttonTapped() {
//        isAnimating = false
    }
    
    // MARK: - Functions
    
    private func fetch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            self.isAnimating = false
        }
    }
    
    private func startAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            if let animating = self?.isAnimating, animating {
                self?.startAnimation()
            } else {
                self?.group.leave()
            }
        }
    }
    
    private func notify() {
        group.notify(queue: .main, execute: { [weak self] in
            self?.lottieView.stop()
        })
    }
    
    private func play() {
        lottieView.loopMode = .loop
        lottieView.play() { finished in
            if finished {
                print("Terminou!!!")
            } else {
                print("Não terminou!")
            }
        }
    }
    
    private func pause() {
        lottieView.loopMode = .repeat(1)
    }
}

// MARK: - View Code Protocol
extension LottieViewController: ViewCode {
    func setupViews() {
        view.backgroundColor = .systemBackground
    }
    
    func setupHierachy() {
        view.addSubview(lottieView)
        view.addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            lottieView.widthAnchor.constraint(equalToConstant: 200),
            lottieView.heightAnchor.constraint(equalToConstant: 200),
            lottieView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lottieView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.topAnchor.constraint(equalTo: lottieView.bottomAnchor, constant: 40),
            button.centerXAnchor.constraint(equalTo: lottieView.centerXAnchor)
        ])
    }
}
