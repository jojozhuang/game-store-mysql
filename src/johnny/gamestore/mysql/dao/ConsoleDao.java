/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package johnny.gamestore.mysql.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import johnny.gamestore.mysql.beans.Accessory;
import johnny.gamestore.mysql.beans.Console;
import johnny.gamestore.mysql.beans.Review;
import johnny.gamestore.mysql.common.Constants;
import johnny.gamestore.mysql.common.SerializeHelper;

/**
 *
 * @author Johnny
 */
public class ConsoleDao {
    private static ConsoleDao dao;
    private static List<Console> consoles = new ArrayList<Console>();
    private ConsoleDao() {}
    
    public static synchronized ConsoleDao createInstance() {
        if (dao == null) {
            dao = new ConsoleDao();
            init();
        }
        return dao;
    }
    
    private static void init() {
        if (SerializeHelper.exsitDataFile(Constants.DATA_FILE_CONSOLE)) {
            consoles = (List<Console>)SerializeHelper.readFromFile(Constants.DATA_FILE_CONSOLE);
        } else {
            consoles = new ArrayList<Console>();
            Accessory xboxone_wc = new Accessory("xboxone_wc", "xboxone", "Controller", 40.00, "accessories/XBOX controller.jpg", "Microsoft","New",10);
            Accessory xboxone_sh = new Accessory("xboxone_sh", "xboxone", "Turtle Beach Headset", 50.00, "accessories/Turtle Beach Headset.jpg", "Microsoft","New",10);
            List<Accessory> accessories = new ArrayList<Accessory>();
            accessories.add(xboxone_wc);
            accessories.add(xboxone_sh);
            Console xboxone = new Console("xboxone", Constants.CONST_MICROSOFT, "XBox One",399.00,"consoles/xbox1.jpg",Constants.CONST_MICROSOFT,"New",10,accessories);
            ArrayList<Review> list = new ArrayList<Review>();
            Review review = new Review("1", xboxone.getKey(), "customer", 3, new Date(), "Too expensive, doesn't worth");
            list.add(review);
            xboxone.setReviews(list);
            consoles.add(xboxone);
            
            accessories = new ArrayList<Accessory>();
            Accessory xbox360_mr = new Accessory("xbox360_mr", "xbox360", "Speeding Wheel", 40.00, "accessories/XBOX360-SpeedWheel.jpg", "Microsoft","New",10);
            accessories.add(xbox360_mr);
            Accessory xbox360_wa = new Accessory("xbox360_wa", "xbox360", "Wireless Adapter", 50.00, "accessories/xbox360_wa.png", "Microsoft","New",10);
            accessories.add(xbox360_wa);
            Console xbox360 = new Console("xbox360", Constants.CONST_MICROSOFT, "XBox 360",299.00,"consoles/xbox360.jpg", Constants.CONST_MICROSOFT,"New",10,accessories);
            list = new ArrayList<Review>();
            review = new Review("1", xbox360.getKey(), "customer", 5, new Date(), "Easy to use, funny!");
            list.add(review);
            review = new Review("2", xbox360.getKey(), "storemanager", 4, new Date(), "Like it!");
            list.add(review);
            xbox360.setReviews(list);
            consoles.add(xbox360);

            Accessory ps3_wc = new Accessory("ps3_wc", "ps3", "Wireless Controller", 19.99, "accessories/ps3_controller.jpg", Constants.CONST_SONY,"New",10);
            Accessory ps3_dc = new Accessory("ps3_dc", "ps3", "Disc Remote Control", 24.99, "accessories/ps3_diskcontroller.jpg", Constants.CONST_SONY,"New",10);
            accessories = new ArrayList<Accessory>();
            accessories.add(ps3_wc);
            accessories.add(ps3_dc);
            Console ps3 = new Console("ps3", Constants.CONST_SONY, "PS3",219.00,"consoles/ps3-console.jpg",Constants.CONST_SONY,"New",10,accessories);
            consoles.add(ps3);

            Accessory ps4_cb = new Accessory("ps4_cb", "ps4", "Chartboost - Black", 19.99, "accessories/chartboost.jpg", Constants.CONST_SONY,"New",10);
            Accessory ps4_cc = new Accessory("ps4_cc", "ps4", "Dual Controller Charger", 24.99, "accessories/ps4_controllercharger.jpg", Constants.CONST_SONY,"New",10);
            accessories = new ArrayList<Accessory>();
            accessories.add(ps4_cb);
            accessories.add(ps4_cc);
            Console ps4 = new Console("ps4", Constants.CONST_SONY, "PS4",349.00,"consoles/PS4-console-bundle.jpg",Constants.CONST_SONY,"New",10,accessories);
            consoles.add(ps4);

            Accessory wii_cs = new Accessory("wii_cs", "wii", "Charging System - Black", 21.99, "accessories/wii_chargingsystem.jpg", Constants.CONST_NINTENDO,"New",10);
            Accessory wii_rp = new Accessory("wii_rp", "wii", "Wii Remote Plus", 39.99, "accessories/wii_remoteplus.jpg", Constants.CONST_NINTENDO,"New",10);            
            accessories = new ArrayList<Accessory>();
            accessories.add(wii_cs);
            accessories.add(wii_rp);
            Console wii = new Console("wii", Constants.CONST_NINTENDO, "Wii",269.00,"consoles/wii.jpg",Constants.CONST_NINTENDO,"New",10,accessories);
            consoles.add(wii);

            Accessory wiiu_fp = new Accessory("wiiu_fp", "wiiu", "Fight Pad", 16.99, "accessories/wiiu_fightingpad.jpg", Constants.CONST_NINTENDO,"New",10);
            Accessory wiiu_gc = new Accessory("wiiu_gc", "wiiu", "GameCube Controller", 29.99, "accessories/wiiu_gamecube.jpg", Constants.CONST_NINTENDO,"New",10);            
            accessories = new ArrayList<Accessory>();
            accessories.add(wiiu_fp);
            accessories.add(wiiu_gc);
            Console wiiu = new Console("wiiu", Constants.CONST_NINTENDO, "WiiU",299.99,"consoles/wiiu.jpg",Constants.CONST_NINTENDO,"New",10,accessories);
            consoles.add(wiiu);
            SerializeHelper.writeToFile(Constants.DATA_FILE_CONSOLE, consoles);
        }
    }
    
