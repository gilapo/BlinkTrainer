import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        BlinkTrainerView()
    }
}

struct BlinkTrainerView: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    func makeUIViewController(context: Context) -> some UIViewController {
        return FaceViewController()
    }
}

class FaceViewController: UIViewController {
   
    var bubleArray:[String] = ["buble2","buble3","buble4","buble5","buble6","buble7","buble8","buble9","buble10"]
    var scene:Int = 0
    var isBlinked:Bool = false
    var isMouthOpen:Bool = false
    
    
    var soundURI: URL?
    var audioPlayer = AVAudioPlayer()
    
    var noseImage:UIImageView = {
        let noseImage = UIImageView()
        noseImage.translatesAutoresizingMaskIntoConstraints = false
        noseImage.image = UIImage(named: "Nose")
        noseImage.contentMode = .scaleAspectFill
        return noseImage
    }()
    
    var hairImage:UIImageView = {
        let hairImage = UIImageView()
        hairImage.translatesAutoresizingMaskIntoConstraints = false
        hairImage.image = UIImage(named: "Hair")
        hairImage.contentMode = .scaleAspectFill
        return hairImage
    }()
    
    var rightEyeImage:UIImageView = {
        let eyeImage =  UIImageView()
        eyeImage.translatesAutoresizingMaskIntoConstraints = false
        eyeImage.image = UIImage(named: "openRightEye")
        eyeImage.frame.origin = CGPoint(x: 0, y: 0)
        eyeImage.contentMode = .scaleAspectFill
        
        return eyeImage
    }()
    
    var leftEyeImage:UIImageView = {
        let eyeImage =  UIImageView()
        eyeImage.translatesAutoresizingMaskIntoConstraints = false
        eyeImage.image = UIImage(named: "openLeftEye")
        eyeImage.frame.origin = CGPoint(x: 0, y: 0)
        eyeImage.contentMode = .scaleAspectFill
        
        return eyeImage
    }()
    
    var mouthImage:UIImageView = {
        let mouthImage =  UIImageView()
        mouthImage.translatesAutoresizingMaskIntoConstraints = false
        mouthImage.image = UIImage(named: "openMouth")
        mouthImage.frame.origin = CGPoint(x: 0, y: 0)
        mouthImage.contentMode = .scaleAspectFill
        
        return mouthImage
    }()
    
    var bubleImage:UIImageView = {
        let bubleImage =  UIImageView()
        bubleImage.translatesAutoresizingMaskIntoConstraints = false
        bubleImage.frame.origin = CGPoint(x: 0, y: 0)
        bubleImage.contentMode = .scaleAspectFill
        
        return bubleImage
    }()
    
