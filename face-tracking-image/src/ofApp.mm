#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){	
    ofImageLoadSettings settings;
    settings.grayscale = true;
    
    img.load("poster.jpg",settings);
    
    if(!faceTracking.isFaceTrackingAvailable())
    {
        printf("face tracking not available\n exiting....\n");
        exit();
    }
    faceTracking.detectFaces(faceTracking.CGImageRefFromOfPixels(img.getPixels(), img.getWidth(), img.getHeight(), 1));
   
}

//--------------------------------------------------------------
void ofApp::update(){
 
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofSetBackgroundColor(0, 0, 0);
    ofSetColor(255, 255, 255);
    img.draw(0, 0);
    ofNoFill();
    ofSetColor(0, 255, 255);
    if(faceTracking.getFaces()->size()>0)
    {
        vector<ofRectangle>* vecTmp = faceTracking.getFaces();
        for(int i=0;i<vecTmp->size();i++)
        {
            ofRectangle* recTmp = &(vecTmp->at(i));
            ofDrawRectangle(recTmp->x*img.getWidth(), recTmp->y*img.getHeight(), recTmp->width*img.getWidth(), recTmp->height*img.getHeight());
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
