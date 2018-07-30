/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package johnny.gamestore.mysql.dao;

import java.util.ArrayList;
import java.util.List;

import johnny.gamestore.mysql.beans.Review;
import johnny.gamestore.mysql.beans.Tablet;
import johnny.gamestore.mysql.common.Constants;
import johnny.gamestore.mysql.common.SerializeHelper;

/**
 *
 * @author Johnny
 */
public class TabletDao {
    private static TabletDao dao;
    private static List<Tablet> tablets = new ArrayList<Tablet>();
    private TabletDao() {}
    
    public static synchronized TabletDao createInstance() {
        if (dao == null) {
            dao = new TabletDao();
            init();
        }
        return dao;
    }
    
    private static void init() {
        if (SerializeHelper.exsitDataFile(Constants.DATA_FILE_TABLET)) {
            tablets = (List<Tablet>)SerializeHelper.readFromFile(Constants.DATA_FILE_TABLET);
        } else {
            tablets = new ArrayList<Tablet>();
            Tablet ap_ipadpro = new Tablet("ap_ipadpro", Constants.CONST_TABLET_APPLE, "iPad Pro 128GB",949.99,"tablets/ipadpro.jpg",Constants.CONST_TABLET_APPLE,"New",10);
            Tablet ap_ipadair = new Tablet("ap_ipadair", Constants.CONST_TABLET_APPLE, "iPad Air 2 16GB - Gold",399.99,"tablets/ipadair.jpg",Constants.CONST_TABLET_APPLE,"New",10);
            tablets.add(ap_ipadpro);
            tablets.add(ap_ipadair);

            Tablet ms_surface3 = new Tablet("ms_surface3", Constants.CONST_TABLET_MICROSOFT, "Surface 3 - 10.8 128GB Silver",549.99,"tablets/surface3.jpg",Constants.CONST_TABLET_MICROSOFT,"New",10);
            Tablet ms_surface4 = new Tablet("ms_surface4", Constants.CONST_TABLET_MICROSOFT, "Surface 4 12.3 128GB Silver",999.99,"tablets/surface4.jpg",Constants.CONST_TABLET_MICROSOFT,"New",10);
            tablets.add(ms_surface3);
            tablets.add(ms_surface4);

            Tablet ss_galaxya = new Tablet("ss_galaxya", Constants.CONST_TABLET_SAMSUNG, "Galaxy Tab A - 9.7 - 16GB ",299.99,"tablets/galaxya.jpg",Constants.CONST_TABLET_SAMSUNG,"New",10);
            Tablet ss_kidse = new Tablet("ss_kidse", Constants.CONST_TABLET_SAMSUNG, "Kids Galaxy Tab E Lite 7 8GB",129.99,"tablets/kidspad.jpg",Constants.CONST_TABLET_SAMSUNG,"New",10);
            tablets.add(ss_galaxya);
            tablets.add(ss_kidse);
            SerializeHelper.writeToFile(Constants.DATA_FILE_TABLET, tablets);
        }
    }
    public List<Tablet> getTabletList() {
        return tablets;        
    }    
    
    public List<Tablet> getTabletList(String maker) {
        if (maker==null || maker.isEmpty()) {
            return getTabletList();
        }

        List<Tablet> res = new ArrayList<Tablet>();
        for(Tablet tablet : tablets) {
            if (tablet.getMaker().toLowerCase().equals(maker.toLowerCase())) {
                res.add(tablet);
            }
        }
        return res;
    }
    
     public Tablet getTablet(String key) {
        for (Tablet tablet: tablets) {
            if (tablet.getKey().equalsIgnoreCase(key)) {
                return tablet;
            }
        }
        return null;
    }
    
    public void addTabletReview(String key, Review review) {
        Tablet tablet = getTablet(key);
        if (tablet != null) {
            tablet.getReviews().add(0, review);
             SerializeHelper.writeToFile(Constants.DATA_FILE_TABLET, tablets);
        }
    }
}
