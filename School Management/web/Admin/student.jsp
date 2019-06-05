<%-- 
    Document   : student
    Created on : Nov 10, 2018, 2:50:48 PM
    Author     : DELL
--%>
<%@page import="java.sql.*, grades.Grades, student.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Management</title>
        <%@include file="../layouts/Navigation.jsp" %>
        <%@include file="../layouts/Scripts.jsp" %>
        <%@include file="../layouts/Styles.jsp" %>
        
        <style>
            li {
                margin-left: 20px;
            }
            .card {
                margin: auto; 
                width: 800px; 
                margin-top: 100px;
            }
            .form-group {
                margin-top: 20px;
                font-size: 25px;
            }
            #classes1 {
                display: none;
            }
            #classes2 {
                display: none;
            }
            #section {
                display: none;
            }
            #art_classes {
                display: none;
            }
            #science_classes {
                display: none;
            }
            #maths_classes {
                display: none;
            }
            #commerce_classes {
                display: none;
            }
            #tech_classes {
                display: none;
            }
        </style>
    </head>
    <body class="w3-main">
        <%@include file="../layouts/admin_navigation.jsp" %>
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
        
        
        function classValidation(grade) {
            var class1 = document.forms["registration"]["cla1"].value;
            var class2 = document.forms["registration"]["cla2"].value;
            var isSelected;
            
            if (grade === "12" || grade === "13") {
                var section = document.getElementById("al_section").value;
                var art_classes = document.getElementById("art_select").value;
                var science_classes = document.getElementById("science_select").value;
                var maths_classes = document.getElementById("maths_select").value;
                var commerce_classes = document.getElementById("commerce_select").value;
                var tech_classes = document.getElementById("tech_select").value;
                
                if (section === "") {
                    alert("Please select a section");
                    isSelected = false;
                }
                else {
                    if (art_classes === "" && science_classes === "" && maths_classes === "" && commerce_classes === "" && tech_classes === "") {
                        alert("Please select an a level class");
                        isSelected = false;
                    }
                    else {
                        alert("one of the al classes has been selected");
                        isSelected = true;
                    }
                }
            }
            else {
                if (class1 === "" && class2 === "") {
                    alert("Please select a class");
                    isSelected = false;
                }
                else {
                    alert("one of the regular classes has been selected");
                    isSelected = true;
                }
            }
            
            return isSelected;
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
            var grade = document.forms["registration"]["grade"].value;
            
            var address = document.forms["registration"]["address"].value;
            var password = document.forms["registration"]["password"].value;
            var cpassword = document.forms["registration"]["cpassword"].value;
            
            var isFirstValid = nameValidation(first);
            var isLastValid = nameValidation(last);
            var isGenderValid = grade_gender_Validation(gender);
            var isGradeValid = grade_gender_Validation(grade);
            var isClassValid = classValidation(grade);
            var validAddress = addressValidation(address);
            var validPassword = passwordValidation(password, cpassword);
            
            alert(isClassValid);
          
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
        
        $(document).ready(function() {
            $("#grades").change(function() {
                var grade = $(this).val();
                
                if (grade >= 1 && grade <= 9) {
                    var class1 = document.getElementById("classes1");
                    var class2 = document.getElementById("classes2");
                    
                    class1.style.display = "block";
                    class2.style.display = "none";
                    
                }
                else if (grade >= 10 && grade <= 11) {
                    var class2 = document.getElementById("classes2");
                    var class1 = document.getElementById("classes1");
                    
                    class2.style.display = "block";
                    class1.style.display = "none";
                }
                
                else if (grade >= 12 && grade <= 13) {
                    var section = document.getElementById("section");
                    var al_section = document.getElementById("al_section");
                    var class2 = document.getElementById("classes2");
                    var class1 = document.getElementById("classes1");
                    
                    class2.style.display = "none";
                    class1.style.display = "none";
                    section.style.display = "block";
                    
                    $("#section").change(function() {
                        var section_name = al_section.value;
                        var art_classes = document.getElementById("art_classes");
                        var science_classes = document.getElementById("science_classes");
                        var maths_classes = document.getElementById("maths_classes");
                        var commerce_classes = document.getElementById("commerce_classes");
                        var tech_classes = document.getElementById("tech_classes");
                        
                        var al_class;
                        
                        if (section_name === "SE004") {
                            al_class = document.getElementById("art_classes");
                            
                            al_class.style.display = "block";
                            science_classes.style.display = "none";
                            maths_classes.style.display = "none";
                            commerce_classes.style.display = "none";
                            tech_classes.style.display = "none";
                        }
                        else if (section_name === "SE005") {
                            al_class = document.getElementById("maths_classes");
                            
                            al_class.style.display = "block";
                            art_classes.style.display = "none";
                            science_classes.style.display = "none";
                            commerce_classes.style.display = "none";
                            tech_classes.style.display = "none";
                        }
                        else if (section_name === "SE006") {
                            al_class = document.getElementById("science_classes");
                            
                            al_class.style.display = "block";
                            art_classes.style.display = "none";
                            maths_classes.style.display = "none";
                            commerce_classes.style.display = "none";
                            tech_classes.style.display = "none";
                        }
                        else if (section_name === "SE007") {
                            al_class = document.getElementById("commerce_classes");
                            
                            al_class.style.display = "block";
                            art_classes.style.display = "none";
                            maths_classes.style.display = "none";
                            science_classes.style.display = "none";
                            tech_classes.style.display = "none";
                        }
                        else if (section_name === "SE008") {
                            al_class = document.getElementById("tech_classes");
                            
                            al_class.style.display = "block";
                            art_classes.style.display = "none";
                            science_classes.style.display = "none";
                            maths_classes.style.display = "none";
                            commerce_classes.style.display = "none";
                        }
                    });
                        
                }
            });
        });
        </script>
        <% ResultSet grades = Grades.viewGrades(); 
           ResultSet al_grades = Grades.viewALGrades();
           ResultSet regular_students = null;
           ResultSet al_students = null;
           ResultSet al_sections = Grades.getALSection();
           ResultSet art_classes = Grades.getArtClasses();
           ResultSet science_classes = Grades.getScienceClasses();
           ResultSet commerce_classes = Grades.getCommerceClasses();
           ResultSet maths_classes = Grades.getMathsClasses();
           ResultSet tech_classes = Grades.getTechnologyClasses();
           
           String search = null;
           String al_search = null;
        %>
        <div class="container-fluid">
            <div class="row">
                <ul class="nav nav-tabs justify-content-center" style="margin: auto; margin-top: 50px">
                    <li class="nav-item">
                        <a href="#student_registration" data-toggle="tab" class="nav-link">Add Student</a>
                    </li>
                    <li class="nav-item">
                        <a href="#view_students" data-toggle="tab" class="nav-link">View Students</a>
                    </li>
                    <li class="nav-item">
                        <a href="#class_top" data-toggle="tab" class="nav-link">Class Toppers</a>
                    </li>
                    <li class="nav-item">
                        <a href="#section_top" data-toggle="tab" class="nav-link">Section Toppers</a>
                    </li>
                </ul>
            </div>
        </div>
        
        <!--tab content-->
        <div class="tab-content">
            
            <!--student registration-->
            <div class="card tab-pane container fade" id="student_registration">
                <div class="card-header">
                    <h1 class="modal-title">Student Registration</h1>
                </div>
                <div class="card-body bg-light">
                    <form action="<%=request.getContextPath() %>/StudentRegistrationServelet" method="POST" class="form-control" name="registration" onsubmit="return validation()"> 
                        <div class="form-group">
                            <label>First Name</label>
                            <input type="text" class="form-control" name="fname">
                        </div>
                        <div class="form-group">
                            <label>Last Name</label>
                            <input type="text" class="form-control" name="lname">
                        </div>
                        <div class="form-group">
                            <label>Grade</label>
                            <select class="form-control" name="grade" id="grades">
                                <option value="">select</option>
                                <% while (grades.next()) { %>
                                <option value="<%=grades.getString("Grade") %>"><%=grades.getString("Grade") %></option>
                                <% } %>
                                <% while (al_grades.next()) { %>
                                <option value="<%=al_grades.getString("Grade") %>"><%=al_grades.getString("Grade") %></option>
                                <% } %>
                            </select>
                        </div>
                            
                        <div class="form-group" id="section">
                            <label>Section</label>
                            <select name="section" class="form-control" id="al_section">
                                <option value="">select</option>
                                <% while (al_sections.next()) { %>
                                <option value="<%=al_sections.getString("section_ID") %>"><%=al_sections.getString("section_name") %></option>
                                <% } %>
                            </select>
                        </div>
                            
                        <div class="form-group" id="art_classes">
                            <label>Art Class</label>
                            <select name="art" class="form-control" id="art_select">
                                <option value="">select</option>
                                <% while (art_classes.next()) { %>
                                <option value="<%=art_classes.getString("class") %>"><%=art_classes.getString("class") %></option>
                                <% } %>
                            </select>
                        </div>
                            
                        <div class="form-group" id="science_classes">
                            <label>Science Class</label>
                            <select name="science" class="form-control" id="science_select">
                                <option value="">select</option>
                                <% while (science_classes.next()) { %>
                                <option value="<%=science_classes.getString("class") %>"><%=science_classes.getString("class") %></option>
                                <% } %>
                            </select>
                        </div>
                            
                        <div class="form-group" id="commerce_classes">
                            <label>Commerce Class</label>
                            <select name="commerce" class="form-control" id="commerce_select">
                                <option value="">select</option>
                                <% while (commerce_classes.next()) { %>
                                <option value="<%=commerce_classes.getString("class") %>"><%=commerce_classes.getString("class") %></option>
                                <% } %>
                            </select>
                        </div>
                            
                        <div class="form-group" id="maths_classes">
                            <label>Maths Class</label>
                            <select name="maths" class="form-control" id="maths_select">
                                <option value="">select</option>
                                <% while (maths_classes.next()) { %>
                                <option value="<%=maths_classes.getString("class") %>"><%=maths_classes.getString("class") %></option>
                                <% } %>
                            </select>
                        </div>
                            
                        <div class="form-group" id="tech_classes">
                            <label>Tech Class</label>
                            <select name="tech" class="form-control" id="tech_select">
                                <option value="">select</option>
                                <% while (tech_classes.next()) { %>
                                <option value="<%=tech_classes.getString("class") %>"><%=tech_classes.getString("class") %></option>
                                <% } %>
                            </select>
                        </div>    

                        <div class="form-group" id="classes1">
                            <label>Class</label>
                            <select name="cla1" class="form-control">
                                <option value="">select</option>
                                <option value="A">A</option>
                                <option value="B">B</option>
                                <option value="C">C</option>
                                <option value="D">D</option>
                                <option value="E">E</option>
                            </select>
                        </div>

                        <div class="form-group" id="classes2">
                            <label>Class</label>
                            <select name="cla2" class="form-control">
                                <option value="">select</option>
                                <option value="A">A</option>
                                <option value="B">B</option>
                                <option value="C">C</option>
                                <option value="D">D</option>
                                <option value="E">E</option>
                                <option value="F">F</option>
                                <option value="G">G</option>
                                <option value="H">H</option>
                            </select>
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
                            <label>Email(if available)</label>
                            <input type="email" name="email" class="form-control">
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
                            
            <!--view students-->
            <div class="card tab-pane container fade" id="view_students">
                <div class="card-header">
                    <ul class="nav nav-tabs justify-content-center">
                        <li class="nav-item">
                            <a href="#regular_students" class="nav-link" data-toggle="tab">Regular students</a>
                        </li>
                        <li class="nav-item">
                            <a href="#al_students" class="nav-link" data-toggle="tab">A/L students</a>
                        </li>
                    </ul>
                </div>
                
                <div class="tab-content">
                    
                    <!--regular students-->
                    <div class="card-body bg-warning tab-pane container fade" id="regular_students">
                        <form action="" method="POST">
                            <div class="input-group">
                                <input type="text" class="input-control" name="search_regular" required>
                                <button type="submit" class="btn btn-primary input-append">Search</button>
                            </div>
                        </form>
                        <% search = request.getParameter("search_regular");
                            
                            try {
                                if (search != null) {
                                    regular_students = Student.searchRegularStudents(search);
                                }
                                else {
                                    regular_students = Student.getRegularStudents();
                                }
                        %>
                        <table class="table table-striped bg-light">
                            <tr>
                                <th>Student ID</th>
                                <th>Full name</th>
                                <th>Grade</th>
                                <th>Age</th>
                                <th>Gender</th>
                                <th>Email</th>
                            </tr>
                            <% while (regular_students.next()) { %>
                            <tr>
                                <td><%=regular_students.getString("student_ID") %></td>
                                <td><%=regular_students.getString("fname") %> <%=regular_students.getString("lname") %></td>
                                <td><%=regular_students.getString("grade") %> <%=regular_students.getString("class") %></td>
                                <td><%=regular_students.getString("age") %></td>
                                <td><%=regular_students.getString("gender") %></td>
                                <td><%=regular_students.getString("email") %></td>
                                <td><a href="#?id=<%=regular_students.getString("student_ID") %>" class="btn btn-danger">Remove</a></td>
                            </tr>
                            <% } %>
                        </table>
                    </div>
                    
                    <!--a/l students-->
                    <div class="card-body bg-warning tab-pane container fade" id="al_students">
                        <form action="" method="POST">
                            <div class="input-group">
                                <input type="text" class="input-control" name="search_al" required>
                                <button type="submit" class="btn btn-primary input-append">Search</button>
                            </div>
                        </form>
                        
                        <% al_search = request.getParameter("search_al");
                        
                           if (al_search != null) {
                               al_students = Student.searchALStudents(al_search);
                           }
                           else {
                               al_students = Student.getALStudents();
                           }
                        %>
                        <table class="table table-striped bg-light">
                            <tr>
                                <th>Student ID</th>
                                <th>Full name</th>
                                <th>Grade</th>
                                <th>Age</th>
                                <th>Gender</th>
                                <th>Email</th>
                            </tr>
                            <% while (al_students.next()) { %>
                            <tr>
                                <td><%=al_students.getString("student_ID") %></td>
                                <td><%=al_students.getString("fname") %> <%=al_students.getString("lname") %></td>
                                <td><%=al_students.getString("grade") %> <%=al_students.getString("class") %></td>
                                <td><%=al_students.getString("age") %></td>
                                <td><%=al_students.getString("gender") %></td>
                                <td><%=al_students.getString("email") %></td>
                                <td><a href="#id=<%=al_students.getString("student_ID") %>" class="btn btn-danger">Remove</a></td>
                            </tr>
                            <% } %>
                        </table>
                    </div>
                </div>
            </div>
                        
            <!--class toppers-->
            <div class="card tab-pane container fade" id="class_top">
                <h1>class toppers</h1>
            </div>
            
            <!--section toppers-->
            <div class="card tab-pane container fade" id="section_top">
                <h1>section toppers</h1>
            </div>
        </div>
        <% } catch (Exception ex) { 
                out.println(ex.getMessage());
            }
        %>
    </body>
</html>
