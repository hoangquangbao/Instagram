//
//  VideoCallViewController.swift
//  Instagram
//
//  Created by lhduc on 06/12/2022.
//

import UIKit
import TwilioVideo

class VideoCallViewController: UIViewController {
    var accessToken = ""
    
    var room: Room?
    var camera: CameraSource?
    var localVideoTrack: LocalVideoTrack?
    var localAudioTrack: LocalAudioTrack?
    var remoteParticipant: RemoteParticipant?
    var remoteView: VideoView?
    
    deinit {
        if let camera = self.camera {
            camera.stopCapture()
            self.camera = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Quick start"
    }
    
}
