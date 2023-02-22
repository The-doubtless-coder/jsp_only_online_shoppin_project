<%@ page import="DbConnect.ConnectionProvider" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2/13/2023
  Time: 11:54 AM
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>

<%
    Connection conn = null;
    ResultSet rs = null;
    Statement st = null;
    ResultSet rs1 = null;
    Statement st1 = null;
    int rowCount = 0;
    String CREATE_PRODUCT_TABLE_STATEMENT = "CREATE TABLE products" +
            "(id serial PRIMARY KEY NOT NULL, " +
            "name VARCHAR(200) not null," +
            "category VARCHAR(200) not null," +
            "price DECIMAL not null" +
            "status boolean not null)";
    String CREATE_USER_TABLE_STATEMENT = "CREATE TABLE users " +
            "(id serial PRIMARY KEY NOT NULL," +
            " name VARCHAR(100)   NOT NULL, " +
            "mail  VARCHAR(200) UNIQUE  NOT NULL, " +
            "phone  VARCHAR(15) UNIQUE NOT NULL, " +
            "security_question  VARCHAR(100) UNIQUE NOT NULL, " +
            "security_question_answer VARCHAR(100) NOT NULL, " +
            "password VARCHAR(200) NOT NULL, " +
            "address VARCHAR(200) UNIQUE NULL, " +
            "city VARCHAR(100) NULL, " +
            "state VARCHAR(100) NULL," +
            "country VARCHAR(100) NULL)";

try{
    conn = ConnectionProvider.getConnObject();
    if(conn!=null){
        st = conn.createStatement();
    }
    if(st!=null){
        System.out.println(CREATE_USER_TABLE_STATEMENT);
        System.out.println(CREATE_PRODUCT_TABLE_STATEMENT);
       rs = st.executeQuery(CREATE_USER_TABLE_STATEMENT);
       System.out.println("table created...");
    }
    if(rs!=null){
        if(rs.next()) {
            System.out.println("created....");
        }
    }
    assert conn != null;
    st1 = conn.createStatement();
    if(st1!=null) {
        rs1 = st1.executeQuery(CREATE_PRODUCT_TABLE_STATEMENT);
    }
//    null means absence of an object
//    empty means object is there but it has no value
    if(rs1!=null){
        System.out.println("products table created....");
    }

}catch (Exception s){
    System.err.println(s.getClass().getName() + " " + s.getMessage());
    s.printStackTrace();
}finally {
    try {
        if (st != null) {
            st.close();
        }
    }catch (SQLException e){
        e.printStackTrace();
    }
    try {
        if (conn != null) {
            conn.close();
        }
    }catch (SQLException f){
        f.printStackTrace();
    }
}
%>

<%--<html>--%>
<%--<head>--%>
<%--    <title>Create tables</title>--%>
<%--</head>--%>
<%--<body>--%>

<%--</body>--%>
<%--</html>--%>
