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
        errmsg = "You have no authorization to manage accessory!";
    }
    
    Accessory accessory = null;
    String consolekey = "";
    
    if (errmsg.isEmpty()) {
        consolekey = request.getParameter("consolekey");
        String accessorykey = request.getParameter("accessorykey");
        if (consolekey == null || consolekey.isEmpty() || accessorykey == null || accessorykey.isEmpty()) {
            errmsg = "Invalida parameter. Cannot find the accessory with key: " + accessorykey;
        } else {
            ConsoleDao dao = ConsoleDao.createInstance();
            accessory = dao.getAccessory(consolekey, accessorykey);
            if (accessory == null) {
                errmsg = "Accessory ["+accessorykey+"] does not exist!";
            } else {
                if ("GET".equalsIgnoreCase(request.getMethod())) {            

                } else {
                    String name = request.getParameter("name");
                    String price = request.getParameter("price");
                    String image = request.getParameter("image");
                    String retailer = request.getParameter("retailer");
                    String condition = request.getParameter("condition");
                    String discount = request.getParameter("discount");

                    if(name == null){
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
                    accessory.setName(name);
                    accessory.setPrice(dprice);
                    accessory.setImage(image);
                    accessory.setRetailer(retailer);
                    accessory.setCondition(condition);
                    accessory.setDiscount(ddiscount);
                    if (errmsg.isEmpty()) {
                        dao.updateAccessory();
                        errmsg = "Accessory ["+accessory.getName()+"] is updated!";
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
    <h3>Edit Accessory</h3>
    <h3 style='color:red'><%=errmsg%></h3>
    <form action="admin_accessoryedit.jsp" method="Post">
      <input type='hidden' name='consolekey' value='${consolekey}'>
      <input type='hidden' name='accessorykey' value='${accessory.key}'>
      <table style='width:50%'>
        <tr><td><h5>Console:</h5></td>
            <td>
                <select name='facconsole' class='input' disabled>
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
        <tr><td colspan="2"><input name="create" class="formbutton" value="Save" type="submit" /></td></tr>
      </table>
    </form>
  </div>
</section>
<jsp:include page="layout_sidebar.jsp" />
<jsp:include page="layout_footer.jsp" />