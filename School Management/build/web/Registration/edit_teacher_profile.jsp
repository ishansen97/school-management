<%-- 
    Document   : edit_teacher_profile
    Created on : Nov 10, 2018, 9:38:30 AM
    Author     : DELL
--%>
<%@page import="teacher.*" %>
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
                margin-top: 100px;
            }
            .form-group {
                margin-top: 20px;
            }
            .input-group {
                margin-top: 20px;
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
            
            function showPassword() {
                var pass = document.forms["editForm"]["password"];
                
                if (pass.type === "password") {
                    pass.type = "text";
                }
                else {
                    pass.type = "password";
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
            
            function grade_gender_Validation(grd) {
                var grade = grd.toString();
                
                if (grade === "") {
                    alert("Please select the relevant gender");
                    return false;
                }
                else {
                    return true;
                }
            }
        
            function passwordValidation(password, cpassword) {
                var pass = password.toString();

                if (pass.length >= 8) {
                    return true;
                }
                else {
                    alert("Enter 8 or more characters for the password");
                    return false;
                }
            }

            function editFormValidation() {
                var first = document.forms["editForm"]["fname"].value;
                var last = document.forms["editForm"]["lname"].value;
                var gender = document.forms["editForm"]["genderSelect"].value;

                var address = document.forms["editForm"]["address"].value;
                var password = document.forms["editForm"]["password"].value;

                var isFirstValid = nameValidation(first);
                var isLastValid = nameValidation(last);
                var isGenderValid = grade_gender_Validation(gender);
                var validAddress = addressValidation(address);
                var validPassword = passwordValidation(password);

                return (isFirstValid && isLastValid && isGenderValid && validAddress && validPassword);
            }
        </script>
        <%@include file="../layouts/teacher_profile_navigation.jsp" %>
        <% Teacher teacher = (Teacher) session.getAttribute("teacher"); %>
        <div class="container-fluid">
            <div class="row">
                <div class="card">
                    <div class="card-header">
                        <h1 class="modal-title">Profile Details</h1>
                    </div>
                    <div class="card-body bg-primary">
                        <form action="<%=request.getContextPath() %>/UpdateTeacherServlet" method="POST" class="form-control" name="editForm" onsubmit="return editFormValidation()">
                            <div class="form-group">
                                <label><b>First Name</b></label>
                                <input type="text" name="fname" class="form-control" value="<%=teacher.getFirstName() %>">
                            </div>
                            <div class="form-group">
                                <label><b>Last Name</b></label>
                                <input type="text" name="lname" class="form-control" value="<%=teacher.getLastName() %>">
                            </div>
                            <div class="form-group">
                                <label><b>Address</b></label>
                                <textarea name="address" class="form-control"><%=teacher.getAddress() %></textarea>
                            </div>
                            <div class="form-group">
                                <label><b>Age</b></label>
                                <input type="number" name="age" class="form-control" value="<%=teacher.getAge() %>">
                            </div>
                            <div class="form-group">
                                <label><b>Years of Experience</b></label>
                                <input type="number" name="YOE" class="form-control" value="<%=teacher.getYears_of_experience() %>">
                            </div>
                            <div class="form-group">
                                <label><b>Gender</b></label>
                                <input type="text" name="gender" class="form-control" rows="5" value="<%=teacher.getGender() %>" readonly>
                                <select name="genderSelect" class="form-control">
                                    <option value="">select</option>
                                    <option value="male">male</option>
                                    <option value="female">female</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label><b>Email</b></label>
                                <input type="email" name="email" class="form-control" value="<%=teacher.getEmail() %>">
                            </div>
                            <div class="form-group">
                                <label><b>Username</b></label>
                                <input type="text" name="username" class="form-control" value="<%=teacher.getUsername() %>">
                            </div>
                            <div class="form-group">
                                <label><b>Password</b></label>
                                <input type="password" name="password" class="form-control" value="<%=teacher.getPassword() %>">
                            </div>
                            <div class="form-check-inline">
                                <input type="checkbox" class="form-check-input" onclick="showPassword()">
                                <label>Show Password</label>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="btn btn-success form-control">Update</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
