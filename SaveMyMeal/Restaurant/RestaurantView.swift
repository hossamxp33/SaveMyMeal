//
//  RestaurantView_.swift
//  SaveMyMeal
//
//  Created by Hadeer Kamel on 4/18/19.
//  Copyright © 2019 PeeksSolutions. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
class RestaurantView : UIView {
    var logoPhotoLoaded : UIImage?
    var data : RestaurantViewModel?{
        didSet {
            if data == nil {return}
            //distance
            let restLocation = CLLocation(latitude: data?.resLat ?? 0.0, longitude: data?.resLong ?? 0.0)
            
            let distanceInKilometers = UserData.location.distance(from: restLocation) / 1000.00
            let roundedDistanceKilometers = String(Int(round( distanceInKilometers))) + "Km"
            self.distanceLabel.text = roundedDistanceKilometers
            
            
            //bgimage
            self.BGImage.loadImageUsingUrlString(data!.coverPhoto )
            //logoimage
            let customImageView = CustomImageView()
            customImageView.loadImageUsingUrlStringToUIImage(data!.logo){ image in
                self.logoImage.image = image
            }
            rateView.rating = data!.ratingStars
            rateView.text = "(\(data!.ratingCount))"
            priceLabel.text = "\(data!.price) L.E"
            oldPriceLabel.text = "\(data!.lastPrice) L.E"
            statusImage.image = (data!.amount == 0) ? #imageLiteral(resourceName: "red-circle") : #imageLiteral(resourceName: "greenOval")
            amountLabel.text = (data!.amount == 0) ? "Sold out" : "\(data!.amount) Left"
            
            titleLabel.text = data!.name
            timeLabel.text = "\(data!.startTimeJoined) - \(data!.endTimeJoined)"
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
       
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Actions -
    @objc func rateViewClicked(sender: UITapGestureRecognizer? = nil){
        //router.navigateToRatingsView
        //print("rateContntView clicked")
        if let parentController =  self.parentViewController {
            ReviewsRouter.navigateToReviewsController(  logo: self.logoImage.image ?? #imageLiteral(resourceName: "retaurantLogo"), restID: (self.data?.id)!, controller: parentController)
        }
    }
    @objc func locationViewClicked(sender: UITapGestureRecognizer? = nil){
        // print("yes i'm clicked")
        
        let lat = data?.resLat ?? 0.0
        let long = data?.resLong ?? 0.0
        
        
        var targetURL = URL(string: "comgooglemaps://?q=\(lat),\(String(describing: long))")!
        if !UIApplication.shared.canOpenURL(targetURL ) {
            targetURL = URL(string: "http://maps.apple.com/?q=\(String(describing: lat)),\(long)")!
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(targetURL)
        } else {
            UIApplication.shared.openURL(targetURL)
        }
        
    }
    //SetupViews
     func setupViews() {
            self.backgroundColor = .clear
        
            self.addSubview(mainView)
            mainView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
            mainView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
            mainView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
            
            mainView.addSubview(BGImage)
            BGImage.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
            BGImage.leftAnchor.constraint(equalTo: mainView.leftAnchor).isActive = true
            BGImage.rightAnchor.constraint(equalTo: mainView.rightAnchor).isActive = true
            BGImage.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.7).isActive = true
            
            BGImage.addSubview(rateContentView)
            rateContentView.topAnchor.constraint(equalTo: BGImage.topAnchor,constant: 20).isActive = true
            rateContentView.rightAnchor.constraint(equalTo: BGImage.rightAnchor,constant: -10).isActive = true
            rateContentView.heightAnchor.constraint(equalToConstant: 20).isActive = true
            rateContentView.widthAnchor.constraint(equalToConstant: 100).isActive = true
            
            rateContentView.addSubview(rateView)
            rateView.centerXAnchor.constraint(equalTo: rateContentView.centerXAnchor).isActive = true
            rateView.centerYAnchor.constraint(equalTo: rateContentView.centerYAnchor).isActive = true
            
            BGImage.addSubview(locationView)
            locationView.topAnchor.constraint(equalTo: BGImage.topAnchor, constant: 20).isActive = true
            locationView.leftAnchor.constraint(equalTo: BGImage.leftAnchor, constant: 10).isActive = true
            locationView.heightAnchor.constraint(equalToConstant: 25).isActive = true
          //  locationView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
            locationView.addSubview(locationIconImage)
            //locationIconImage.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 1).isActive = true
            locationIconImage.centerYAnchor.constraint(equalTo: locationView.centerYAnchor).isActive = true
            locationIconImage.leftAnchor.constraint(equalTo: locationView.leftAnchor, constant: 1).isActive = true
            locationIconImage.heightAnchor.constraint(equalToConstant: 15).isActive = true
            locationIconImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
            
            locationView.addSubview(distanceLabel)
            // distanceLabel.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 1).isActive = true
            distanceLabel.centerYAnchor.constraint(equalTo: locationView.centerYAnchor).isActive = true
            distanceLabel.leftAnchor.constraint(equalTo: locationIconImage.rightAnchor, constant: 3).isActive = true
            distanceLabel.rightAnchor.constraint(equalTo: locationView.rightAnchor, constant: -1).isActive = true
       
        
            //ProInfoView
            BGImage.addSubview(infoContentView)
            infoContentView.heightAnchor.constraint(equalToConstant: 35).isActive = true
            infoContentView.widthAnchor.constraint(equalTo: BGImage.widthAnchor).isActive = true
            infoContentView.centerXAnchor.constraint(equalTo: BGImage.centerXAnchor).isActive = true
            infoContentView.bottomAnchor.constraint(equalTo: BGImage.bottomAnchor).isActive = true
        
            BGImage.addSubview(logoImage)
            logoImage.bottomAnchor.constraint(equalTo: infoContentView.bottomAnchor,constant: 10).isActive = true
            logoImage.heightAnchor.constraint(equalTo: infoContentView.heightAnchor, multiplier: 2.0).isActive = true
            logoImage.widthAnchor.constraint(equalTo: logoImage.heightAnchor).isActive = true
            logoImage.centerXAnchor.constraint(equalTo: BGImage.centerXAnchor).isActive = true
        
            infoContentView.addSubview(priceLabel)
            priceLabel.centerYAnchor.constraint(equalTo: infoContentView.centerYAnchor).isActive = true
            priceLabel.rightAnchor.constraint(equalTo: infoContentView.rightAnchor,constant: -10).isActive = true
        
            infoContentView.addSubview(oldPriceLabel)
            oldPriceLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor).isActive = true
            oldPriceLabel.rightAnchor.constraint(equalTo: priceLabel.leftAnchor,constant: -3).isActive = true
            oldPriceLabel.leftAnchor.constraint(greaterThanOrEqualTo: logoImage.rightAnchor).isActive = true
        
            oldPriceLabel.addSubview(oldPrice_RedLine)
            oldPrice_RedLine.heightAnchor.constraint(equalToConstant: 0.7).isActive = true
            oldPrice_RedLine.widthAnchor.constraint(equalTo: oldPriceLabel.widthAnchor).isActive = true
            oldPrice_RedLine.centerYAnchor.constraint(equalTo: oldPriceLabel.centerYAnchor).isActive = true
            oldPrice_RedLine.centerXAnchor.constraint(equalTo: oldPriceLabel.centerXAnchor).isActive = true
        
        
            infoContentView.addSubview(statusImage)
            statusImage.heightAnchor.constraint(equalToConstant: 15).isActive = true
            statusImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
            statusImage.leftAnchor.constraint(equalTo: infoContentView.leftAnchor, constant: 10).isActive = true
            statusImage.centerYAnchor.constraint(equalTo: infoContentView.centerYAnchor).isActive = true
            
            infoContentView.addSubview(amountLabel)
            amountLabel.leftAnchor.constraint(equalTo: statusImage.rightAnchor, constant: 5).isActive = true
            amountLabel.centerYAnchor.constraint(equalTo: infoContentView.centerYAnchor).isActive = true
            
        
            
            mainView.addSubview(titleLabel)
            titleLabel.topAnchor.constraint(equalTo: BGImage.bottomAnchor, constant: 10).isActive = true
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            
            mainView.addSubview(timeLabel)
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
            timeLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            timeLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor).isActive = true
        
            
        }
        let mainView : UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 5
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOffset = .zero
            view.layer.shadowOpacity = 0.5
            view.layer.shadowRadius = 3
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        //BGimage
        