    var buttonNext: UIButton = {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 72, height: 72))
            button.setImage(UIImage(named: "next"), for: .normal)
            button.contentMode = .scaleAspectFit
            return button
    }()
    
    var buttonRepeat: UIButton = {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 72, height: 72))
            button.setImage(UIImage(named: "repeat"), for: .normal)
            button.contentMode = .scaleAspectFit
            return button
    }()
    
    override func viewDidLoad() {
        // MARK: skin color
        view.backgroundColor = UIColor(red: 0.94, green: 0.76, blue: 0.58, alpha: 1.00)
        
        viewConfiguration()
        firstScene()
        //playBgSound()
        buttonRepeat.isHidden = true
        buttonNext.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nextScene)))
        buttonRepeat.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(repeatScene)))
    }
    
    
    //MARK: Controller Function
    @objc func nextScene () {
        sceneController()
        scene += 1
    }
    
    @objc func repeatScene () {
        
        if(scene <= 0){
            scene = 0
        }else{
            scene = 6
        }
        sceneController()
    }
    
    func sceneController(){
        
        if(scene <= 2){
            playChatSound()
            openingScene()
        }else if(scene == 3 ){
            playChatSound()
            openingScene()
            closeEye()
            
        }else if(scene == 4 ){
            playChatSound()
            bubleImage.image = UIImage(named: bubleArray[scene])
            openEye()
            
        }else{
            buttonRepeat.isHidden = true
            buttonNext.isHidden = true
            
            bubleImage.image = UIImage(named: "CDBuble")
            playGetReadySound()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.bubleImage.image = UIImage(named: "CDBuble1")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.bubleImage.image = UIImage(named: "CDBuble2")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.bubleImage.image = UIImage(named: "CDBuble3")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.isMouthOpen = true
                self.playTiktokSound()
                self.bubleImage.isHidden = false
                self.bubleImage.image = UIImage(named: "buble8")
                
                self.blinkExerciseScene()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
                self.bubleImage.isHidden = true
                self.playTiktokSound()
                self.isMouthOpen = false
                
                self.blinkExerciseScene()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 12.0) {
                self.playTiktokSound()
                self.blinkExerciseScene()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 16.0) {
                self.playTiktokSound()
                self.blinkExerciseScene()
                
                self.bubleImage.isHidden = false
                
                self.isMouthOpen = true
                self.bubleImage.image = UIImage(named: "buble9")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 20.0) {
                self.playTiktokSound()
                self.isMouthOpen = false
                
                self.blinkExerciseScene()
                
                self.bubleImage.isHidden = true
                self.view.isUserInteractionEnabled = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 24.205){
                self.bubleImage.isHidden = false
                self.playChatSound()
                self.bubleImage.image = UIImage(named: "buble10")
                self.bubleImage.transform = CGAffineTransform(translationX: 1, y: 3)
            
                self.buttonRepeat.isHidden = false
                
            }
            
        }
        
    }
    
    
    //MARK: Controller Scene
    func firstScene(){
        
        closeEye()
        view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.openEye()
            self.view.isUserInteractionEnabled = true
            self.playChatSound()
        }
        //playChatSound()
        bubleImage.image = UIImage(named: "buble1")
        
    }
    
    func openingScene(){
        
        bubleImage.image = UIImage(named: bubleArray[scene])
    }
    
    func blinkExerciseScene() {
        
        closeEye()
        view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.openEye()
        }
        
    }
    
    
    //MARK: music
    public func playSound(file: String, fileExtension: String, isLoop: Bool = false){
        soundURI = URL(fileURLWithPath: Bundle.main.path(forResource: file, ofType: fileExtension)!)
        do {
            guard let uri = soundURI else {return}
            audioPlayer = try AVAudioPlayer(contentsOf: uri)
            audioPlayer.play()
            if(isLoop){
                audioPlayer.numberOfLoops = -1
            }
        } catch {
            print(error)
        }
    }
    
    func playGetReadySound(){
        self.playSound(file: "siapMulai", fileExtension: "mp3")
    }
    func playTiktokSound(){
        self.playSound(file: "twoSecondBlink", fileExtension: "mp3")
    }
    
    //MARK: new change
    func playChatSound(){
        self.playSound(file: "chatIn", fileExtension: "mp3")
    }
    

    
    func closeEye(){
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            UIView.transition(with: self.leftEyeImage, duration: 1, options: .transitionCrossDissolve, animations: {
                self.leftEyeImage.image = UIImage(named: "halfOpenLeftEye")
            }, completion: nil)
            UIView.transition(with: self.rightEyeImage, duration: 1, options: .transitionCrossDissolve, animations: {
                self.rightEyeImage.image = UIImage(named: "halfOpenRightEye")
            }, completion: nil)
        }){ (_) in
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                UIView.transition(with: self.leftEyeImage, duration: 2, options: .transitionCrossDissolve, animations: {
                    self.leftEyeImage.image = UIImage(named: "bareCloseLeftEye")
                }, completion: nil)
                UIView.transition(with: self.rightEyeImage, duration: 1, options: .transitionCrossDissolve, animations: {
                    self.rightEyeImage.image = UIImage(named: "bareCloseRightEye")
                }, completion: nil)
            }){ (_) in
                UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {

                    UIView.transition(with: self.leftEyeImage, duration: 3, options: .transitionCrossDissolve, animations: {
                        self.leftEyeImage.image = UIImage(named: "closedLeftEye")
                        self.leftEyeImage.transform = CGAffineTransform(translationX: 10, y: 50)
                    }, completion: nil)
                    UIView.transition(with: self.rightEyeImage, duration: 1, options: .transitionCrossDissolve, animations: {
                        self.rightEyeImage.image = UIImage(named: "closedRightEye")
                        self.rightEyeImage.transform = CGAffineTransform(translationX: 10, y: 50)
                    }, completion: nil)
                    UIView.transition(with: self.mouthImage, duration: 0.5, options: .curveEaseOut, animations: {
                        if(self.isMouthOpen){
                            self.mouthImage.image = UIImage(named: "openMouth")
                        }else{
                            self.mouthImage.image = UIImage(named: "closedMouth")
                            self.mouthImage.transform = CGAffineTransform(translationX: 0, y: -50)
                        }
                        
                    }, completion: nil)
                })
            }
        }
    }
    
    func openEye(){
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            UIView.transition(with: self.leftEyeImage, duration: 1, options: .transitionCrossDissolve, animations: {
                self.leftEyeImage.image = UIImage(named: "bareCloseLeftEye")
            }, completion: nil)
            UIView.transition(with: self.rightEyeImage, duration: 1, options: .transitionCrossDissolve, animations: {
                self.rightEyeImage.image = UIImage(named: "bareCloseRigthEye")
            }, completion: nil)
        }){ (_) in
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                UIView.transition(with: self.leftEyeImage, duration: 2, options: .transitionCrossDissolve, animations: {
                    self.leftEyeImage.image = UIImage(named: "halfOpenLeftEye")
                }, completion: nil)
                UIView.transition(with: self.rightEyeImage, duration: 1, options: .transitionCrossDissolve, animations: {
                    self.rightEyeImage.image = UIImage(named: "halfOpenRightEye")
                }, completion: nil)
            }){ (_) in
                UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {

                    UIView.transition(with: self.leftEyeImage, duration: 3, options: .transitionCrossDissolve, animations: {
                        self.leftEyeImage.image = UIImage(named: "openLeftEye")
                        self.leftEyeImage.transform = CGAffineTransform(translationX: 0, y: 0)
                    }, completion: nil)
                    UIView.transition(with: self.rightEyeImage, duration: 1, options: .transitionCrossDissolve, animations: {
                        self.rightEyeImage.image = UIImage(named: "openRightEye")
                        self.rightEyeImage.transform = CGAffineTransform(translationX: 0, y: 0)
                    }, completion: nil)
                    if(self.scene<=7){
                        UIView.transition(with: self.mouthImage, duration: 0.5, options: .curveEaseOut, animations: {
                            self.mouthImage.image = UIImage(named: "openMouth")
                            self.mouthImage.transform = CGAffineTransform(translationX: 0, y: 0)
                        }, completion: nil)
                    }
                })
            }
        }
    }
    
    func viewConfiguration(){
        
        var constraint = [NSLayoutConstraint]()
        
        // MARK: Hair
        
        view.addSubview(hairImage)
        constraint.append(hairImage.widthAnchor.constraint(equalTo: view.widthAnchor))
        
        // MARK: Nose
        view.addSubview(noseImage)
        constraint.append(noseImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -10))
        constraint.append(noseImage.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        
        //MARK: Left Eye
        view.addSubview(leftEyeImage)
        constraint.append(leftEyeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.width / 4) - 150))
        constraint.append(leftEyeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 200))
        
        //MARK: Right Eye
        view.addSubview(rightEyeImage)
        constraint.append(rightEyeImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -((view.frame.width / 4) - 150) ))
        constraint.append(rightEyeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 200))
        
        //MARK: Mouth
        view.addSubview(mouthImage)
        constraint.append(mouthImage.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraint.append(mouthImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100))
        
        //MARK: Buble Chat
        
        view.addSubview(bubleImage)
        constraint.append(bubleImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (view.frame.width / 4) - 180))
        constraint.append(bubleImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200))
        
        
        //MARK: Button Next adn Prev
        view.addSubview(buttonNext)
        buttonNext.frame.origin.x = view.frame.width - (buttonNext.frame.width + 50)
        buttonNext.frame.origin.y = view.frame.height - (buttonNext.frame.width + 100)
        
        view.addSubview(buttonRepeat)
        buttonRepeat.frame.origin.x = view.frame.width - (view.frame.width - 50)
        buttonRepeat.frame.origin.y = view.frame.height - (buttonNext.frame.width + 100)
        
        
        
        NSLayoutConstraint.activate(constraint)
    }
    
}
