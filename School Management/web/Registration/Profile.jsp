<%-- 
    Document   : Profile
    Created on : Nov 5, 2018, 7:28:18 PM
    Author     : DELL
--%>
<%@page import="student.*, teacher.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@include file="../layouts/Navigation.jsp" %>
        <%@include file="../layouts/Scripts.jsp" %>
        <%@include file="../layouts/Styles.jsp" %>
        
        <style>
            .card:hover {
                background-color: lime;
                color: red;
            }
            .card {
                margin-right: 50px;
                margin-left: 50px;
                width: 250px;
                height: 300px;
            }
            .card-header {
                height: 200px;
            }
            #row {
                margin-left: 0px;
                margin-right: 0px;
                margin-top: 20px;
            }
        </style>
    </head>
    <body class="w3-main">
        <% Student student = (Student) session.getAttribute("student"); 
           Teacher teacher = (Teacher) session.getAttribute("teacher");
        %>
        <div class="container-fluid">
            <% if (student != null) { %>
                <center><h1 class="modal-title">Welcome <%=student.getUsername() %></h1></center>
            <% } else if (teacher != null) { %>
                <center><h1 class="modal-title">Welcome <%=teacher.getUsername() %></h1></center>
            <% } %>    
            <div class="row" id="row">
                <div class="col-3">
                    <% if (student != null) { %>
                        <a href="edit_profile.jsp">
                            <div class="card">
                                <div class="card-header">
                                    <img src="../Images/edit_profile.png" class="img-fluid">
                                </div>
                                <div class="card-body">
                                    <p>Edit Profile</p>
                                </div>   
                            </div>
                        </a>
                    <% } else if (teacher != null) { %>
                        <a href="edit_teacher_profile.jsp">
                            <div class="card">
                                <div class="card-header">
                                    <img src="../Images/edit_profile.png" class="img-fluid">
                                </div>
                                <div class="card-body">
                                    <p>Edit Profile</p>
                                </div>   
                            </div>
                        </a>
                    <% } %>
                </div>
                <div class="col-3">
                    <% if (student != null) { %>
                        <a href="../student/student_progress.jsp">
                            <div class="card">
                                <div class="card-header">
                                    <img src="../Images/marks.jpg" class="img-fluid">
                                </div>
                                <div class="card-body">
                                    <p>View your progress</p>
                                </div>   
                            </div>
                        </a>
                    <% } else if (teacher != null) { %>
                        <a href="../teacher/mySubjects.jsp">
                            <div class="card">
                                <div class="card-header">
                                    <img src="../Images/marks.jpg" class="img-fluid">
                                </div>
                                <div class="card-body">
                                    <p>View my subjects</p>
                                </div>   
                            </div>
                        </a>
                    <% } %>
                </div>
                <div class="col-3">
                    <% if (student != null) { %>
                        <a href="../student/student_attendance.jsp">
                            <div class="card">
                                <div class="card-header">
                                    <img src="../Images/attendance.jpg" class="img-fluid">
                                </div>
                                <div class="card-body">
                                    <p>View your attendance</p>
                                </div>   
                            </div>
                        </a>
                    <% } else if (teacher != null) { 
                            if (teacher.isClassTeacher()) {
                    %>
                        <a href="../teacher/class_teacher.jsp">
                            <div class="card">
                                <div class="card-header">
                                    <img src="../Images/attendance.jpg" class="img-fluid">
                                </div>
                                <div class="card-body">
                                    <p>My Class</p>
                                </div>   
                            </div>
                        </a>
                        <% } else { %>
                        <a href="../teacher/timetable.jsp">
                            <div class="card">
                                <div class="card-header">
                                    <img src="../Images/attendance.jpg" class="img-fluid">
                                </div>
                                <div class="card-body">
                                    <p>View timetable</p>
                                </div>   
                            </div>
                        </a>
                        <% } %>
                    <% } %>
                </div>
            </div>
        </div>
    </body>
</html>
