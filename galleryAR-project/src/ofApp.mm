#include "ofApp.h"


//--------------------------------------------------------------
ofApp :: ofApp (ARSession * session){
    this->session = session;
    cout << "creating ofApp" << endl;
}

ofApp::ofApp(){}

//--------------------------------------------------------------
ofApp :: ~ofApp () {
    cout << "destroying ofApp" << endl;
}

//--------------------------------------------------------------
void ofApp::setup() {
    ofBackground(127);
    for(int i=0;i<NUM_IMGS;i++){
        img[i].load(ofToString(i+1)+".jpg");
    }
    
    int fontSize = 8;
    if (ofxiOSGetOFWindow()->isRetinaSupportedOnDevice())
        fontSize *= 2;
    
    font.load("fonts/mono0755.ttf", fontSize);
    //font.load("Futura.ttc", 20);
    
    processor = ARProcessor::create(session);
    processor->setup();
    
    //initOrient = (ofGetOrientation());
    //cout << initOrient << endl;
}

//--------------------------------------------------------------
void ofApp::update(){
    //if(taps==maxImg)taps=0;
    
    
    
    processor->update();
}

//--------------------------------------------------------------
void ofApp::draw() {
    ofSetColor(255);
    
    
    ofEnableAlphaBlending();
    
    ofDisableDepthTest();
    processor->draw();
    ofEnableDepthTest();
    
    processor->anchorController->loopAnchors([=](ARObject obj)->void {
        //cout << processor->anchorController->anchorsIndex << endl; // NUNO

        camera.begin();
        processor->setARCameraMatrices();
        
        ofPushMatrix();
        ofMultMatrix(obj.modelMatrix);
        
        ofSetColor(255);
        //ofRotate(90,0,0,1); use this if you want to use the app on portrait mode
        
        
        //img.draw(-(0.25 / 2),-(0.25 / 2),0.25,0.25);
        //img.draw(-(0.25 / 2),-(0.25 / 2),0.5,0.5);
        /*for(int i=0;i<NUM_IMGS;i++){
            img[i].draw(-(0.25 / 2),-(0.25 / 2),0.5,0.5);
        }
        */
        //img[taps].draw(-(0.25 / 2),-(0.25 / 2),0.5,0.5);
        int myIndex= processor->anchorController->anchorsIndex;
        //img[myIndex].draw(-(0.25 / 2),-(0.25 / 2),0.5,0.5);
        //img[myIndex].draw(-0.2,-0.2,0.5,0.5);
        img[myIndex].draw(-0.22,-0.13,0.5,0.39);
        ofPopMatrix();
        
        camera.end();
                
    });
    
    ofDisableDepthTest();
    // ========== DEBUG STUFF ============= //
   
   processor->debugInfo.drawDebugInformation(font);

    
}

//--------------------------------------------------------------
void ofApp::exit() {
    //
}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs &touch){
    
    taps+=1;
    if(taps>0 && taps<=maxImg){
        ofLogNotice() << "taps: " << taps;
        processor->addAnchor(ofVec3f(touch.x,touch.y,-0.5));
    }
        
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs &touch){
    
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs &touch){
    
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs &touch){
    
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
    processor->deviceOrientationChanged(newOrientation);
    cout << "orient" << newOrientation << endl;
}


//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs& args){
    
}


