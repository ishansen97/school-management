<%-- 
    Document   : admin_navigation
    Created on : Nov 10, 2018, 3:56:01 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    <%@include file="Styles.jsp" %>
        
        <style>
/*        .nav-item:hover {
            background-color: red;
            color: red;
        }*/
/*        #header {
            background-color: lightgrey;
            height: 100px;
            color: white;
            margin-left: 0;
            margin-right: 0;
        }
        .nav-item:active {
            color: orange;
        }*/
        
    </style>
    </head>
    <body class="w3-main">
        <script>
            $(document).ready(function() {
                $('li').click(function() {
//                    $('li').removeClass();
//                    $(this).parent().addClass('active');
                    $(this).removeClass("nav-item");
//                    alert($(this).attr("class"));
                });
            });
        </script>
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <nav class="navbar navbar-expand-sm bg-light navbar-light">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a href="../Admin/admin_profile.jsp" class="nav-link">Profile</a>
                            </li>
                            <li class="nav-item">
                                <a href="../Admin/teacher.jsp" class="nav-link">Teacher Management</a>
                            </li>
                            <li class="nav-item">
                                <a href="../Admin/student.jsp" class="nav-link">Student Management</a>
                            </li>
                            <li class="nav-item">
                                <a href="../Admin/timetable.jsp" class="nav-link">Timetable Management</a>
                            </li>
                            <li class="nav-item">
                                <a href="../Admin/subject.jsp" class="nav-link">Subject Management</a>
                            </li>
                            <li class="nav-item">
                                <a href="../Admin/examination.jsp" class="nav-link">Examination Management</a>
                            </li>
                            <li class="nav-item">
                                <a href="../Admin/class_management.jsp" class="nav-link">Class Management</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
        <%@include file="Scripts.jsp" %>
    </body>
</html>
