#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){	
    grabber.setup(360, 480,OF_PIXELS_RGB);
    
    if(!faceTracker.isFaceTrackingAvailable())
    {
        printf("face tracking not available\n exiting....\n");
        exit();
    }
}

//--------------------------------------------------------------
void ofApp::update(){
    grabber.update();
    
    if(grabber.isFrameNew())
    {
        //FACE DETECTION
        //convert ofPixels to CGImageRef
        CGImageRef ref = faceTracker.CGImageRefFromOfPixels(grabber.getPixels(), grabber.getWidth(), grabber.getHeight(), 3);
        
        //detect faces
        faceTracker.detectFaces(ref);
    }
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofSetBackgroundColor(255);
    
    //draw grabber
    ofSetColor(255);
    grabber.draw(0, 0);
    
    //draw faces bounding boxes
    ofNoFill();
    ofSetLineWidth(2);
    ofSetColor(255, 255, 0);
    if(faceTracker.getFaces()->size()>0)
    {
        vector<ofRectangle>* vecTmp = faceTracker.getFaces();
        for(int i=0;i<vecTmp->size();i++)
        {
            ofRectangle* recTmp = &(vecTmp->at(i));
            ofDrawRectangle(recTmp->x*grabber.getWidth(), recTmp->y*grabber.getHeight(), recTmp->width*grabber.getWidth(), recTmp->height*grabber.getHeight());
        }
    }
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}
