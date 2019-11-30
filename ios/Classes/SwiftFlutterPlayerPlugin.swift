import Flutter
import UIKit
import AVFoundation

public class SwiftFlutterPlayerPlugin: NSObject, FlutterPlugin {
    
    var songPlayer = AVAudioPlayer()
    var hasBeenPaused = false

    var timer: Timer?
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_player_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterPlayerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "getPlatformVersion" {
        result("iOS " + UIDevice.current.systemVersion)
    } else if call.method == "loadFile" {
        self.loadFile()
    } else if call.method == "play" {
        self.play()
    } else if call.method == "pause" {
        self.pause()
    } else if call.method == "stop" {
        self.stop()
    } else if call.method == "play_loop" {
        self.play_loop()
    }
  }
    
    func loadFile() {
        do {
            songPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "teste_wav", ofType: "wav")!))
            
            songPlayer.prepareToPlay()

            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            } catch let sessionError {
                print(sessionError)
            }
        } catch let songPlayerError {
            print(songPlayerError)
        }
    }
    
    @objc func play() {
        songPlayer.numberOfLoops = 0
        songPlayer.play()
    }
    
    func pause() {
        songPlayer.pause()
    }
    
    func stop() {
        songPlayer.stop()
    }
    
    func play_loop() {
        songPlayer.numberOfLoops = -1
        songPlayer.play()
    }
}
