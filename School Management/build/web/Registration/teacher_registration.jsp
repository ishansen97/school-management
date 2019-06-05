<%-- 
    Document   : teacher_regsitration
    Created on : Nov 9, 2018, 9:53:41 AM
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
                width: 500px; 
                border: 1px solid blue; 
                margin-top: 100px;
            }
            .form-group {
                margin-top: 20px;
                font-size: 25px;
            }
            
        </style>
    </head>
    <body class="w3-main">
        <script>
            function nameValidation(first) {
                var name = first.toString();
                var pattern = /^[a-zA-Z]+$/;

                if (name.match(pattern)) 
                    return true;
                else {
                    alert("Enter text only for first name and last name");
                    return false;
                }
            }

            function grade_gender_Validation(grd) {
                var grade = grd.toString();

                if (grade === "") {
                    alert("Please select the relevant grade");
                    return false;
                }
                else {
                    return true;
                }
            }

            function classValidation(cla1, cla2) {
                var c1 = cla1.toString();
                var c2 = cla2.toString();

                if (c1 === "" && c2 === "") {
                    alert("Please select the relevant class");
                    return false;
                }
                else {
                    return true;
                }
            }

            function addressValidation(add) {
                var address = add.toString();
                var pattern = /^[0-9]+$/;

                if (address.match(pattern)) {
                    alert("Address should contain text also");
                    return false;
                } 
                else {
                    return true;
                }

            }

            function passwordValidation(password, cpassword) {
                pass = password.toString();
                cpass = cpassword.toString();

                if (pass.length >= 8) {
                    if (pass === cpass) {
                        return true;
                    }
                    else {
                        alert("Password and the confirm password are not equal");
                        return false;
                    }
                }
                else {
                    alert("Enter 8 or more characters for the password");
                    return false;
                }
            }

            function validation() {
                var first = document.forms["registration"]["fname"].value;
                var last = document.forms["registration"]["lname"].value;
                var gender = document.forms["registration"]["gender"].value;
                
                var address = document.forms["registration"]["address"].value;
                var password = document.forms["registration"]["password"].value;
                var cpassword = document.forms["registration"]["cpassword"].value;

                var isFirstValid = nameValidation(first);
                var isLastValid = nameValidation(last);
                var isGenderValid = grade_gender_Validation(gender);
                var validAddress = addressValidation(address);
                var validPassword = passwordValidation(password, cpassword);

                return (isFirstValid && isLastValid && isGenderValid && isGradeValid && isClassValid && validAddress && validPassword);
            }

            function showPassword() {
                var pass = document.getElementById("pass");

                if (pass.type === "password") {
                    pass.type = "text";
                }
                else {
                    pass.type = "password";
                }
            }

            function showCPassword() {
                var pass = document.getElementById("cpass");

                if (pass.type === "password") {
                    pass.type = "text";
                }
                else {
                    pass.type = "password";
                }
            }

            
    </script>
    
        <div class="container-fluid">
            <div class="row">
                <div class="card">
                    <div class="card-header">
                        <h1 class="modal-title">Teacher Registration</h1>
                    </div>
                    <div class="card-body bg-light">
                        <form action="<%=request.getContextPath() %>/TeacherRegistrationServelet" method="POST" class="form-control" name="registration" onsubmit="return validation()"> 
                            <div class="form-group">
                                <label>First Name</label>
                                <input type="text" class="form-control" name="fname">
                            </div>
                            <div class="form-group">
                                <label>Last Name</label>
                                <input type="text" class="form-control" name="lname">
                            </div>
                            <div class="form-group">
                                <label>Age</label>
                                <input type="number" class="form-control" name="age" required>
                            </div>
                            <div class="form-group">
                                <label>Gender</label>
                                <select name="gender" class="form-control">
                                    <option value="">select</option>
                                    <option value="male">male</option>
                                    <option value="female">female</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Address</label>
                                <textarea name="address" rows="5" class="form-control" required></textarea>
                            </div>
                            <div class="form-group">
                                <label>Years of Experience</label>
                                <input type="number" class="form-control" name="YOE" required>
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" name="email" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Username</label>
                                <input type="text" name="username" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Password</label>
                                <input type="password" name="password" class="form-control" id="pass" required>
                            </div>
                            <div class="form-check-inline">
                                <input type="checkbox" class="form-check-input" onclick="showPassword()">
                                <label class="form-check-label">Show Password</label>
                            </div>    
                            <div class="form-group">
                                <label>Confirm Password</label>
                                <input type="password" name="cpassword" class="form-control" id="cpass" required>
                            </div>
                            <div class="form-check-inline">
                                <input type="checkbox" class="form-check-input" onclick="showCPassword()">
                                <label class="form-check-label">Show Confirm Password</label>
                            </div>    
                            <div class="form-group">
                                <button type="submit" class="btn btn-success">Register</button>
                                <button type="reset" class="btn btn-danger">Reset</button>
                            </div>
                                
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
