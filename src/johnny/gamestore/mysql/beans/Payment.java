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
public class Payment {
    private String name;
    private String address;
    private String creditcard;
    
    public Payment(String name, String address, String creditcard) {
        this.name = name;
        this.address = address;
        this.creditcard = creditcard;
    }
     
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getCreditCard() {
        return creditcard;
    }

    public void setCreditCard(String creditcard) {
        this.creditcard = creditcard;
    }
}