        let BGImage : CustomImageView = {
            let imageView = CustomImageView()
            imageView.image = #imageLiteral(resourceName: "backgroung")
            imageView.isUserInteractionEnabled = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        //rateContentView
        lazy var rateContentView : UIView = {
            let view = UIView()
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rateViewClicked)))

            view.backgroundColor = UIConstants.blackTransparentColor
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        //rate view
        let rateView : CosmosView = {
            let rateView = CosmosView()
            rateView.backgroundColor = .clear
            rateView.semanticContentAttribute = .forceRightToLeft
            rateView.text = "(342)"
            rateView.textSize = 9
            rateView.textColor = .white
            rateView.rating = 5
            rateView.settings.updateOnTouch = false
            rateView.settings.filledImage = #imageLiteral(resourceName: "FilledStar")
            rateView.settings.emptyImage = #imageLiteral(resourceName: "EmptyStar")
            rateView.settings.starSize = 12
            rateView.settings.starMargin = 0
            rateView.translatesAutoresizingMaskIntoConstraints = false
            return rateView
        }()
        //Location View
        lazy var locationView : UIView = {
            let view = UIView()
            view.backgroundColor = UIConstants.blackTransparentColor
            view.isUserInteractionEnabled = true
            
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(locationViewClicked)))
            
            
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        //LocationIcon
        let locationIconImage : UIImageView = {
            let imageView = UIImageView()
            imageView.image = #imageLiteral(resourceName: "location-pin")
            imageView.tintColor = .white
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        //LocationLabel
        let distanceLabel : UILabel = {
            let label = UILabel()
            label.text = "1Km"
            label.textColor = .white
            label.font = UIConstants.LightFont.withSize(13)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        //view
        let infoContentView : UIView = {
            let view = UIView()
            view.backgroundColor = UIConstants.blackTransparentColor
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        //price label
        let priceLabel : UILabel = {
            let label = UILabel()
            label.text = "80 L.E"
            label.textColor = .white
            label.font = UIConstants.LightFont.withSize(15)
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.2
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
        let oldPriceLabel : UILabel = {
            let label = UILabel()
            label.text = "80 L.E"
            label.textColor = .white
            label.font = UIConstants.LightFont.withSize(13)
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.2
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
        let oldPrice_RedLine : UIView = {
            let view = UIView()
            view.backgroundColor = .red
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
        //status image
        let statusImage : UIImageView = {
            let imageView = UIImageView()
            imageView.image = #imageLiteral(resourceName: "greenOval")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        //amount
        let amountLabel : UILabel = {
            let label = UILabel()
            label.text = "10 left"
            label.textColor = .white
            label.font = UIConstants.LightFont.withSize(15)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        //logo image
        let logoImage : RoundedImageView = {
            let imageView = RoundedImageView()
            imageView.image = #imageLiteral(resourceName: "retaurantLogo")
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        //titleLabel
        let titleLabel : UILabel = {
            let label = UILabel()
            label.text = "Wok House Sushi Bar & Asian food"
            label.textColor = .black
            label.textAlignment = .center
            label.font = UIConstants.BoldFont.withSize(15)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        //timeLabel
        let timeLabel : UILabel = {
            let label = UILabel()
            label.text = "8:00 - 9:00"
            label.textColor = .lightGray
            label.textAlignment = .center
            label.font = UIConstants.BoldFont.withSize(14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    
}
