<%@page import="johnny.gamestore.mysql.db.OrderDB"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="johnny.gamestore.mysql.beans.Menu"%>
<%@page import="johnny.gamestore.mysql.beans.ShoppingCart"%>
<%@page import="johnny.gamestore.mysql.dao.UserDao"%>
<%@page import="johnny.gamestore.mysql.common.Constants" %>
<%@page import="johnny.gamestore.mysql.common.Helper" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Helper helper = new Helper(request);
    String currentPage = helper.getCurrentPage();
    
    List<Menu> list = new ArrayList<Menu>();
    list.add(new Menu(Constants.CURRENT_PAGE_HOME, "index.jsp"));
    list.add(new Menu(Constants.CURRENT_PAGE_CONSOLES, "consolelist.jsp"));
    list.add(new Menu(Constants.CURRENT_PAGE_ACCESSORIES, "accessorylist.jsp"));    
    list.add(new Menu(Constants.CURRENT_PAGE_GAMES, "gamelist.jsp"));
    list.add(new Menu(Constants.CURRENT_PAGE_TABLETS, "tabletlist.jsp"));
    
    List<Menu> userlist = new ArrayList<Menu>();
    String usertype = helper.usertype();
    if (usertype.toLowerCase().equals(Constants.CONST_TYPE_STOREMANAGER_LOWER)) {        
        userlist.add(new Menu(Constants.CURRENT_PAGE_ACCMNG, "admin_accessorylist.jsp"));
        userlist.add(new Menu(Constants.CURRENT_PAGE_GAMEMNG, "admin_gamelist.jsp"));
    } else if (usertype.toLowerCase().equals(Constants.CONST_TYPE_SALESMAN_LOWER)) {
        userlist.add(new Menu(Constants.CURRENT_PAGE_ALLORDERS, "All Order("+OrderDB.getList().size()+")", "admin_orderlist.jsp"));
        UserDao userdao = UserDao.createInstance();
        userlist.add(new Menu(Constants.CURRENT_PAGE_USERMNG, "User("+userdao.getUserCount()+")", "admin_userlist.jsp"));
    }
    // My Order
    int ordercount = 0;
    if (helper.isLoggedin()) {
        ordercount = OrderDB.getList(helper.username()).size();
    }
    userlist.add(new Menu(Constants.CURRENT_PAGE_MYORDER, "My Order("+ordercount+")","myorder.jsp"));
    
    // Cart
    int cartcount = 0;
    if (helper.isLoggedin()) {
        ShoppingCart cart = (ShoppingCart)session.getAttribute(Constants.SESSION_CART);
        if (cart != null) {
            cartcount = cart.getItems().size();
        }            
    }
    userlist.add(new Menu(Constants.CURRENT_PAGE_CART, "Cart("+cartcount+")", "mycart.jsp"));    
    
    pageContext.setAttribute("currentPage", currentPage);
    pageContext.setAttribute("list", list);
    pageContext.setAttribute("userlist", userlist);
%>
<div>
  <nav>    
    <div style="float: left; ">
        <ul>
        <c:forEach var="siteitem" items="${list}">
            <c:choose>
                <c:when test="${siteitem.name == currentPage}">
                    <li class="selected">
                </c:when>
                <c:otherwise>
                    <li>
                </c:otherwise>
            </c:choose>
            <a href='${siteitem.url}'>${siteitem.title}</a></li>
        </c:forEach>
        </ul>
    </div>
    <div id="menu" style="float: right;">
      <ul>
        <c:forEach var="useritem" items="${userlist}">
            <c:choose>
                <c:when test="${useritem.name == currentPage}">
                    <li class="selected">
                </c:when>
                <c:otherwise>
                    <li>
                </c:otherwise>
            </c:choose>
            <a href='${useritem.url}'>${useritem.title}</a></li>
        </c:forEach>
        </ul>
    </div>
  </nav>
</div>
<div id="body">
