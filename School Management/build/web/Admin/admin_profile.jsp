<%-- 
    Document   : admin_profile
    Created on : Nov 10, 2018, 1:14:26 PM
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
                height: 150px;
            }
            #row {
                margin-left: 0px;
                margin-right: 0px;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">   
            <div class="row" id="row">
                <div class="col-3">
                    <a href="../Admin/teacher.jsp">
                        <div class="card">
                            <div class="card-header">
                                <img src="../Images/teachers.jpg" class="img-fluid">
                            </div>
                            <div class="card-body">
                                <p>Teacher management</p>
                            </div>   
                        </div>
                    </a>
                </div>
                <div class="col-3">
                    <a href="../Admin/student.jsp">
                        <div class="card">
                            <div class="card-header">
                                <img src="../Images/students.jpg" class="img-fluid">
                            </div>
                            <div class="card-body">
                                <p>Student Management</p>
                            </div>   
                        </div>
                    </a>
                </div>
                <div class="col-3">
                    <a href="../Admin/timetable.jsp">
                        <div class="card">
                            <div class="card-header">
                                <img src="../Images/timetable.jpg" class="img-fluid">
                            </div>
                            <div class="card-body">
                                <p>View Timetables</p>
                            </div>   
                        </div>
                    </a>
                </div>
                <div class="col-3">
                    <a href="../Admin/subject.jsp">
                        <div class="card">
                            <div class="card-header">
                                <img src="../Images/subjects.jpg" class="img-fluid">
                            </div>
                            <div class="card-body">
                                <p>Subject Management</p>
                            </div>   
                        </div>
                    </a>
                </div>
            </div>
            
            <div class="row" id="row">
                <div class="col-3">
                    <a href="../Admin/attendance.jsp">
                        <div class="card">
                            <div class="card-header">
                                <img src="../Images/attendance.jpg" class="img-fluid">
                            </div>
                            <div class="card-body">
                                <p>Student and Teacher Attendance</p>
                            </div>   
                        </div>
                    </a>
                </div>
                
                <div class="col-3">
                    <a href="../Admin/examination.jsp">
                        <div class="card">
                            <div class="card-header">
                                <img src="../Images/attendance.jpg" class="img-fluid">
                            </div>
                            <div class="card-body">
                                <p>Examination Management</p>
                            </div>   
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </body>
</html>
