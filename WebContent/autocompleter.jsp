<%@page import="java.util.ArrayList"%>
<%@page import="johnny.gamestore.mysql.dao.ProductDao"%>
<%@page import="com.google.gson.Gson"%>

<%
    response.setContentType("application/json");
    try {
        String term = request.getParameter("term");

        ProductDao dao = ProductDao.createInstance();
        ArrayList<String> list = dao.autoCompleteProducts(term);

        String searchList = new Gson().toJson(list);
        response.getWriter().write(searchList);
    } catch (Exception e) {
        System.err.println(e.getMessage());
    }
%>
