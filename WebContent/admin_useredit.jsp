<%@page import="java.util.ArrayList"%>
<%@page import="johnny.gamestore.mysql.beans.SelectorOption"%>
<%@page import="java.util.List"%>
<%@page import="johnny.gamestore.mysql.common.Constants"%>
<%@page import="johnny.gamestore.mysql.dao.UserDao"%>
<%@page import="johnny.gamestore.mysql.beans.User"%>
<%@page import="johnny.gamestore.mysql.common.Helper"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="layout_top.jsp" />
<jsp:include page="layout_header.jsp" />
<%
    Helper helper = new Helper(request);
    helper.setCurrentPage(Constants.CURRENT_PAGE_USERMNG);
    if(!helper.isLoggedin()){
        session.setAttribute(Constants.SESSION_LOGIN_MSG, "Please login first!");
        response.sendRedirect("account_login.jsp");
        return;
    }
    String usertype = helper.usertype();
    String errmsg = "";
    if (usertype==null || !usertype.equals(Constants.CONST_TYPE_SALESMAN_LOWER)) {
        errmsg = "You have no authorization to manage user!";
    }
        
    String name = request.getParameter("name");
    if (name==null||name.isEmpty()) {
        errmsg = "Invalid Paramters!";
    }
    
    User user = null;
    if (errmsg.isEmpty()) {
        UserDao dao = UserDao.createInstance();
        user = dao.getUser(name);
        if (user == null) {
            errmsg = "User ["+name+"] does not exist!";
        } else {
            if ("GET".equalsIgnoreCase(request.getMethod())) {                

            } else {
                String password = request.getParameter("password");
                if(password == null||password.isEmpty()){
                    errmsg = "Password can't be empty!";
                }
                if (errmsg.isEmpty()) {
                    user.setPassword(password);
                    errmsg = "User ["+name+"] is updated!";
                }
            }
        }
    }
    pageContext.setAttribute("errmsg", errmsg);
    pageContext.setAttribute("list", helper.getUserTypeList());
    pageContext.setAttribute("user", user);
%>
<jsp:include page="layout_menu.jsp" />
<section id="content">
  <div>
    <h3>Edit User</h3>
    <h3 style='color:red'>${errmsg}</h3>
    <form action="admin_useredit.jsp" method="Post">
      <input type='hidden' name='usertype' value='${user.usertype}'>
      <input type='hidden' name='name' value='${user.name}'>
      <table style='width:50%'>
        <tr><td><h5>User Type:</h5></td>
            <td>
                <select name='usertype' class='input' disabled>
                <c:forEach var="option" items="${list}">
                    <c:choose>
                        <c:when test="${option.key == user.usertype.toLowerCase()}">
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
        <tr><td><h5>Name:</h5></td><td><input type='text' name='name' value='${user.name}' class='input' required disabled/></td></tr>
        <tr><td><h5>Password:</h5></td><td><input type='text' name='password' value='${user.password}' class='input' required /></td></tr>
        <tr><td colspan="2"><input name="create" class="formbutton" value="Save" type="submit" /></td></tr>
      </table>
    </form>
  </div>
</section>
<jsp:include page="layout_sidebar.jsp" />
<jsp:include page="layout_footer.jsp" />