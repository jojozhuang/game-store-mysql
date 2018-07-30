/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package johnny.gamestore.mysql.dao;

import java.util.ArrayList;
import java.util.List;

import johnny.gamestore.mysql.beans.User;
import johnny.gamestore.mysql.common.Constants;
import johnny.gamestore.mysql.common.SerializeHelper;

/**
 *
 * @author Johnny
 */
public class UserDao {
    private static UserDao dao;
    private static List<User> users = new ArrayList<User>();
    private UserDao() {}
    
    public static synchronized UserDao createInstance() {
        if (dao == null) {
            dao = new UserDao();
            init();
        }
        return dao;
    }
    
    private static void init() {
        if (SerializeHelper.exsitDataFile(Constants.DATA_FILE_USER)) {
            users = (List<User>)SerializeHelper.readFromFile(Constants.DATA_FILE_USER);
        } else {
            users = new ArrayList<User>();
            User user = new User("customer","customer", Constants.CONST_TYPE_CUSTOMER_LOWER);
            users.add(user);
            user = new User("storemanager","storemanager", Constants.CONST_TYPE_STOREMANAGER_LOWER);
            users.add(user);
            user = new User("salesman","salesman", Constants.CONST_TYPE_SALESMAN_LOWER);
            users.add(user);
            SerializeHelper.writeToFile(Constants.DATA_FILE_USER, users);
        }
    }
    
    public List<User> getUserList() {        
        return users;        
    }
    
    public int getUserCount() {
        return users.size();
    }
    
    public User getUser(String username) {
        for (User user: users) {
            if (user.getName().equalsIgnoreCase(username)) {
                return user;
            }
        }
        return null;
    }
    
    public boolean isExisted(String username) {
        return getUser(username) == null ? false : true;
    }
    
    public void addUser(User user) {        
        users.add(user);
        SerializeHelper.writeToFile(Constants.DATA_FILE_USER, users);
    }
    
    public void updateUser() {
        SerializeHelper.writeToFile(Constants.DATA_FILE_USER, users);
    }
    
    public void deleteUser(String username) {
        if (users==null || users.isEmpty()) {
            return;
        } 
        
        User user = getUser(username);
        if (user==null) {
            return;
        } else {
            users.remove(user);
        }
        SerializeHelper.writeToFile(Constants.DATA_FILE_USER, users);
    }
}
