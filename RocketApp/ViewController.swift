//
//  ViewController.swift
//  RocketApp
//
//  Created by IgorGalimski on 20/11/2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController
{
    @IBOutlet weak var spaceShipImage: UIImageView!
    @IBOutlet weak var mainButton: UIButton!
    
    var avPlayer: AVAudioPlayer?
    
    var currentSpaceShipStatus: SpaceShipStatus = .Ready
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        SetLanchButtonAppearance()
        InitAudioPlayer()
    }
    
    func InitAudioPlayer()
    {
        guard let backgroundAudioTrack = Bundle.main.url(forResource: "spaceBackground",
                                                         withExtension: "wav")
        else
        {
            return
        }
        
        do
        {
            avPlayer = try AVAudioPlayer(contentsOf: backgroundAudioTrack)
            avPlayer?.play()
            avPlayer?.volume = 0.2
        }
        catch
        {
            
        }
    }
    
    func SetLanchButtonAppearance()
    {
        mainButton.setTitle("Lanch", for: .normal)
        mainButton.layer.cornerRadius = 25
    }
    
    func LaunchRocket(yPoint: CGFloat)
    {
        mainButton.isEnabled = false
        
        UIView.animate(withDuration: 1.25,
                       delay: 0.25,
                       options: UIView.AnimationOptions.curveEaseIn)
        {
            self.spaceShipImage.transform = CGAffineTransform(translationX: .zero, y: yPoint)
        }
    completion:
        {
            [unowned self] (complete) in
            if complete
            {
                onAnimationFinished()
            }
        }
    }
    
    func onAnimationFinished()
    {
        switch currentSpaceShipStatus
        {
            case .Ready:
                mainButton.setTitle("Land rocket", for: .normal)
                currentSpaceShipStatus = .Launched
            case .Launched:
                mainButton.setTitle("Launch", for: .normal)
                currentSpaceShipStatus = .Ready
        }
        
        mainButton.isEnabled = true
    }

    @IBAction func lanchButtonAction(_ sender: Any)
    {
        switch currentSpaceShipStatus
        {
            case .Ready:
                LaunchRocket(yPoint: -UIScreen.main.bounds.height)
            case .Launched:
                LaunchRocket(yPoint: .zero)
        }
    }
}

enum SpaceShipStatus
{
    case Ready
    case Launched
}

