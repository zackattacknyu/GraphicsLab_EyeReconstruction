package mygame;

import com.jme3.app.SimpleApplication;
import com.jme3.input.KeyInput;
import com.jme3.input.MouseInput;
import com.jme3.input.controls.ActionListener;
import com.jme3.input.controls.AnalogListener;
import com.jme3.input.controls.KeyTrigger;
import com.jme3.input.controls.MouseAxisTrigger;
import com.jme3.input.controls.MouseButtonTrigger;
import com.jme3.material.Material;
import com.jme3.math.ColorRGBA;
import com.jme3.math.Matrix3f;
import com.jme3.math.Quaternion;
import com.jme3.math.Vector3f;
import com.jme3.renderer.RenderManager;
import com.jme3.scene.Geometry;
import com.jme3.scene.shape.Box;
import com.jme3.scene.Spatial;
import com.jme3.system.AppSettings;
import java.util.Properties;


/**
 * test
 * @author normenhansen
 */
public class Main extends SimpleApplication {
    
    private Spatial currentBox;
    private Material boxMat;
    private boolean mousePressedDown = false;
   
    private Vector3f lookAtCenter = Vector3f.ZERO;

    public static void main(String[] args) {
        
        /*
         * Refer to these two web pages to find out about start settings:
         *      http://hub.jmonkeyengine.org/wiki/doku.php/jme3:intermediate:appsettings
         * 
         *      http://hub.jmonkeyengine.org/wiki/doku.php/jme3:intermediate:simpleapplication
         * 
         * 
         */
        Properties appProps = PropertiesHelper.getProperties();
        AppSettings settings = new AppSettings(true);
        
        //adjusts title shown on window
        settings.setTitle(appProps.getProperty("settings.title"));
        
        //adjusts resolution
        int xRes = Integer.parseInt(appProps.getProperty("settings.xResolution"));
        int yRes = Integer.parseInt(appProps.getProperty("settings.yResolution"));
        settings.setResolution(xRes, yRes);
        
        Main app = new Main();
        app.setSettings(settings); //disables the setting screen at start-up
        app.setShowSettings(false); //shows the above settings
        app.setDisplayFps(false); //makes sure the fps text is not displayed
        app.setDisplayStatView(false); //makes sure the stat view is not displayed
        app.start();
    }

    @Override
    public void simpleInitApp() {
        
        
        viewPort.setBackgroundColor(Constants.BACKGROUND_COLOR);
        
        boxMat = new Material(assetManager,"Common/MatDefs/Misc/Unshaded.j3md");
        boxMat.setColor("Color", ColorRGBA.Red);
        
        currentBox = initBox(boxMat,"box");
        
        Spatial box2 = initBox(boxMat,"box");
        box2.setLocalTranslation(5f, 0, 0);
        
        rootNode.attachChild(box2);
        rootNode.attachChild(currentBox);
        
        setDefaultCamera();
        enableFlyCam();
        initKeyboardInputs();

        
    }
    
    
    private Spatial initBox(Material ballMat, String name){
        Box b = new Box(1f, 1f, 1f);
        Spatial sampleBox = new Geometry("Box", b);
        sampleBox.setName(name);
        sampleBox.setLocalScale(1);
        sampleBox.setMaterial(ballMat);
        return sampleBox;
    }

    @Override
    public void simpleUpdate(float tpf) {
        /*explained here is how the update loop works
         * http://hub.jmonkeyengine.org/wiki/doku.php/jme3:beginner:hello_main_event_loop
         */
        

    }

    @Override
    public void simpleRender(RenderManager rm) {
        //TODO: add render code
    }
   
    private void setDefaultCamera(){
        cam.setLocation(new Vector3f(-16.928802f, 23.251862f, -54.489124f));
        cam.setRotation(new Quaternion(0.20308718f, 0.20007013f, -0.042432234f, 0.9575631f));
    }
    private void enableFlyCam(){
        flyCam.setEnabled(true);
        flyCam.setDragToRotate(true);
        flyCam.setMoveSpeed(10f);
        flyCam.setRotationSpeed(0f);
    }
    
