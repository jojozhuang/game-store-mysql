<%@page import="johnny.gamestore.mysql.dao.UserDao"%>
<%@page import="johnny.gamestore.mysql.beans.User"%>
<%@page import="johnny.gamestore.mysql.common.Constants"%>
<%@page import="johnny.gamestore.mysql.common.Helper"%>

<jsp:include page="layout_top.jsp" />
<jsp:include page="layout_header.jsp" />
<%
    Helper helper = new Helper(request);
    helper.setCurrentPage(Constants.CURRENT_PAGE_HOME);
    
    String errmsg = "";
    User user = null;

    if ("GET".equalsIgnoreCase(request.getMethod())) {
        
    } else {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String usertype = request.getParameter("usertype");        
        user = new User(username,password,usertype);

        UserDao dao = UserDao.createInstance();
        User cmpuser = dao.getUser(username);
        if(cmpuser!=null){
            String user_password = cmpuser.getPassword();
            String user_usertype = cmpuser.getUsertype();
            if (password.equals(user_password)&&usertype.equals(user_usertype)) {
                session.setAttribute(Constants.SESSION_USERNAME, user.getName());
                session.setAttribute(Constants.SESSION_USERTYPE, user.getUsertype());
                response.sendRedirect("index.jsp");
                return;
            }
        }
        errmsg = "Login failed! <br>Please check your username, password and user type!";
    }
    
    if (errmsg.isEmpty()) {
        if(session.getAttribute(Constants.SESSION_LOGIN_MSG)!=null){
            errmsg = session.getAttribute(Constants.SESSION_LOGIN_MSG) + "";
            session.removeAttribute(Constants.SESSION_LOGIN_MSG);
        }
    }
    
    request.setAttribute("errmsg", errmsg);
    request.setAttribute("user", user);
%>
<jsp:include page="layout_menu.jsp" />
<section id="content">
  <div class="post">
    <h3 style='color:red'>${errmsg}</h3>   
    <form action="account_login.jsp" method="Post">
      <table style='width:50%'>
        <tr><td><h5>User Name:</h5></td><td><input type='text' name='username' value='${user.name}' class='input' required /></td></tr>
        <tr><td><h5>Password:</h5></td><td><input type='password' name='password' value='${user.password}' class='input' required /></td></tr>
        <tr><td><h5>User Type</h5></td><td><select name='usertype' class='input'><option value='customer' selected>Customer</option><option value='storemanager'>Store Manager</option><option value='salesman'>Salesman</option></select></td></tr>
        <tr><td colspan="2"><input name="login" class="formbutton" value="Login" type="submit" /></td></tr>
        <tr><td colspan="2"><strong><a class='' href='account_register.jsp'>New User? Register here!</a></strong></td></tr>
      </table>
    </form>
  </div>
</section>
<jsp:include page="layout_footer.jsp" />