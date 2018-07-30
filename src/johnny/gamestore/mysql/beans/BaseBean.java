/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package johnny.gamestore.mysql.beans;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Johnny
 */
public class BaseBean implements java.io.Serializable {
    private String key;
    private String maker;
    private String name;
    private double price;
    private String image;
    private String retailer;
    private String condition;
    private double discount;
    private List<Review> reviews = new ArrayList<Review>();

    public BaseBean(String key, String maker, String name, double price, String image, String retailer, String condition, double discount){
        this.key = key;
        this.maker = maker;
        this.name = name;
        this.price = price;
        this.image = image;
        this.condition = condition;
        this.discount = discount;
        this.retailer = retailer;
    }

    public BaseBean(){

    }
    
    public String getKey() {
        return key;
    }
    public void setKey(String key) {
        this.key = key;
    }
    public String getMaker() {
        return maker;
    }
    public void setMaker(String maker) {
        this.maker = maker;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }
    public String getRetailer() {
        return retailer;
    }
    public void setRetailer(String retailer) {
        this.retailer = retailer;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }
    
    public double getDiscountedPrice() {
        return price * (100 - discount) / 100;
    }
    
    public List<Review> getReviews() {
        return reviews;
    }
    
    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }
}