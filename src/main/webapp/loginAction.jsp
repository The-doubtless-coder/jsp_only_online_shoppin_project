<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="DbConnect.ConnectionProvider" %>
<%@ page import="utitlity.bycrypt.ByCryptPasswordHashing" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2/15/2023
  Time: 11:05 PM
  To change this template use File | Settings | File Templates.
--%>

<%
//  variables
String FIND_USER = "SELECT name, mail, password FROM users WHERE mail=?";
String u_email = request.getParameter("u_email").trim().toLowerCase();
String u_pass = request.getParameter("u_password").trim();
boolean isAMatch = false;
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;

%>
<%
//  validations
  if(u_email.length()<1){
    System.out.println("empty email passed");
    response.sendRedirect("login.jsp?msg=empty_mail");
    return;
  }
  if(u_pass.length()<1){
    System.out.println("empty password passed");
    response.sendRedirect("login.jsp?msg=empty_pass");
    return;
  }
%>
<%
//admin login
if(u_email.equals("admin@gmail.com") && u_pass.equals("admin")){
  session.setAttribute("login-id", u_email);
  response.sendRedirect("admin/adminHome.jsp");
  return;
}
%>
<%
//  query the db
  try{
    conn = ConnectionProvider.getConnObject();
    if(conn!=null){
      ps = conn.prepareStatement(FIND_USER);
    }
    if(ps!=null){
      ps.setString(1, u_email);
      rs = ps.executeQuery();
    }
    assert rs != null;
    if(rs.next()){
      System.out.println(rs.getString(1));
      System.out.println(rs.getString(3));
      isAMatch = ByCryptPasswordHashing.checkPassword(u_pass, rs.getString(3));
    }else {
      System.out.println("user not in our db");
      response.sendRedirect("login.jsp?msg=user_not_registered");
      return;
    }
    if(isAMatch){
      //todo:manage session
      session.setAttribute("login-id", u_email);
//      todo:send success view
      response.sendRedirect("home.jsp");
      System.out.println("login success");
      return;
    }else {
      System.out.println("wrong password provided");
      response.sendRedirect("login.jsp?msg=wrong_pass");
      return;
//      todo:send fail view
    }
  }catch(Exception e){
    System.err.println(e.getClass().getName() + " " + e.getMessage());
    response.sendRedirect("login.jsp?msg=sql_error");
//    e.printStackTrace();
  }finally {
//    close conn
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
