/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package johnny.gamestore.mysql.common;

/**
 *
 * @author Johnny
 */
public class Constants {
    private Constants() { }  // Prevents instantiation
    
    // Serialized Data File
    public static final String DATA_FILE_CONSOLE = "Data_GameSpeed_Console";
    public static final String DATA_FILE_GAME = "Data_GameSpeed_Game";
    public static final String DATA_FILE_TABLET = "Data_GameSpeed_Tablet";
    public static final String DATA_FILE_USER = "Data_GameSpeed_User";
    public static final String DATA_FILE_ORDER = "Data_GameSpeed_Order";
    
    // Session
    public static final String SESSION_USERNAME = "username";
    public static final String SESSION_USERTYPE = "usertype";
    public static final String SESSION_CART = "cart";
    public static final String SESSION_ORDERS = "orders";
    public static final String SESSION_LOGIN_MSG = "login_msg";
    public static final String SESSION_CURRENTPAGE = "currentpage";
    public static final String SESSION_ORDERITEM = "orderitem";
    
    // Page
    public static final String CURRENT_PAGE_HOME = "Home";
    public static final String CURRENT_PAGE_CONSOLES = "Consoles";
    public static final String CURRENT_PAGE_ACCESSORIES = "Accessories";
    public static final String CURRENT_PAGE_GAMES = "Games";
    public static final String CURRENT_PAGE_TABLETS = "Tablets";
    public static final String CURRENT_PAGE_ACCMNG = "Accessory";
    public static final String CURRENT_PAGE_GAMEMNG = "Game";
    public static final String CURRENT_PAGE_USERMNG = "Users";
    public static final String CURRENT_PAGE_ALLORDERS = "All Orders";
    public static final String CURRENT_PAGE_MYORDER = "My Order";
    public static final String CURRENT_PAGE_CART = "Cart";
    
    // User
    public static final String CONST_TYPE_CUSTOMER = "Customer";
    public static final String CONST_TYPE_STOREMANAGER = "Store Manager";
    public static final String CONST_TYPE_SALESMAN = "Salesman";
    public static final String CONST_TYPE_CUSTOMER_LOWER = "customer";
    public static final String CONST_TYPE_STOREMANAGER_LOWER = "storemanager";
    public static final String CONST_TYPE_SALESMAN_LOWER = "salesman";
    
    // Console
    public static final String CONST_MICROSOFT = "Microsoft";
    public static final String CONST_SONY = "Sony";
    public static final String CONST_NINTENDO = "Nintendo";
    public static final String CONST_MICROSOFT_LOWER = "microsoft";
    public static final String CONST_SONY_LOWER = "sony";
    public static final String CONST_NINTENDO_LOWER = "nintendo";
    
    // Game
    public static final String CONST_ELECTRONICARTS = "Electronic Arts";
    public static final String CONST_ACTIVISION = "Activision";
    public static final String CONST_TAKETWOINTERACTIVE = "Take-Two Interactive";
    public static final String CONST_ELECTRONICARTS_LOWER = "electronicarts";
    public static final String CONST_ACTIVISION_LOWER = "activision";
    public static final String CONST_TAKETWOINTERACTIVE_LOWER = "taketwointeractive";
    
    // Tablet
    public static final String CONST_TABLET_APPLE = "Apple";
    public static final String CONST_TABLET_MICROSOFT = "Microsoft";
    public static final String CONST_TABLET_SAMSUNG = "Samsung";
    public static final String CONST_TABLET_APPLE_LOWER = "apple";
    public static final String CONST_TABLET_MICROSOFT_LOWER = "microsoft";
    public static final String CONST_TABLET_SAMSUNG_LOWER = "samsung";
}
