<%@ page import="DbConnect.ConnectionProvider" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.sun.scenario.effect.impl.sw.java.JSWBlend_SRC_OUTPeer" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2/18/2023
  Time: 11:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%
  //get parameters
  String product_id = request.getParameter("gen_prod_id").trim();
  String p_name = request.getParameter("product_name").trim();
  String active = request.getParameter("either_or").trim();
  String p_category = request.getParameter("product_category").trim();
  String p_price = request.getParameter("product_price").trim();
  //var
  Connection conn = null;
  PreparedStatement ps = null;
  int rowCount = 0;
  String SAVE_PRODUCT = "INSERT INTO products (product_id, name, active, category, price) VALUES (?,?,?,?,?)";

  //values to save
  int savable_p_id = Integer.parseInt(product_id);
  boolean savable_p_active = Boolean.parseBoolean(active);
  double savable_p_price = Double.parseDouble(p_price);

//some validations
  //todo: be more specific
  if(p_name.length()<1||p_category.length()<1||product_id.length()<1||active.length()<1||p_price.length()<1){
    response.sendRedirect("addNewProduct.jsp?msg=empty_val");
    return;
  }
  //store_in_the_db
  try {
    conn = ConnectionProvider.getConnObject();
    if(conn!=null){
      ps = conn.prepareStatement(SAVE_PRODUCT);
    }
    if(ps!=null){
      ps.setInt(1, savable_p_id);
      ps.setString(2, p_name);
      ps.setBoolean(3, savable_p_active);
      ps.setString(4, p_category);
      ps.setDouble(5, savable_p_price);
      rowCount = ps.executeUpdate();
    }
//    if(rowCount<1){
//      System.out.println("product not saved...");
//      response.sendRedirect("addNewProduct.jsp?msg=fail_save");
//      throw new RuntimeException("product not saved...");
//    }
    System.out.println("product saved successfully...");
    response.sendRedirect("addNewProduct.jsp?msg=product_saved");

  } catch (Exception e) {
    System.err.println(e.getClass().getName() + " " + e.getMessage());
    response.sendRedirect("addNewProduct.jsp?msg=sql_error");
  }
%>



<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<html>--%>
<%--  <head>--%>
<%--    <title>Title</title>--%>
<%--</head>--%>
<%--  <body>--%>

<%--</body>--%>
<%--</html>--%>
