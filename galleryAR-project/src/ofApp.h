#pragma once

#include "ofxiOS.h"
#include "ofxARKit.h"

#define NUM_IMGS 6

class ofApp : public ofxiOSApp {
    
public:
    
    ofApp (ARSession * session);
    ofApp();
    ~ofApp ();
    
    void setup();
    void update();
    void draw();
    void exit();
    
    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);
    void touchDoubleTap(ofTouchEventArgs &touch);
    void touchCancelled(ofTouchEventArgs &touch);
    
    void lostFocus();
    void gotFocus();
    void gotMemoryWarning();
    void deviceOrientationChanged(int newOrientation);

    
    ofTrueTypeFont font;
    
    ofCamera camera;
    
    // ====== AR STUFF ======== //
    ARSession * session;
    ARRef processor;
    
    ofImage img[NUM_IMGS];
    
    int taps=0;
    int maxImg=6;
    
    //int initOrient;
};