    private void moveCamera(boolean inward){
        float moveAmount = 1.0f/5.0f;
        if(inward){
            moveAmount = -1*moveAmount;
        }
        Vector3f currentLoc = cam.getLocation();
        Vector3f direction = currentLoc.subtract(lookAtCenter);
        direction.normalizeLocal();
        Vector3f moveVector = direction.mult(moveAmount);
        cam.setLocation(currentLoc.add(moveVector));
    }

    private void initKeyboardInputs() {
        //ChaseCamera chaser = new ChaseCamera(cam, littleObject);
        //chaser.registerWithInput(inputManager);
        
        guiFont = assetManager.loadFont("Interface/Fonts/Default.fnt");
        
        inputManager.addMapping("moveInward", new KeyTrigger(KeyInput.KEY_R));
        inputManager.addMapping("moveOutward", new KeyTrigger(KeyInput.KEY_F));
        
        inputManager.addMapping("rotCameraLeft", new MouseAxisTrigger(MouseInput.AXIS_X,false));
        inputManager.addMapping("rotCameraRight", new MouseAxisTrigger(MouseInput.AXIS_X,true));
        inputManager.addMapping("rotCameraUp", new MouseAxisTrigger(MouseInput.AXIS_Y,false));
        inputManager.addMapping("rotCameraDown", new MouseAxisTrigger(MouseInput.AXIS_Y,true));
        
        inputManager.addMapping("pickControlPoint", new MouseButtonTrigger(MouseInput.BUTTON_LEFT));
        
        final Matrix3f rotLeftMatrix = TrackingHelper.getRotationMatrix(-1.0f/20.0f, Vector3f.UNIT_Y);
        final Matrix3f rotRightMatrix = TrackingHelper.getRotationMatrix(1.0f/20.0f, Vector3f.UNIT_Y);
        final Matrix3f rotUpMatrix = TrackingHelper.getRotationMatrix(-1.0f/20.0f, Vector3f.UNIT_X);
        final Matrix3f rotDownMatrix = TrackingHelper.getRotationMatrix(1.0f/20.0f, Vector3f.UNIT_X);
        
        AnalogListener anl = new AnalogListener(){

            public void onAnalog(String name, float value, float tpf) {
                if(name.equals("rotCameraLeft") && mousePressedDown){
                    cam.setLocation(rotLeftMatrix.mult(cam.getLocation()));
                    cam.lookAt(lookAtCenter, cam.getUp());
                }
                if(name.equals("rotCameraRight") && mousePressedDown){
                    cam.setLocation(rotRightMatrix.mult(cam.getLocation()));
                    cam.lookAt(lookAtCenter, cam.getUp());
                }
                if(name.equals("rotCameraUp") && mousePressedDown){
                    cam.setLocation(rotUpMatrix.mult(cam.getLocation()));
                    cam.lookAt(lookAtCenter, cam.getUp());
                }
                if(name.equals("rotCameraDown") && mousePressedDown){
                    cam.setLocation(rotDownMatrix.mult(cam.getLocation()));
                    cam.lookAt(lookAtCenter, cam.getUp());
                }
            }
        };        
        
        ActionListener acl = new ActionListener() {

            public void onAction(String name, boolean keyPressed, float tpf) {
 
                if(name.equals("pickControlPoint")){
                    
                    //IMPORTANT: 
                    // used when I want to register dragging above
                    mousePressedDown = !mousePressedDown;
                    
                }
                if(name.equals("moveInward")){
                    moveCamera(true);
                }
                if(name.equals("moveOutward")){
                    moveCamera(false);
                }
                
                
            }
        };
        
        inputManager.addListener(anl, 
                "rotCameraLeft",
                "rotCameraRight",
                "rotCameraUp",
                "rotCameraDown");
        inputManager.addListener(acl,
                "moveInward",
                "moveOutward",
                "pickControlPoint");

    }
}
