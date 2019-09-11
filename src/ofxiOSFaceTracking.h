//
//  ofxiOSFaceTracking.hpp
//
//Created by Pierluigi Dalla Rosa on 9/9/19.
// www.pierdr.com
// www.tramontana.xyz
//
#pragma once
#ifndef ofxiOSFaceTracking_hpp
#define ofxiOSFaceTracking_hpp

#import <Foundation/Foundation.h>
#import <Vision/Vision.h>
#import <AVKit/AVKit.h>
#include "ofMain.h"

class ofxiOSFaceTracking;

@interface iOSFaceTracking:NSObject<AVCaptureVideoDataOutputSampleBufferDelegate>{
    AVCaptureSession*           session;
    AVCaptureVideoDataOutput*   videoDataOutput;
    AVCaptureDevice*            captureDevice;
    

    
}
-(NSArray*)detectFaces:(CGImageRef)image;
-(BOOL)isFaceTrackingAvailable;
@end

class ofxiOSFaceTracking{
public:
    ofxiOSFaceTracking();
    bool isFaceTrackingAvailable();
    void detectFaces(CGImageRef image);
    vector<ofRectangle>* faces;
    vector<ofRectangle>* getFaces();
    CGImageRef CGImageRefFromOfPixels( ofPixels & img, int width, int height, int numberOfComponents );
protected:
    
    iOSFaceTracking* tracker;
};
#endif /* ofxiOSFaceTracking_hpp */
