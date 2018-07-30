<%@page import="johnny.gamestore.mysql.common.Constants"%>
<%@page import="johnny.gamestore.mysql.dao.GameDao"%>
<%@page import="johnny.gamestore.mysql.beans.Game"%>
<%@page import="johnny.gamestore.mysql.common.Helper"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="layout_top.jsp" />
<jsp:include page="layout_header.jsp" />
<%
    Helper helper = new Helper(request);
    helper.setCurrentPage(Constants.CURRENT_PAGE_GAMEMNG);
    if(!helper.isLoggedin()){
        session.setAttribute(Constants.SESSION_LOGIN_MSG, "Please login first!");
        response.sendRedirect("account_login.jsp");
        return;
    }
    String usertype = helper.usertype();
    String errmsg = "";
    if (usertype==null || !usertype.equals(Constants.CONST_TYPE_STOREMANAGER_LOWER)) {
        errmsg = "You have no authorization to manage game!";
    }
    
    Game game = null;
    
    if (errmsg.isEmpty()) {
        if ("GET".equalsIgnoreCase(request.getMethod())) {
            game = new Game("game1", "electronicarts", "Game1", 59.99,"games/activision_cod.jpg", "Activision", "New", 15);
        } else {
            String maker = request.getParameter("maker");
            String name = request.getParameter("name");
            String price = request.getParameter("price");
            String image = request.getParameter("image");
            String retailer = request.getParameter("retailer");
            String condition = request.getParameter("condition");
            String discount = request.getParameter("discount");

            if(maker == null){
                errmsg = "Maker can't be empty!";
            }else if(name == null){
                errmsg = "Name can't be empty!";
            }else if(price == null){
                errmsg = "Price can't be empty!";
            }else if(image == null){
                errmsg = "Image can't be empty!";
            }else if(retailer == null){
                errmsg = "Retailer can't be empty!";
            }else if(condition == null){
                errmsg = "Condition can't be empty!";
            }else if(discount == null){
                errmsg = "Discount can't be empty!";
            }
            
            double dprice = 0.0;
            if (errmsg.isEmpty()) {
                try {
                    dprice = Double.parseDouble(price);
                } catch (NumberFormatException nfe) {
                    errmsg = "Price must be number!";
                }
            }
            double ddiscount = 0.0;
            if (errmsg.isEmpty()) {
                try {
                    ddiscount = Double.parseDouble(discount);
                } catch (NumberFormatException nfe) {
                    errmsg = "Discount must be number!";
                }
                if (errmsg.isEmpty() && (ddiscount < 0 || ddiscount > 100)) {
                    errmsg = "Discount must be between 0 and 100!";
                }
            }

            String key = name.trim().toLowerCase();
            game = new Game(key, maker, name, dprice, image, retailer,condition,ddiscount);
            
            if (errmsg.isEmpty()) {                
                GameDao dao = GameDao.createInstance();
                if(dao.isExisted(key)) {
                    errmsg = "Game ["+name+"] already exist!";
                } else{                    
                    dao.addGame(game);
                    errmsg = "Game ["+name+"] is created!";
                }
            }
        }
    }
    pageContext.setAttribute("errmsg", errmsg);
    pageContext.setAttribute("list", helper.getMakerList());
    pageContext.setAttribute("game", game);
%>
<jsp:include page="layout_menu.jsp" />
<section id="content">
  <div>
    <h3>Add Game</h3>
    <h3 style='color:red'>${errmsg}</h3>
    <form action="admin_gameadd.jsp" method="Post">
      <table style='width:50%'>
        <tr><td><h5>Maker:</h5></td>
            <td>
                <select name='maker' class='input'>
                <c:forEach var="option" items="${list}">
                    <c:choose>
                        <c:when test="${option.key == game.maker.toLowerCase()}">
                            <option value=${option.key} selected>${option.text}</option>
                        </c:when>
                        <c:otherwise>
                            <option value=${option.key}>${option.text}</option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>  
                </select>
            </td>
        </tr>
        <tr><td><h5>Name:</h5></td><td><input type='text' name='name' value='${game.name}' class='input' required /></td></tr>
        <tr><td><h5>Price:</h5></td><td><input type='text' name='price' value='${game.price}' class='input' required /></td></tr>
        <tr><td><h5>Image:</h5></td><td><input type='text' name='image' value='${game.image}' class='input' required /></td></tr>
        <tr><td><h5>Retailer:</h5></td><td><input type='text' name='retailer' value='${game.retailer}' class='input' required /></td></tr>
        <tr><td><h5>Condition:</h5></td><td><input type='text' name='condition' value='${game.condition}' class='input' required /></td></tr>
        <tr><td><h5>Discount:</h5></td><td><input type='text' name='discount' value='${game.discount}' class='input' required /></td></tr>
        <tr><td colspan="2"><input name="create" class="formbutton" value="Create" type="submit" /></td></tr>
      </table>
    </form>
  </div>
</section>
<jsp:include page="layout_sidebar.jsp" />
<jsp:include page="layout_footer.jsp" />