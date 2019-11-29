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
        do {
            songPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "teste_wav", ofType: "wav")!))
            
            songPlayer.prepareToPlay()

            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSession.Category.playback)
            } catch let sessionError {
                print(sessionError)
            }
        } catch let songPlayerError {
            print(songPlayerError)
        }
    } else if call.method == "play" {
        songPlayer.play()
    } else if call.method == "pause" {
        songPlayer.pause()
    } else if call.method == "stop" {
        if let t = timer {
            t.invalidate()
            timer = nil
        }
        songPlayer.stop()
    } else if call.method == "play_loop" {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                        target: self,
                                        selector: #selector(self.play),
                                        userInfo: [ "foo" : "bar" ],
                                        repeats: true)
        }
    }
  }
}
