<%-- 
    Document   : login
    Created on : Nov 3, 2018, 8:21:09 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title> 
        <%@include file="../layouts/Navigation.jsp" %>
        <%@include file="../layouts/Scripts.jsp" %>
        <%@include file="../layouts/Styles.jsp" %>
        
        <style>
        .card {
            margin: auto; 
            height: 500px; 
            width: 500px; 
            border: 1px solid blue; 
            margin-top: 100px;
        }
        
        input[type=text], input[type=password] {
            height: 40px;
        }
        
        .form-group {
            margin-top: 20px;
        }
    </style>
    </head>
    
    <body class="w3-main">
        <script>
            function showPassword() {
                var pass = document.getElementById("pass");
                
                if (pass.type === "password") {
                    pass.type = "text";
                }
                else {
                    pass.type = "password";
                }
            }
        </script>
        
        <div class="container">
            <div class="row">
                <div class="card">
                    <div class="card-header">
                        <h1 class="modal-title">Start from here!!!</h1>
                    </div>
                    <div class="card-body bg-primary">
                        <form action="<%=request.getContextPath() %>/LoginServlet" name="loginForm" class="form-control">
                            <label><b>Select User Type</b></label>
                            <div class="form-check">
                                <label class="form-check-label">
                                    <input type="radio" class="form-check-input" name="userType" value="student">Student
                                </label>
                            </div>
                            <div class="form-check">
                                <label class="form-check-label">
                                    <input type="radio" class="form-check-input" name="userType" value="teacher">Teacher
                                </label>
                            </div>
                            <div class="form-group">
                                <label for="username"><b>Username</b></label>
                                <input type="text" class="form-control" name="username" required>
                            </div>
                            <div class="form-group">
                                <label for="password"><b>Password</b></label>
                                <input type="password" class="form-control" name="password" id="pass" required>
                            </div>
                            <div class="form-check-inline">
                                <input type="checkbox" class="form-check-input" onclick="showPassword()">
                                <label class="form-check-label">Show password</label>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-success form-control">Login</button>
                                <p>Not a member? <a href="registration.jsp">Register</a></p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
