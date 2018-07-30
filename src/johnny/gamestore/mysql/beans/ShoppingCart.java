/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package johnny.gamestore.mysql.beans;

import java.util.ArrayList;
import java.util.List;

import johnny.gamestore.mysql.dao.ProductDao;

/**
 *
 * @author Johnny
 */
public class ShoppingCart {
    private ArrayList<CartItem> items;
    public ShoppingCart() {
        items = new ArrayList();
    }
    public List getItems() {
      return items;
    }
    
    public synchronized void addItem(String id, int type) {
        CartItem cartItem;
        for(int i = 0; i < items.size(); i++) {
            cartItem = items.get(i);
            if (cartItem.getItemId().equals(id)) {
                cartItem.incrementItemQuantity();
                return;
            }
        }
        ProductDao dao = ProductDao.createInstance();
        CartItem newCartItem = new CartItem(dao.getProduct(id));
        items.add(newCartItem);
    }
    
    public synchronized void setItemQuantity(String id, int type, int quantity) {
        CartItem cartItem;
        for(int i = 0; i < items.size(); i++) {
            cartItem = items.get(i);
            if (cartItem.getItemId().equals(id)) {
                if (quantity <= 0) {
                    items.remove(i);
                } else {
                    cartItem.setQuantity(quantity);
                }
                return;
            }
        }
        ProductDao dao = ProductDao.createInstance();
        CartItem newCartItem = new CartItem(dao.getProduct(id));
        items.add(newCartItem);
    }
}

