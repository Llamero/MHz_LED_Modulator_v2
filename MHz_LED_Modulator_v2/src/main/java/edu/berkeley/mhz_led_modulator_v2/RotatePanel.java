/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package edu.berkeley.mhz_led_modulator_v2;

/**
*https://mdsaputra.wordpress.com/2011/06/24/java-rotate-image/
* @author EtaYuy88 aka Meihta Dwiguna Saputra
*/
import java.awt.*;
import java.awt.geom.*;
import java.awt.image.BufferedImage;
import javax.swing.*;
 
public class RotatePanel extends JPanel {
    private Image image;
    private double currentAngle;
 
    public RotatePanel()
    {}
 
    public RotatePanel(Image image) {
        this.image = image;
        if (image == null) image = new BufferedImage(300, 300, BufferedImage.TYPE_INT_RGB); //Needed to keep Design mode from crashing if image is null: https://stackoverflow.com/questions/28805846/netbeans-showing-error-in-design-view-even-though-the-code-is-working-properly
        MediaTracker mt = new MediaTracker(this);
        mt.addImage(image, 0);
        try {
            mt.waitForID(0);
        }
        catch (InterruptedException e) {
            e.printStackTrace(System.err);
        }
    }
 
    public void setImage(Image image)
    {
       this.image = image;
       if (image == null) image = new BufferedImage(300, 300, BufferedImage.TYPE_INT_RGB); //Needed to keep Design mode from crashing if image is null: https://stackoverflow.com/questions/28805846/netbeans-showing-error-in-design-view-even-though-the-code-is-working-properly
       MediaTracker mt = new MediaTracker(this);
       mt.addImage(image, 0);
       try {
           mt.waitForID(0);
       }
       catch (InterruptedException e) {
           e.printStackTrace(System.err);
       }
    }
 
    public void rotate() {
        //rotate 2 degrees at a time
        currentAngle-=2.0;
        if (currentAngle >= 360.0) {
            currentAngle = 0;
        }
        repaint();
    }
 
    public void rotateWithParam(int rotateDegree) {
        //rotate base on rotateDegree parameter degrees at a time
        currentAngle = rotateDegree;
        if (currentAngle >= 360.0) {
            currentAngle = 0;
        }
        repaint();
    }
 
    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        if (image == null) image = new BufferedImage(300, 300, BufferedImage.TYPE_INT_RGB); //Needed to keep Design mode from crashing if image is null: https://stackoverflow.com/questions/28805846/netbeans-showing-error-in-design-view-even-though-the-code-is-working-properly
        Graphics2D g2d = (Graphics2D)g;
        AffineTransform origXform = g2d.getTransform();
        AffineTransform newXform = (AffineTransform)(origXform.clone());
        //center of rotation is center of the panel
        int xRot = this.getWidth()/2;
        int yRot = this.getHeight()/2;
        newXform.rotate(Math.toRadians(currentAngle), xRot, yRot);
        g2d.setTransform(newXform);
        //draw image centered in panel
        int x = (getWidth() - image.getWidth(this))/2;
        int y = (getHeight() - image.getHeight(this))/2;
        g2d.drawImage(image, x, y, this);
        g2d.setTransform(origXform);
    }
 
}//end of class
