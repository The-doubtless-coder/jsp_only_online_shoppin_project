<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="DbConnect.ConnectionProvider" %>
<%@ page import="utitlity.bycrypt.ByCryptPasswordHashing" %>
<%@ page import="utitlity.PhoneValidator" %>
<%@ page import="utitlity.PasswordValidator" %>
<%@ page import="utitlity.EmailValidator" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2/17/2023
  Time: 11:49 AM
  To change this template use File | Settings | File Templates.
--%>
<%
  //variables
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  String CHECK_IF_USER_EXISTS = "SELECT name, security_question, security_question_answer FROM users where mail=? and phone=?";
  boolean isDataAvailable = false;
  String user_name;
  String user_question_db = null;
  String user_answer_db = null;
  boolean isQuestionMatch = false;
  boolean isAnswersMatch = false;
  String UPDATE_PASSWORD = "UPDATE users SET password=? WHERE mail=?";
  int rowCount = 0;
%>
<%
  //receive values
  String email = request.getParameter("mail").trim();
  String phoneNum = request.getParameter("telefona").trim();
  String question = request.getParameter("security_question").trim();
  String answer = request.getParameter("user_security_question_answer").trim();
  String newPassword = request.getParameter("new_pass").trim();
%>
<%
  //validations
  if(email.length()<1||phoneNum.length()<1||answer.length()<1){
    response.sendRedirect("forgotPassword.jsp?msg=empty_value");
    return;
  }
  //todo: set validations to new password
  try {
    PasswordValidator.patternMatches(newPassword);
  }catch (IllegalArgumentException e){
    e.printStackTrace();
    response.sendRedirect("forgotPassword.jsp?msg=genuine_password");
    return;
  }
//todo: valiate the phone before checking it in the db
  try{
    PhoneValidator.patternMatches(phoneNum);
  }catch (IllegalArgumentException p){
    p.printStackTrace();
    response.sendRedirect("forgotPassword.jsp?msg=phone_val");
    return;
  }
  //todo: validate email before querying db with it\
  try{
    EmailValidator.patternMatches(email);
  }catch (IllegalArgumentException i){
    i.printStackTrace();
    response.sendRedirect("forgotPassword.jsp?msg=invalid_mail");
    return;
  }
  //check if user exists
  try{
    conn = ConnectionProvider.getConnObject();
    if(conn!=null){
      ps = conn.prepareStatement(CHECK_IF_USER_EXISTS);
    }
    if (ps != null) {
      ps.setString(1, email);
      ps.setString(2, phoneNum);
      rs = ps.executeQuery();
    }
    assert rs != null;
    if(rs.next()){
      isDataAvailable = true;
      user_name = rs.getString(1);
      user_question_db = rs.getString(2);
      user_answer_db = rs.getString(3);
      System.out.println(user_name + " " + user_question_db + " " + user_answer_db);
    }else {
      System.out.println("email and phone combination not found in db");
      response.sendRedirect("forgotPassword.jsp?msg=no_match");
      return;
    }
    if(isDataAvailable){
      //compare given question and answer
      isQuestionMatch = question.equalsIgnoreCase(user_question_db);
      isAnswersMatch = answer.equalsIgnoreCase(user_answer_db);
    }
    if(!isAnswersMatch||!isQuestionMatch){
      if(!isQuestionMatch&&!isAnswersMatch){
        System.out.println("no match between both answers and questions");
        response.sendRedirect("forgotPassword.jsp?msg=both_no_match");
        return;
      }
      if(!isQuestionMatch){
        System.out.println("only questions don't match");
        response.sendRedirect("forgotPassword.jsp?msg=question_no_match");
        return;
      }
      if(!isAnswersMatch){
        System.out.println("answers do not match");
        response.sendRedirect("forgotPassword.jsp?msg=answer_no_match");
        return;
      }
    }
    //todo: whether to use two try catches
    if(isQuestionMatch&&isAnswersMatch){
      //query db and alter password
      ps = conn.prepareStatement(UPDATE_PASSWORD);
      if(ps!=null){
        ps.setString(1, ByCryptPasswordHashing.hashPassword(newPassword));
        ps.setString(2, email);
        rowCount = ps.executeUpdate();
      }
      if(rowCount>0){
        System.out.println("password changed successfully");
        response.sendRedirect("forgotPassword.jsp?msg=success");
        return;
      }
      if(rowCount<1){
        System.out.println("no changes happened!");
        response.sendRedirect("forgotPassword.jsp?msg=fail");
        //todo: view for this
      }

    }


  }catch (Exception s){
    System.err.println(s.getClass().getName() + " " + s.getMessage());
    response.sendRedirect("forgotPassword.jsp?msg=sql_err");
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