    public List<Console> getConsoleList() {
        return consoles;
    }    
    
    public List<Console> getConsoleList(String maker) {
        if (maker==null || maker.isEmpty()) {
            return consoles;
        }

        List<Console> res = new ArrayList<Console>();
        for(Console console : consoles) {
            if (console.getRetailer().toLowerCase().equals(maker.toLowerCase())) {
                res.add(console);
            }
        }
        return res;
    }
    
    public Console getConsole(String key) {
        for (Console console: consoles) {
            if (console.getKey().equalsIgnoreCase(key)) {
                return console;
            }
        }
        return null;
    }
    
    public boolean isConsoleExisted(String key) {
        return getConsole(key) == null ? false : true;
    }
    
    public Accessory getAccessory(String key, String acckey) {
        for (Console console: consoles) {
            if (console.getKey().equalsIgnoreCase(key)) {
                 for (Accessory accessory: console.getAccessories()) {
                    if (accessory.getKey().equalsIgnoreCase(acckey)) {
                        return accessory;
                    }
                }
            }
        }
        return null;
    }
    
    public boolean isAccessoryExisted(String key, String acckey) {
        return getAccessory(key, acckey) == null ? false : true;
    }
    
    public void addAccessory(String key, Accessory acckey) {
        Console console = getConsole(key);
        if (console != null) {
            console.getAccessories().add(acckey);
            SerializeHelper.writeToFile(Constants.DATA_FILE_CONSOLE, consoles);
        }
    }
    
    public void updateAccessory() {
        SerializeHelper.writeToFile(Constants.DATA_FILE_CONSOLE, consoles);
    }
    
    public void deleteAccessory(String key, String acckey) {
        Console console = getConsole(key);
        if (console != null) {
            List<Accessory> accessories = console.getAccessories();
            if (accessories==null || accessories.isEmpty()) {
                return;
            } 

            Accessory accessory = getAccessory(key, acckey);
            if (accessory==null) {
                return;
            } else {
                accessories.remove(accessory);
            }        
            SerializeHelper.writeToFile(Constants.DATA_FILE_CONSOLE, consoles);
        }        
    }
    
    public void addConsoleReview(String key, Review review) {
        Console console = getConsole(key);
        if (console != null) {
            console.getReviews().add(0, review);
            SerializeHelper.writeToFile(Constants.DATA_FILE_CONSOLE, consoles);
        }
    }
    
     public void addAccessoryReview(String key, String acckey, Review review) {
        Console console = getConsole(key);
        if (console != null) {
            Accessory accessory = getAccessory(key, acckey);
            if (accessory != null) {
                accessory.getReviews().add(0, review);
                SerializeHelper.writeToFile(Constants.DATA_FILE_CONSOLE, consoles);
            }
        }
    }
}
