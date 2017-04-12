//
//  ViewController.swift
//  AVCapture
//
//  Created by mwj on 17/4/7.
//  Copyright © 2017年 MWJ. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    fileprivate lazy var videoQueue = DispatchQueue.global()
    fileprivate lazy var audioQueue = DispatchQueue.global()
    
    fileprivate lazy var session : AVCaptureSession = AVCaptureSession()
    fileprivate lazy var previewLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
    
    fileprivate var videoOutput : AVCaptureVideoDataOutput?
    fileprivate var videoInput : AVCaptureDeviceInput?
    
    fileprivate var audioInput : AVCaptureDeviceInput?
    fileprivate var audioOutput : AVCaptureAudioDataOutput?
    
    fileprivate var movieOutput : AVCaptureMovieFileOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }



}
extension ViewController{


    // MARK:- 开始采集
    @IBAction func startAction(_ sender: UIButton) {
        //1、设置视频的输入和输出
            setupVideo()
        //2、设置音频的输入和输出
            setupAudio()
        //3、添加写入文件的output
        let movieOutput = AVCaptureMovieFileOutput()
        session.addOutput(movieOutput)
        self.movieOutput = movieOutput
        
        
        //4、设置一个预览图层（可选，设置了就可以看到实时视频）
        previewLayer.frame = view.bounds
        view.layer.insertSublayer(previewLayer, at: 0)
        //5、开始采集
        session.startRunning()
        //6、开始将采集的画面，写入到文件中
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/dome.mp4"
        let url = URL(fileURLWithPath: path)
        movieOutput.startRecording(toOutputFileURL: url, recordingDelegate: self)
        
    }
    // MARK:- 停止采集
    @IBAction func stopAction(_ sender: UIButton) {
        self.movieOutput?.stopRecording()
        session.stopRunning()
        previewLayer.removeFromSuperlayer()
    }
    // MARK:- 切换摄像头
    @IBAction func switchAction(_ sender: UIButton) {
        //1、获取之前的摄像头
        guard var position = videoInput?.device.position else{ return }
        //2、获取当前需要显示的摄像头
        position = position == .front ? .back : .front
        //3、根据当前摄像头创建新的device
        guard let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as? [AVCaptureDevice] else{return}
        guard let device = devices.filter({ $0.position == position }).first else{return}
        
        //4、根据新的devise 创建新的input
        guard let cur_videoInput = try? AVCaptureDeviceInput(device: device) else { return }
        
        //在session中切换input
        session.beginConfiguration()
        session.removeInput(self.videoInput)
        session.addInput(cur_videoInput)
        session.commitConfiguration()
        
        self.videoInput = cur_videoInput
    }
}
extension ViewController {

    fileprivate func setupVideo(){
    
        if self.videoInput == nil {
            //1、获取摄像头设备
            guard let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as? [AVCaptureDevice] else{
                print("摄像头不可用")
                return
            }
            guard let device = devices.filter({ $0.position == .front }).first else{return}
            //2、通过device 创建 AVCaptureInput 对象
            let videoInput = try? AVCaptureDeviceInput(device: device)
            self.videoInput = videoInput
        }else{
            session.removeInput(self.videoInput)
        }
        //3、将input添加到会话中
        session.addInput(self.videoInput)
        
        //4、给捕捉会话设置输出源
        if self.videoOutput == nil {
            let videoOutput = AVCaptureVideoDataOutput()
            videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
            self.videoOutput = videoOutput
        }else{
            session.removeOutput(self.videoOutput)
        }
        session.addOutput(self.videoOutput)
        
      
    }
    
    fileprivate func setupAudio(){
    

        if self.audioInput == nil {
            //1、获取话筒设备
            guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio) else {return}
            //2、根据device 创建AVCaptureInput对象
            guard let audioInput = try? AVCaptureDeviceInput(device: device) else {return}
            self.audioInput = audioInput
        }else{
            session.removeInput(self.audioInput)
        }
        
        //3、将input添加到会话中
        session.addInput(self.audioInput)
        //4、给会话设置音频输出源
        if self.audioOutput == nil {
            let audioOutput = AVCaptureAudioDataOutput()
            audioOutput.setSampleBufferDelegate(self, queue: audioQueue)
            self.audioOutput = audioOutput
        }else{
            session.removeOutput(self.audioOutput)
        }
        session.addOutput(self.audioOutput)
        
    }
}

extension ViewController : AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate{

    func captureOutput(_ captureOutput: AVCaptureOutput!, didDrop sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        
        print("-----------")
        
        if connection == videoOutput?.connection(withMediaType: AVMediaTypeVideo) {
            print("采集到视频画面")
        }else{
            print("采集到音频数据")
        }
    }
}

extension ViewController : AVCaptureFileOutputRecordingDelegate {

    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        print("开始写入")
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        print("结束写入")
    }
    
}























