//
//  ofxiOSFaceTracking.cpp
//
//
//  Created by Pierluigi Dalla Rosa on 9/9/19.
// www.pierdr.com
// www.tramontana.xyz
//

#include "ofxiOSFaceTracking.h"

@implementation iOSFaceTracking

-(NSArray*)detectFaces:(CGImageRef)image{
    if (@available(iOS 11.0, *)) {
        
        #if __has_feature(objc_arc)
            VNDetectFaceRectanglesRequest *faceDetectionReq = [VNDetectFaceRectanglesRequest new];
            NSDictionary *d = [[NSDictionary alloc] init];
            VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCGImage:image options:d];
        #else
        VNDetectFaceRectanglesRequest *faceDetectionReq = [[VNDetectFaceRectanglesRequest new] autorelease];
            NSDictionary *d = [[[NSDictionary alloc] init] autorelease];
            VNImageRequestHandler *handler = [[[VNImageRequestHandler alloc] initWithCGImage:image options:d] autorelease];
        #endif
        
        [handler performRequests:@[faceDetectionReq] error:nil];
        
        return faceDetectionReq.results;
       
    } else {
    }
    return nil;
}
-(BOOL)isFaceTrackingAvailable{
    if (@available(iOS 11.0, *)) {
        return YES;
    } else {
        return NO;
    }
}

@end

ofxiOSFaceTracking::ofxiOSFaceTracking(){
    tracker = [[iOSFaceTracking alloc] init];
    faces = new vector<ofRectangle>();
}
bool ofxiOSFaceTracking::isFaceTrackingAvailable(){
    return [tracker isFaceTrackingAvailable];
}
void ofxiOSFaceTracking::detectFaces(CGImageRef image)
{
    if (@available(iOS 11.0, *)) {
        faces->clear();
        NSArray* arr = [tracker detectFaces:image];
        for(VNFaceObservation *observation in arr){
            if(observation){
                faces->push_back(ofRectangle(observation.boundingBox.origin.x, (1-observation.boundingBox.origin.y)-observation.boundingBox.size.height, observation.boundingBox.size.width, observation.boundingBox.size.height));
            }
        }
    } else {
        NSLog(@"face tracking not available");
    }
}
vector<ofRectangle>* ofxiOSFaceTracking::getFaces(){
    return faces;
}
CGImageRef ofxiOSFaceTracking::CGImageRefFromOfPixels( ofPixels & img, int width, int height, int numberOfComponents ){
    
    int bitsPerColorComponent = 8;
    int rawImageDataLength = width * height * numberOfComponents;
    BOOL interpolateAndSmoothPixels = NO;
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    CGDataProviderRef dataProviderRef;
    CGColorSpaceRef colorSpaceRef;
    CGImageRef imageRef;
    
    GLubyte *rawImageDataBuffer =  (unsigned char*)(img.getData());
    dataProviderRef = CGDataProviderCreateWithData(NULL,  rawImageDataBuffer, rawImageDataLength, nil);
    if(numberOfComponents>1)
    {
        colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    }
    else
    {
        colorSpaceRef = CGColorSpaceCreateDeviceGray();
    }
    imageRef = CGImageCreate(width, height, bitsPerColorComponent, bitsPerColorComponent * numberOfComponents, width * numberOfComponents, colorSpaceRef, bitmapInfo, dataProviderRef, NULL, interpolateAndSmoothPixels, renderingIntent);
    
    return imageRef;
}

