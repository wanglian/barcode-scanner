class ScanScreen < PM::Screen
  
  def on_load
    setupCapture
  end
  
  def on_appear
    @session.startRunning
  end
  
  def setupCapture
    @session = AVCaptureSession.alloc.init
    @session.sessionPreset = AVCaptureSessionPresetHigh

    @device = AVCaptureDevice.defaultDeviceWithMediaType AVMediaTypeVideo
    @input = AVCaptureDeviceInput.deviceInputWithDevice @device, error:nil

    @previewLayer = AVCaptureVideoPreviewLayer.alloc.initWithSession(@session)
    @previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    layerRect = self.view.layer.bounds
    @previewLayer.bounds = layerRect
    @previewLayer.setPosition(CGPointMake(CGRectGetMidX(layerRect), CGRectGetMidY(layerRect)))
    self.view.layer.addSublayer(@previewLayer)

    @queue = Dispatch::Queue.new('camQueue')
    @output = AVCaptureMetadataOutput.alloc.init
    @output.setMetadataObjectsDelegate self, queue: @queue.dispatch_object

    @session.addInput @input
    @session.addOutput @output
    @output.metadataObjectTypes = [ AVMetadataObjectTypeQRCode ]

    true
  end

  def captureOutput(captureOutput, didOutputMetadataObjects: metadataObjects, fromConnection: connection)
    return if metadataObjects.empty?
    
    Dispatch::Queue.main.async do
      @session.stopRunning
      UIAlertView.alert(metadataObjects[0].stringValue) { @session.startRunning }
    end
    
    
    true
  end
end