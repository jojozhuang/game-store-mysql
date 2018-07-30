/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package johnny.gamestore.mysql.beans;

/**
 *
 * @author Johnny
 */
public class OrderItem implements java.io.Serializable {
    private int orderitemid;
    private int orderid;
    private String productid;
    private String productname;
    private int producttype; //  1.Console 2.Accessory, 3.Game, 4.Tablet
    private double price;
    private String image;
    private String maker;    
    private double discount;
    private int quantity;

    public OrderItem() {

    }
    public OrderItem(int orderitemid, int orderid, String productid, String productname, int producttype, double price, String image, String maker, double discount, int quantity) {
        this.orderitemid = orderitemid;
        this.orderid = orderid;
        this.productid = productid;
        this.productname = productname;
        this.producttype = producttype;
        this.price = price;
        this.image = image;
        this.maker = maker;
        this.discount = discount;
        this.quantity = quantity;        
    }    

    public int getOrderItemId() {
        return this.orderitemid;
    }
    
    public void setOrderItemId(int orderitemid) {
        this.orderitemid = orderitemid;
    }
    
     public int getOrderId() {
        return this.orderid;
    }
    
    public void setOrderId(int orderid) {
        this.orderid = orderid;
    }
    
    
    public String getProductId() {
        return this.productid;
    }
    
    public void setProductId(String productid) {
        this.productid = productid;
    }
    
    public String getProductName() {
        return this.productname;
    }
    
    public void setProductName(String productname) {
        this.productname = productname;
    }

    public int getProductType() {
        return this.producttype;
    }
    
    public void setProductType(int producttype) {
        this.producttype = producttype;
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
    
    public String getMaker() {
        return maker;
    }
    
    public void setMaker(String maker) {
        this.maker = maker;
    }
    
    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }
    
    public double getUnitPrice() {
        return price * (100 - discount) / 100;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void incrementItemQuantity() {
        setQuantity(getQuantity() + 1);
    }

    public double getTotalCost() {
        return(getQuantity() * getUnitPrice());
    }
}

