<%-- 
    Document   : header
    Created on : Nov 4, 2018, 1:35:52 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="Styles.jsp" %>
    </head>
    
    <style>
        .row {
            background-color: lightgrey;
            height: 100px;
        }
        h1 {
            color: white;
            margin: auto;
            top: 0;
        }
    </style>
    <body class="w3-main">
        <div class="container-fluid">
            <div class="row">
                <h1 class="modal-title">International Educational Institute</h1>
            </div>
        </div>
        <%@include file="Scripts.jsp" %>
    </body>
</html>
