<%@page import="johnny.gamestore.mysql.dao.ConsoleDao"%>
<%@page import="johnny.gamestore.mysql.common.Constants"%>
<%@page import="johnny.gamestore.mysql.common.Helper"%>
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
    
    if (errmsg.isEmpty()) {
        String consolekey = request.getParameter("consolekey");
        String accessorykey = request.getParameter("accessorykey");

        ConsoleDao dao = ConsoleDao.createInstance();
        if (!dao.isConsoleExisted(consolekey)) {
            errmsg = "No such console ["+consolekey+"] !";
        } else {
            if (!dao.isAccessoryExisted(consolekey, accessorykey)) {
                errmsg = "Accessory ["+accessorykey+"] does not exist!";
            } else {
                dao.deleteAccessory(consolekey, accessorykey);
                response.sendRedirect("admin_accessorylist.jsp");
            }            
        }
    }
    pageContext.setAttribute("errmsg", errmsg);
%>
<jsp:include page="layout_menu.jsp" />
<section id="content">
  <div>
    <h3>Delete Accessory</h3>
    <h3 style='color:red'>${errmsg}</h3>    
  </div>
</section>
<jsp:include page="layout_sidebar.jsp" />
<jsp:include page="layout_footer.jsp" />
