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
    String currentusertype = helper.usertype();
    String errmsg = "";
    if (currentusertype==null || !currentusertype.equals(Constants.CONST_TYPE_SALESMAN_LOWER)) {
        errmsg = "You have no authorization to manage user!";
    }
    
    User user = null;
            
    if (errmsg.isEmpty()) {
        if ("GET".equalsIgnoreCase(request.getMethod())) {
            user = new User("Name1", "123456", "customer");
        } else {
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            String usertype = request.getParameter("usertype");

            if(name == null){
                errmsg = "Name can't be empty!";
            }else if(password == null){
                errmsg = "Password can't be empty!";
            }else if(usertype == null){
                errmsg = "User Type can't be empty!";
            }

            user = new User(name, password, usertype);
            if (errmsg.isEmpty()) {
                UserDao dao = UserDao.createInstance();
                if(dao.isExisted(name)) {
                    errmsg = "User ["+name+"] already exist!";
                } else{                    
                    dao.addUser(user);
                    errmsg = "User ["+name+"] is created!";
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
    <h3>Add User</h3>
    <h3 style='color:red'>${errmsg}</h3>
    <form action="admin_useradd.jsp" method="Post">
      <table style='width:50%'>
        <tr><td><h5>User Type:</h5></td>
            <td>
                <select name='usertype' class='input'>
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
        <tr><td><h5>Name:</h5></td><td><input type='text' name='name' value='${user.name}' class='input' required /></td></tr>
        <tr><td><h5>Password:</h5></td><td><input type='text' name='password' value='${user.password}' class='input' required /></td></tr>
        <tr><td colspan="2"><input name="create" class="formbutton" value="Create" type="submit" /></td></tr>
      </table>
    </form>
  </div>
</section>
<jsp:include page="layout_sidebar.jsp" />
<jsp:include page="layout_footer.jsp" />