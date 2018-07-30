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
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import johnny.gamestore.mysql.beans.SelectorOption;
import java.util.ArrayList;

public class Helper {
    HttpServletRequest req;
    HttpSession session;

    public Helper(HttpServletRequest req) {
        this.req = req;
        this.session = req.getSession(true);
    }

    public boolean isLoggedin(){
        if (session.getAttribute(Constants.SESSION_USERNAME)==null)
            return false;
        return true;
    }

    public String username(){
        if (session.getAttribute(Constants.SESSION_USERNAME)!=null)
            return session.getAttribute(Constants.SESSION_USERNAME).toString();
        return "";
    }

    public String usertype(){
        if (session.getAttribute(Constants.SESSION_USERTYPE)!=null)
            return session.getAttribute(Constants.SESSION_USERTYPE).toString();
        return "";
    }
    
    public String getCurrentPage() {
        if (session.getAttribute(Constants.SESSION_CURRENTPAGE)!=null)
            return session.getAttribute(Constants.SESSION_CURRENTPAGE).toString();
        return "";
    }
    
    public void setCurrentPage(String page) {
        session.setAttribute(Constants.SESSION_CURRENTPAGE, page);
    }
    
    public List<SelectorOption> getUserTypeList() {
        List<SelectorOption> list = new ArrayList<SelectorOption>();
        list.add(new SelectorOption(Constants.CONST_TYPE_CUSTOMER_LOWER, Constants.CONST_TYPE_CUSTOMER));
        list.add(new SelectorOption(Constants.CONST_TYPE_STOREMANAGER_LOWER, Constants.CONST_TYPE_STOREMANAGER));
        list.add(new SelectorOption(Constants.CONST_TYPE_SALESMAN_LOWER, Constants.CONST_TYPE_SALESMAN));
        return list;
    }
    
    public List<SelectorOption> getMakerList() {
        List<SelectorOption> list = new ArrayList<SelectorOption>();
        list.add(new SelectorOption(Constants.CONST_ELECTRONICARTS_LOWER, Constants.CONST_ELECTRONICARTS));
        list.add(new SelectorOption(Constants.CONST_ACTIVISION_LOWER, Constants.CONST_ACTIVISION));
        list.add(new SelectorOption(Constants.CONST_TAKETWOINTERACTIVE_LOWER, Constants.CONST_TAKETWOINTERACTIVE));
        return list;
    }
    
    public List<SelectorOption> getConsoleList() {
        List<SelectorOption> list = new ArrayList<SelectorOption>();
        list.add(new SelectorOption("xboxone", "Microsoft-Xbox One"));
        list.add(new SelectorOption("xbox360", "Microsoft-Xbox 360"));
        list.add(new SelectorOption("ps3", "Sony-PS3"));
        list.add(new SelectorOption("ps4", "Sony-PS4"));
        list.add(new SelectorOption("wii", "Nintendo-Wii"));
        list.add(new SelectorOption("wiiu", "Nintendo-WiiU"));
        return list;
    }
   
    public String currentDate(){
        DateFormat dateFormat = new SimpleDateFormat("MM/dd/YYYY");
        Date date = new Date();
        return dateFormat.format(date).toString();
    }
    
    public String formatCurrency(double price) {        
        NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("en", "US"));
        return formatter.format(price);
    }
    
    public String formateDate(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        return sdf.format(date);
    }
    
    public String generateUniqueId() {
        Date dNow = new Date();
        SimpleDateFormat ft = new SimpleDateFormat("yyMMddhhmmssMs");
        return ft.format(dNow);
    }
}

