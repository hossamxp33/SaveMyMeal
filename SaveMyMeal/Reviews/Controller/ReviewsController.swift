//
//  ReviewController.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/23/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit

class ReviewsController : BaseViewController  ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    var rateCell = "rateViewcell"
    var commentCell = "commentViewCell"
    var presenter : ReviewsPresenterProtocol?
    var restID : Int?
    var logo = UIImage()
    var data : reviewViewModel? {
        didSet{
            if data == nil{return}
            
            
            self.userCommentsCountLabel.text = "( \((data?.commentsCount)!) )"
            self.rateLabel.text  = "\( (data?.rateStars)!)"
            self.ratesCountLabel.text = "From \( (data?.rateCount)!) Customer"
            self.commentsRatingsCountLabel.text = "( \((data?.rateCount)! ) )"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratesCollectionView.register(RateView.self, forCellWithReuseIdentifier: rateCell)
        ratesCollectionView.delegate = self
        ratesCollectionView.dataSource = self
        
        userCommentsCollectionView.register(CommentView.self, forCellWithReuseIdentifier: commentCell)
        userCommentsCollectionView.delegate = self
        userCommentsCollectionView.dataSource = self
        if restID != nil {
            presenter?.getReviews(restID: restID!, completion: { (data) in
            self.data = data
            print(data.ratesCounts)
            self.userCommentsCollectionView.reloadData()
            self.ratesCollectionView.reloadData()
        })
        }}
    
    //MARK: - CollectionView -
   
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ratesCollectionView {
           return 5
        }else if collectionView == userCommentsCollectionView{
            return (data?.commentsCount) ?? 0
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ratesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.rateCell, for: indexPath) as! RateView
            cell.rateNumber = indexPath.row + 1
            cell.rateRasio = Double(data?.ratesCounts[indexPath.row] ?? 0) / Double(data?.rateCount ?? 0)
            cell.rateCount = data?.ratesCounts[indexPath.row] ?? 0
            
            return cell
        }else if collectionView == userCommentsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.commentCell, for: indexPath) as! CommentView
            cell.data = data?.comments[indexPath.row]
            return cell
        }else{
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == ratesCollectionView {
            return CGSize(width: CGFloat(collectionView.frame.size.width - 10), height: 13)
        }else if collectionView == userCommentsCollectionView{
            return CGSize(width: CGFloat(collectionView.frame.size.width), height: 130)
        }else{
            return CGSize.zero
        }
    }
    @objc func rateNowClicked(){
       // RateRestaurantRouter.navigateToRateRestaurantController( logo: self.logo, restName: , restID: restID ?? 0, controller: self)
    }
    
    override func setupViews() {
        super.setupViews()
        
        view.addSubview(pageTitleLabel)
        view.addSubview(commentsRatingsCountLabel)
        view.addSubview(ratingContentView)
        ratingContentView.addSubview(ratingInfoStack)
        ratingInfoStack.addArrangedSubview(rateTitleLabel)
        ratingInfoStack.addArrangedSubview(rateLabel)
        ratingInfoStack.addArrangedSubview(ratesCountLabel)
        ratingContentView.addSubview(separatorView)
        //ratingContentView.addSubview(rateNowLabel)
        ratingContentView.addSubview(ratesCollectionView)
        //ratingContentView.addSubview(typeCommentButton)
        
        view.addSubview(userCommentsTitleLabel)
        view.addSubview(userCommentsCountLabel)
        view.addSubview(userCommentsCollectionView)
        
        NSLayoutConstraint.activate([
            
            //pageTitleLabel
            pageTitleLabel.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 20),
            pageTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            commentsRatingsCountLabel.centerYAnchor.constraint(equalTo: pageTitleLabel.centerYAnchor),
            commentsRatingsCountLabel.leadingAnchor.constraint(equalTo: pageTitleLabel.trailingAnchor,constant: 1),
            
            ratingContentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            ratingContentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            ratingContentView.topAnchor.constraint(equalTo: pageTitleLabel.bottomAnchor, constant: 15),
            ratingContentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            ratingInfoStack.widthAnchor.constraint(equalTo: ratingContentView.widthAnchor, multiplier: 0.35),
            ratingInfoStack.heightAnchor.constraint(equalTo: ratingContentView.heightAnchor, multiplier: 0.45),
            ratingInfoStack.topAnchor.constraint(equalTo: ratingContentView.topAnchor, constant: 40),
            ratingInfoStack.leadingAnchor.constraint(equalTo: ratingContentView.leadingAnchor, constant: 0),
            
            separatorView.widthAnchor.constraint(equalToConstant: 0.5),
            separatorView.heightAnchor.constraint(equalTo: ratingInfoStack.heightAnchor,constant:15),
            separatorView.topAnchor.constraint(equalTo: ratingContentView.topAnchor, constant: 30),
            separatorView.leadingAnchor.constraint(equalTo: ratingInfoStack.trailingAnchor,constant: 15),
            
//            rateNowLabel.bottomAnchor.constraint(equalTo: ratingContentView.bottomAnchor, constant: -25),
//            rateNowLabel.centerXAnchor.constraint(equalTo: ratingInfoStack.centerXAnchor),
//
            ratesCollectionView.leadingAnchor.constraint(equalTo: separatorView.trailingAnchor, constant: 15),
            ratesCollectionView.topAnchor.constraint(equalTo: ratingContentView.topAnchor, constant: 40),
            ratesCollectionView.heightAnchor.constraint(equalTo: ratingContentView.heightAnchor),
            ratesCollectionView.widthAnchor.constraint(equalTo: ratingContentView.widthAnchor, multiplier: 0.5),
            
//            typeCommentButton.centerXAnchor.constraint(equalTo: ratesCollectionView.centerXAnchor),
//            typeCommentButton.centerYAnchor.constraint(equalTo: rateNowLabel.centerYAnchor),
            
            userCommentsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 15),
            userCommentsTitleLabel.topAnchor.constraint(equalTo: ratingContentView.bottomAnchor, constant: 15),
            
            userCommentsCountLabel.leadingAnchor.constraint(equalTo: userCommentsTitleLabel.trailingAnchor, constant: 3),
            userCommentsCountLabel.centerYAnchor.constraint(equalTo: userCommentsTitleLabel.centerYAnchor),
            
            userCommentsCollectionView.topAnchor.constraint(equalTo: userCommentsTitleLabel.bottomAnchor, constant: 15),
            userCommentsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            userCommentsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            userCommentsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
            
        ])
    }
    
    private let pageTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "Comments / Ratings"
        label.font = UIConstants.BoldFont.withSize(17)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commentsRatingsCountLabel : UILabel = {
        let label = UILabel()
        label.text = "(0)"
        label.font = UIConstants.BoldFont.withSize(17)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingContentView : UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let ratingInfoStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let rateTitleLabel : UILabel = {
       let label = UILabel()
        label.text = "Appreciation rate"
        label.font = UIConstants.BoldFont.withSize(13)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rateLabel : UILabel = {
        let label = UILabel()
        label.text = "0.0"
        label.font = UIConstants.BoldFont.withSize(35)
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratesCountLabel : UILabel = {
        let label = UILabel()
        label.text = "From 0 Customer"
        label.font = UIConstants.BoldFont.withSize(11)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.25
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rateNowLabel : UILabel = {
        let label = UILabel()
        label.text = "Rate Now"
        label.font = UIConstants.BoldFont.withSize(15)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separatorView : UIView = {
       let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let ratesCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var typeCommentButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1), for: .normal)
        button.titleLabel?.font = UIConstants.BoldFont.withSize(15)
        button.setTitle("Type comment", for: .normal)
        button.backgroundColor = .clear
        
        button.addTarget(self, action: #selector(rateNowClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let userCommentsTitleLabel : UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIConstants.BoldFont.withSize(17)
        label.text = "User comments"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userCommentsCountLabel : UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIConstants.BoldFont.withSize(17)
        label.text = "(0)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userCommentsCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

}
