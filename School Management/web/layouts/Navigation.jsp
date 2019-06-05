<%-- 
    Document   : Navigation
    Created on : Nov 3, 2018, 8:24:37 PM
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
/*        .nav-item:hover {
            background-color: lightgray;
            color: green;
        }*/
        #header {
            background-color: lightgrey;
            height: 100px;
            color: white;
            margin-left: 0;
            margin-right: 0;
        }
        
    </style>
    
    <body class="w3-main">
        
        <div class="container-fluid">
            <div class="row" style="margin-left: 0px; margin-right: 0px">
                <div class="col-12" id="header">
                    <h1 class="modal-title" style="margin-top: 30px; margin-left: 500px">International Educational Institute</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <nav class="navbar navbar-expand-sm bg-primary navbar-dark">
                        <ul class="navbar-nav">
                            <li class="nav-item active">
                                <a href="#" class="navbar-brand">Home</a>
                            </li>
                            <li class="nav-item">
                                <a href="#" class="nav-link">Students</a>
                            </li>
                            <li class="nav-item">
                                <a href="#" class="nav-link">Teachers</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
        
        <%@include file="Scripts.jsp" %>
    </body>
</html>
