<%-- 
    Document   : student_profile_navigation
    Created on : Nov 27, 2018, 7:34:26 PM
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
        #header {
            background-color: lightgrey;
            height: 100px;
            color: white;
            margin-left: 0;
            margin-right: 0;
        }
        .nav-item:active {
            color: orange;
        }
        
    </style>
    </head>
    <body class="w3-main">
        <script>
//            $(document).ready(function() {
//                $('li').click(function() {
////                    $('li').removeClass();
////                    $(this).parent().addClass('active');
//                    $(this).removeClass("nav-item");
//                    alert($(this).attr("class"));
//                });
//            });
        </script>
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <nav class="navbar navbar-expand-sm bg-light navbar-light">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a href="../Registration/Profile.jsp" class="nav-link">Profile</a>
                            </li>
                            <li class="nav-item">
                                <a href="../Registration/edit_profile.jsp" class="nav-link">Edit Profile</a>
                            </li>
                            <li class="nav-item">
                                <a href="../student/student_progress.jsp" class="nav-link">View Subjects</a>
                            </li>
                            <li class="nav-item active">
                                <a href="../teacher/timetable.jsp" class="nav-link">View Attendance</a>
                            </li>
                            <li class="nav-item active">
                                <a href="../Registration/logout.jsp" class="nav-link">Log out</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
        <%@include file="Scripts.jsp" %>
    </body>
</html>
