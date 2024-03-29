//
//  PhotoAlbumView.swift
//  ImagierQuizz
//
//  Created by m2sar on 13/10/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import Foundation
import UIKit

class PhotoAlbumView: UIView
{
    
    let MIN_CMPT_IMG = 1;
    let MAX_CMPT_IMG = 20;
 
    let HORIZONTAL_GUIDELINE:CGFloat = 30;
    let VERTICAL_GUIDELINE :CGFloat = 5;
    
    let IMAGE_NAME_PREFIX = "photo-";
    let IMAGE_NAME_SUFIX = ".jpg";
    
    let IMGS_TXTS:[String] = [
        "Machu Pichu",
        "Oxford",
        "Dresde",
        "Chichen Itza",
        "Kiôtô",
        "Gizeh",
        "Près d'Edimbourg",
        "Cordoue",
        "Seville",
        "Grenade",
        "Venise",
        "Venise",
        "Venise",
        "Paris",
        "Paris",
        "Tiddis",
        "Washington State",
        "NGC 6302",
        "New York",
        "La Terre",
    ];
    
    var cmptImg : Int!;
    
    var curImageCmpt:Int=1;
    var curImage : UIImage!;
    
    var myToolBar : UIView!;
    var sliderSize: UISlider!;
    var zoomScaleView:UIVisualEffectView!;
    var myImageView:UIImageView!;
    var myScrollView:UIScrollView!;
    var btnPrev : UIButton!;
    var btnNext :UIButton!;
    var imgText :UILabel!;
    var imgZoomScaleLabel:UILabel!;
    
