<%-- 
    Document   : timetable
    Created on : Nov 10, 2018, 2:05:49 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="../layouts/Navigation.jsp" %>
        <%@include file="../layouts/Scripts.jsp" %>
        <%@include file="../layouts/Styles.jsp" %>
        
    </head>
    <body class="w3-main">
        <%@include file="../layouts/admin_navigation.jsp" %>
        <div class="container-fluid">
            <div class="row">
                <ul class="nav nav-tabs justify-content-center" style="margin: auto; margin-top: 50px">
                    <li class="nav-item">
                        <a href="#create_timetable" data-toggle="tab" class="nav-link">Create Timetable</a>
                    </li>
                    <li class="nav-item">
                        <a href="#view_timetables" data-toggle="tab" class="nav-link">View Timetables</a>
                    </li>
                </ul>
            </div>
        </div>
        
        <!--tab content-->
        <div class="tab-content">
            <!--create timetable-->
            <div class="tab-pane container fade" id="create_timetable">
                <h1>create timetable</h1>
            </div>
            
            <!--viewing timetables-->
            <div class="tab-pane container fade" id="view_timetables">
                <h1>View timetables</h1>
            </div>
            
            <!--assign teachers-->
            <div class="tab-pane container fade" id="assign_teachers">
                <h1>Assigning Teachers</h1>
            </div>
        </div>
        
    </body>
</html>
