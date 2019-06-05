<%-- 
    Document   : admin_login
    Created on : Nov 10, 2018, 12:58:33 PM
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
                        <h1 class="modal-title">Admin Login</h1>
                    </div>
                    <div class="card-body bg-primary">
                        <form action="<%=request.getContextPath() %>/AdminLoginServlet" name="loginForm" class="form-control">
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
