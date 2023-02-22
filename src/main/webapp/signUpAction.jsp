<%@ page import="DbConnect.ConnectionProvider" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="utitlity.EmailValidator" %>
<%@ page import="java.io.IOException" %>
<%@ page import="utitlity.PhoneValidator" %>
<%@ page import="utitlity.PasswordValidator" %>
<%@ page import="utitlity.bycrypt.ByCryptPasswordHashing" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2/13/2023
  Time: 4:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%
    //global var
    Connection conn = null;
    PreparedStatement ps = null;
    int rowCount = 0;
    String SAVE_USER_DETAILS = "INSERT INTO users (name, mail, " +
            "phone, security_question," +
            " security_question_answer," +
            " password, address," +
            " city, state, country)" +
            "values(?,?,?,?,?,?,?,?,?,?)";
    boolean isEmailValid = false;
    boolean isPhoneValid = false;
    boolean isPasswordValid = false;
    String hashed_u_pass = null;
%>
<%
    String u_name = request.getParameter("name").trim();
    String u_mail = request.getParameter("mail").trim().toLowerCase();
    String u_phone = request.getParameter("phone").trim();
    String s_question = request.getParameter("security_question");
    String s_answer = request.getParameter("security_question_answer").trim().toLowerCase();
    String u_pass = request.getParameter("password").trim();
    String u_address = "";
    String u_city = "";
    String u_state = "";
    String u_country = "";
%>
<%
//todo: validation
    if(u_name.length()<1){
        System.out.println("empty name provided");
        response.sendRedirect("signup.jsp?msg=failed");
        return;
//        throw new IOException();
        //todo: forward to error page
    }
    if(u_mail.length()<1){
        System.out.println("empty mail provided");
        response.sendRedirect("signup.jsp?msg=failed");
        return;
//        throw new IOException();
        //todo: forward to error page
    }
    //todo: regex for mail
    try {
        isEmailValid = EmailValidator.patternMatches(u_mail);
    }catch (IllegalArgumentException i){
        i.printStackTrace();
        response.sendRedirect("signup.jsp?msg=failed");
        return;
        //todo: forward message to a view
    }
    if(u_phone.length()<1){
        System.out.println("empty phone provided");
        response.sendRedirect("signup.jsp?msg=failed");
        return;
//        throw new IOException();
        //todo: forward to view
    }
    //todo: optional regex for phone
    try {
        isPhoneValid = PhoneValidator.patternMatches(u_phone);
    }catch (IllegalArgumentException f){
        f.printStackTrace();
        response.sendRedirect("signup.jsp?msg=phone_val");
        return;
        //todo: forward message to error page
    }

    if(s_question.length()<1){
        System.out.println("question not selected");
        response.sendRedirect("signup.jsp?msg=failed");
        return;
//        throw new IOException();
    }
    if(s_answer.length()<1){
        System.out.println("empty answer provided");
        response.sendRedirect("signup.jsp?msg=failed");
        return;
//        throw new IOException();
    }
    if(u_pass.length()<8){
        System.out.println("empty password provided");
        response.sendRedirect("signup.jsp?msg=failed");
        return;
//        throw new IOException();
    }
    //todo: optional regex for what password must contain
    try {
        isPasswordValid = PasswordValidator.patternMatches(u_pass);
    }catch (IllegalArgumentException p){
        p.printStackTrace();
        response.sendRedirect("signup.jsp?msg=failed");
        return;
        //todo: forward message to error page
    }
    //todo: hash the password
    if(isPasswordValid){
        hashed_u_pass = ByCryptPasswordHashing.hashPassword(u_pass);
    }
%>
<%
    //todo: save to db
    try {
        conn = ConnectionProvider.getConnObject();
        if(conn!=null){
            ps = conn.prepareStatement(SAVE_USER_DETAILS);
        }
        if(ps!=null ){
            ps.setString(1, u_name);
            ps.setString(2, u_mail);
            ps.setString(3, u_phone);
            ps.setString(4, s_question);
            ps.setString(5, s_answer);
            ps.setString(6, hashed_u_pass);
            ps.setString(7, u_address);
            ps.setString(8, u_city);
            ps.setString(9, u_state);
            ps.setString(10, u_country);
            rowCount = ps.executeUpdate();
        }
        System.out.println(rowCount);
        if(rowCount>0){
            System.out.println("data saved successfully");
            response.sendRedirect("signup.jsp?msg=success");
            return;
            //todo: forward to success page
        }

    } catch (Exception e) {
        System.err.println(e.getClass().getName() + " " + e.getMessage());
        response.sendRedirect("signup.jsp?msg=failed");
        System.exit(0);
        //todo: optional forward to an error page
    }finally {
        //todo:close conn
    }


%>
<%--<head>--%>
<%--    <title>Receives SignUp.jsp</title>--%>
<%--</head>--%>
<%--<body>--%>

<%--</body>--%>
<%--</html>--%>
