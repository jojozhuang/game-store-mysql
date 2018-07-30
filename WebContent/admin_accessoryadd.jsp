<%@page import="johnny.gamestore.mysql.common.Constants"%>
<%@page import="johnny.gamestore.mysql.dao.ConsoleDao"%>
<%@page import="johnny.gamestore.mysql.beans.Console"%>
<%@page import="johnny.gamestore.mysql.beans.Accessory"%>
<%@page import="johnny.gamestore.mysql.common.Helper"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="layout_top.jsp" />
<jsp:include page="layout_header.jsp" />
<%
    Helper helper = new Helper(request);
    helper.setCurrentPage(Constants.CURRENT_PAGE_ACCMNG);

    if(!helper.isLoggedin()){
        session.setAttribute(Constants.SESSION_LOGIN_MSG, "Please login first!");
        response.sendRedirect("account_login.jsp");
        return;
    }
    String usertype = helper.usertype();
    String errmsg = "";
    if (usertype==null || !usertype.equals(Constants.CONST_TYPE_STOREMANAGER_LOWER)) {
        errmsg = "You have no authorization to manage accessary!";
    }

    Accessory accessory =  null;
    String consolekey = "";
    
    if (errmsg.isEmpty()) {
         consolekey = request.getParameter("consolekey");
        if ("GET".equalsIgnoreCase(request.getMethod())) {
            accessory = new Accessory("controller", "microsoft", "Controller", 99.99,"consoles/xbox360.jpg", "Johnny Corp", "New", 30);
        } else {
            String name = request.getParameter("name");
            String price = request.getParameter("price");
            String image = request.getParameter("image");
            String retailer = request.getParameter("retailer");
            String condition = request.getParameter("condition");
            String discount = request.getParameter("discount");

            if(consolekey == null){
                errmsg = "Console can't be empty!";
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

            String key = consolekey + "_" + name.trim().toLowerCase();
            accessory = new Accessory(key, consolekey, name, dprice, image, retailer,condition,ddiscount);
            if (errmsg.isEmpty()) {
                ConsoleDao dao = ConsoleDao.createInstance();
                if(!dao.isConsoleExisted(consolekey)) {
                    errmsg = "No such console ["+consolekey+"] !";
                } else{                    
                    if (dao.isAccessoryExisted(consolekey, key)) {
                        errmsg = "Accessory ["+name+"] already exists!";
                    } else {                        
                        dao.addAccessory(consolekey, accessory);
                        errmsg = "Accessory ["+name+"] is created!";
                    }
                }
            }
        }
    }
    pageContext.setAttribute("errmsg", errmsg);
    pageContext.setAttribute("list", helper.getConsoleList());
    pageContext.setAttribute("consolekey", consolekey);
    pageContext.setAttribute("accessory", accessory);
%>
<jsp:include page="layout_menu.jsp" />
<section id="content">
  <div>
    <h3>Add Accessory</h3>
    <h3 style='color:red'>${errmsg}</h3>
    <form action="admin_accessoryadd.jsp" method="Post">
      <table style='width:50%'>
          <tr><td><h5>Console:</h5></td>
              <td>
                <select name='consolekey' class='input'>
                <c:forEach var="option" items="${list}">
                    <c:choose>
                        <c:when test="${option.key == consolekey}">
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
        <tr><td><h5>Name:</h5></td><td><input type='text' name='name' value='${accessory.name}' class='input' required /></td></tr>
        <tr><td><h5>Price:</h5></td><td><input type='text' name='price' value='${accessory.price}' class='input' required /></td></tr>
        <tr><td><h5>Image:</h5></td><td><input type='text' name='image' value='${accessory.image}' class='input' required /></td></tr>
        <tr><td><h5>Retailer:</h5></td><td><input type='text' name='retailer' value='${accessory.retailer}' class='input' required /></td></tr>
        <tr><td><h5>Condition:</h5></td><td><input type='text' name='condition' value='${accessory.condition}' class='input' required /></td></tr>
        <tr><td><h5>Discount:</h5></td><td><input type='text' name='discount' value='${accessory.discount}' class='input' required /></td></tr>
        <tr><td colspan="2"><input name="create" class="formbutton" value="Create" type="submit" /></td></tr>
      </table>
    </form>
  </div>
</section>
<jsp:include page="layout_sidebar.jsp" />
<jsp:include page="layout_footer.jsp" />