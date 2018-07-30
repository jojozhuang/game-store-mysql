/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package johnny.gamestore.mysql.dao;

import java.util.ArrayList;
import java.util.List;

import johnny.gamestore.mysql.beans.Accessory;
import johnny.gamestore.mysql.beans.Console;
import johnny.gamestore.mysql.beans.Game;
import johnny.gamestore.mysql.beans.ProductItem;
import johnny.gamestore.mysql.beans.Tablet;

/**
 *
 * @author Johnny
 */
public class ProductDao {
    private static ProductDao dao;
    private ProductDao() {}
    
    public static synchronized ProductDao createInstance() {
        if (dao == null) {
            dao = new ProductDao();
        }
        return dao;
    }    
    
    public ArrayList<ProductItem> getProductList() {
        ArrayList<ProductItem> items = new ArrayList();        
        ConsoleDao consoleDao = ConsoleDao.createInstance();
        List<Console> consoles = consoleDao.getConsoleList();
        for (Console cs : consoles) {
            items.add(new ProductItem(cs.getKey(),cs.getName(), 1, cs.getPrice(), cs.getImage(), cs.getMaker(), cs.getDiscount(), cs.getReviews()));
        }
        for (Console cs : consoles) {
            for (Accessory ac : cs.getAccessories()) {
                items.add(new ProductItem(ac.getKey(),ac.getName(), 2, ac.getPrice(), ac.getImage(), ac.getRetailer(), ac.getDiscount(), cs.getKey(), ac.getReviews()));
            }
        }
        GameDao gameDao = GameDao.createInstance();
        for (Game gm : gameDao.getGameList()) {
            items.add(new ProductItem(gm.getKey(),gm.getName(), 3, gm.getPrice(), gm.getImage(), gm.getMaker(), gm.getDiscount(), gm.getReviews()));
        }

        TabletDao tabletDao = TabletDao.createInstance();
        for (Tablet tb : tabletDao.getTabletList()) {
            items.add(new ProductItem(tb.getKey(),tb.getName(), 4, tb.getPrice(), tb.getImage(), tb.getMaker(), tb.getDiscount(), tb.getReviews()));
        }   
        
        return items;
    }    
    public ProductItem getProduct(String id) {        
        if (id == null || id.isEmpty()) {
            return null;
        }
        ArrayList<ProductItem> list = getProductList();
        ProductItem item;
        for(int i = 0; i < list.size(); i++) {
            item = list.get(i);
            if (id.equals(item.getId())) {
                return item;
            }
        }
        return null;
    }
    
    public ArrayList<ProductItem> searchProduct(String keyword) {
        ArrayList<ProductItem> res = new ArrayList();
        ArrayList<ProductItem> list = getProductList();
        if (keyword == null || keyword.isEmpty()) {
            return list;
        }
        ProductItem item;
        for(int i = 0; i < list.size(); i++) {
            item = list.get(i);
            if (item.getName().toLowerCase().contains(keyword.toLowerCase())) {
                res.add(item);
            }
        }
        return res;
    }    
    
    public ArrayList<String> autoCompleteProducts(String keyword) {
        ArrayList<String> res = new ArrayList();
        ArrayList<ProductItem> list = getProductList();
        if (keyword == null || keyword.isEmpty()) {
            return res;
        }
        ProductItem item;
        for(int i = 0; i < list.size(); i++) {
            item = list.get(i);
            if (item.getName().toLowerCase().contains(keyword.toLowerCase())) {
                res.add(item.getName());
            }
        }
        return res;
    }    
}