    override init(frame: CGRect)
    {
        super.init(frame: frame);
        
        let effetH = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis);
        let effetV = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongHorizontalAxis);
        
        effetH.minimumRelativeValue = -20;
        effetH.maximumRelativeValue = 20;
        
        effetV.minimumRelativeValue = -20;
        effetV.maximumRelativeValue = 20;
        
        self.cmptImg = self.MIN_CMPT_IMG;
        
        self.imgZoomScaleLabel = UILabel();
        self.imgZoomScaleLabel.textAlignment = .Center;
        self.imgZoomScaleLabel.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0);
        
        self.myToolBar = UIView();
        self.zoomScaleView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight));
        self.myToolBar.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1);
        
        self.btnPrev = UIButton();
        self.btnNext = UIButton();
        self.imgText = UILabel();
        
        self.btnPrev.setTitle("<<<", forState: .Normal);
        self.btnNext.setTitle(">>>", forState: .Normal);
        
        self.btnPrev.setTitleColor(UIColor.blueColor(), forState: .Normal);
        self.btnNext.setTitleColor(UIColor.blueColor(), forState: .Normal);
        
        self.imgText.textAlignment = .Center;
        self.imgText.textColor = UIColor.blackColor();
        self.myImageView=UIImageView();
        self.myImageView.addMotionEffect(effetH)
        self.myImageView.addMotionEffect(effetV)
        
        self.myScrollView = UIScrollView();
        self.myScrollView.addSubview(self.myImageView);

        self.myScrollView.minimumZoomScale=0.05;
        self.myScrollView.maximumZoomScale=1;

        self.sliderSize = UISlider();
        self.sliderSize.maximumValue = 100;
        self.sliderSize.minimumValue = 0;
        
        self.setElementsSize(frame);
        
        self.addSubview(self.myToolBar);
        self.addSubview(self.btnPrev)
        self.addSubview(self.btnNext)
        self.addSubview(self.imgText)
        self.addSubview(self.myScrollView);
        self.addSubview(self.zoomScaleView);
        self.addSubview(self.imgZoomScaleLabel)
        self.addSubview(self.sliderSize);
        
        self.curImage = UIImage(named: self.getImgName(self.cmptImg));
        self.myImageView.image = self.curImage;
        self.imgText.text = self.IMGS_TXTS[self.cmptImg-1];
        
        self.myImageView.frame = CGRectMake(0, 0, self.curImage.size.width, self.curImage.size.height);
        self.myScrollView.contentSize = self.curImage.size;
    }

    func setElementsSize(frame:CGRect)
    {
        self.frame.size = frame.size;
        
        self.myToolBar.frame = CGRect(
            x: self.VERTICAL_GUIDELINE,
            y: self.HORIZONTAL_GUIDELINE,
            width: frame.width-(2*self.VERTICAL_GUIDELINE),
            height: 50
        );
        
        self.btnPrev.frame = CGRect(
            x: self.VERTICAL_GUIDELINE,
            y: self.HORIZONTAL_GUIDELINE,
            width: 50,
            height: self.myToolBar.frame.height
        );
        
        self.btnNext.frame = CGRect(
            x: frame.width - (50 + self.VERTICAL_GUIDELINE),
            y: self.HORIZONTAL_GUIDELINE,
            width: 50,
            height: self.myToolBar.frame.height
        );
        
        self.imgText.frame = CGRect(
            x: self.VERTICAL_GUIDELINE+self.btnPrev.frame.width,
            y: self.HORIZONTAL_GUIDELINE,
            width: self.myToolBar.frame.width-(self.btnPrev.frame.width+self.btnNext.frame.width),
            height: self.myToolBar.frame.height
        );
        
        self.zoomScaleView.frame = CGRect(
            x: self.VERTICAL_GUIDELINE ,
            y: self.HORIZONTAL_GUIDELINE + self.myToolBar.frame.height,
            width: self.myToolBar.frame.width,
            height: 20
        );
        
        self.imgZoomScaleLabel.frame = CGRect(
            x: self.VERTICAL_GUIDELINE,
            y: self.myToolBar.frame.height+self.HORIZONTAL_GUIDELINE,
            width: frame.width,
            height: self.zoomScaleView.frame.height
        );
        
        self.myScrollView.frame = CGRect(
            x: self.VERTICAL_GUIDELINE,
            y: self.HORIZONTAL_GUIDELINE + self.myToolBar.frame.height,
            width: self.myToolBar.frame.width,
            height: frame.height-self.myToolBar.frame.height-(2*self.HORIZONTAL_GUIDELINE)
        );
        
        self.sliderSize.frame = CGRect(
            x: self.VERTICAL_GUIDELINE,
            y: frame.height - self.HORIZONTAL_GUIDELINE - 40,
            width: self.myToolBar.frame.width,
            height: 40
        );
    }
    
    func getImgName(cmpt : Int)->String{
        return self.IMAGE_NAME_PREFIX + (cmpt < 10 ? "0" : "") + String(cmpt) + self.IMAGE_NAME_SUFIX;
    }

    func onTouchNextImg()
    {
        self.cmptImg = (self.cmptImg + 1 >= self.MAX_CMPT_IMG ? self.MIN_CMPT_IMG : self.cmptImg + 1);
        self.updateImg();
    }
    
    func onTouchPrevImg()
    {
        self.cmptImg = (self.cmptImg-1 < self.MIN_CMPT_IMG ? self.MAX_CMPT_IMG: self.cmptImg-1);
        self.updateImg();
    }
    
    func updateImg()
    {
        self.myScrollView.setZoomScale(1, animated: false);
        
        self.curImage = UIImage(named: self.getImgName(self.cmptImg));
        self.myImageView.image = self.curImage;
        self.imgText.text = self.IMGS_TXTS[self.cmptImg-1];
    
        self.myImageView.frame = CGRectMake(0, 0, self.curImage.size.width, self.curImage.size.height);
        self.myScrollView.contentSize = self.curImage.size;
        
        if(UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
            self.myScrollView.setZoomScale(0.10, animated: true);
        } else {
            self.myScrollView.setZoomScale(0.20, animated: true);
        }
        
        self.updateAll(self.myScrollView.zoomScale);
    }
    
    func onSliderSizeChange()
    {
        self.myScrollView.setZoomScale(CGFloat(self.sliderSize.value/100),animated: true);
    }
    
    func onPinch(scale:CGFloat ){
        self.updateAll(scale)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateAll(scale:CGFloat ){
        self.sliderSize.value = Float(scale*100);
        self.imgZoomScaleLabel.text = String(Int(self.sliderSize.value)) + " %";
    }
}
