//
//  PostsDetailViewController.swift
//  ZemogaTest
//
//  Created by andres jaramillo on 18/08/22.
//
//  This template was created by AMJR
//

import Foundation
import UIKit
import Domain

class PostsDetailViewController: UIViewController, PostsDetailViewProtocol{
    
    var presenter: PostsDetailPresenterProtocol?
    lazy var favoriteIconButton: UIBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(favoriteTap))
        return item
    }()
    
    lazy var deleteIconButton: UIBarButtonItem = {
        let item = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteTap))
        return item
    }()
    
    lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "Description"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "User"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "User"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "User"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userPhoneLabel: UILabel = {
        let label = UILabel()
        label.text = "User"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userWebsiteLabel: UILabel = {
        let label = UILabel()
        label.text = "User"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userInfoStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    lazy var commentsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "Comments"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var commentsTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.notifyViewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.notifyViewDidAppear()
    }
    
    var comments: [Comment] = []{
        didSet{
            commentsTableView.reloadData()
        }
    }
    
    func setTitle(){
        title = "Post"
        navigationItem.rightBarButtonItems = [favoriteIconButton, deleteIconButton]
    }
    
    func setupView(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(descriptionTitleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(userTitleLabel)
        
        userInfoStack.addArrangedSubview(userNameLabel)
        userInfoStack.addArrangedSubview(userEmailLabel)
        userInfoStack.addArrangedSubview(userPhoneLabel)
        userInfoStack.addArrangedSubview(userWebsiteLabel)
        view.addSubview(userInfoStack)
        
        view.addSubview(commentsTitleLabel)
        view.addSubview(commentsTableView)
    }
    
    func setupConstrains(){
        NSLayoutConstraint.activate([
            descriptionTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            descriptionTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 8),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            
            userTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userTitleLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            
            userInfoStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            userInfoStack.topAnchor.constraint(equalTo: userTitleLabel.bottomAnchor, constant: 8),
            userInfoStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            
            commentsTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            commentsTitleLabel.topAnchor.constraint(equalTo: userInfoStack.bottomAnchor, constant: 8),
            
            commentsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            commentsTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            commentsTableView.topAnchor.constraint(equalTo: commentsTitleLabel.bottomAnchor, constant: 16),
            commentsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
    
    func setupCommentsTableView() {
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
    }
    
    func setInfo(post: Post) {
        descriptionLabel.text = post.body
        if let favorite = post.favorite{
            favoriteIconButton.image = favorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        }
    }
    
    func setUserInfo(user: User) {
        userNameLabel.text = user.username
        userEmailLabel.text = user.email
        userPhoneLabel.text = user.phone
        userWebsiteLabel.text = user.website
    }
    
    func setComments(comments: [Comment]) {
        self.comments = comments
    }
    
    @objc
    func favoriteTap(){
        presenter?.favoriteTap()
    }
    
    @objc
    func deleteTap(){
        presenter?.deleteTap()
    }
    
    func updateFavoriteState(value: Bool) {
        favoriteIconButton.image = value ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
    }
}

extension PostsDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = comments[indexPath.row].body
        return cell
    }
}
