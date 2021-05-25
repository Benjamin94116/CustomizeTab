//
//  ViewController.swift
//  Segmented
//
//  Created by Kadjo Anoh on 4/11/21.
//

import UIKit
private let identifier = "cell"

class ViewController: UIViewController {
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.height, height: (view.frame.height))
        containerView.backgroundColor = .yellow
        return containerView
    }()
    
    lazy var redVC: RedVC = {
        // Instantiate View Controller
        var viewController = RedVC()
        // Add View Controller as Child View Controller
        self.addChild(viewController)
        return viewController
    }()
    
    lazy var blueVC: BlueVC = {
        // Instantiate View Controller
        var viewController = BlueVC()
        // Add View Controller as Child View Controller
        self.addChild(viewController)
        return viewController
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
        setupView()
    }
    

    func setUpViews(){
        //Add custom bar to main VC
        let paddedStackView = UIStackView(arrangedSubviews: [menuBar])
        view.addSubview(paddedStackView)
        paddedStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 45)
        paddedStackView.isLayoutMarginsRelativeArrangement = false
        
        let stackView = UIStackView(arrangedSubviews: [
            paddedStackView, containerView
        ])
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
}

    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    func setupView() {
        navigationController?.navigationBar.isHidden = true
        //Scroll to first tab when view is load
        scrollToMenuIndex(menuIndex: 0)
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = menuIndex
        switch indexPath {
                case 0:
                    remove(asChildViewController: blueVC)
                    add(asChildViewController: redVC)
                case 1:
                    remove(asChildViewController: redVC)
                    add(asChildViewController: blueVC)
                default:
                    break
                }
    }
}
