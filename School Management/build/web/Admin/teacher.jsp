<%-- 
    Document   : teacher
    Created on : Nov 10, 2018, 2:50:35 PM
    Author     : DELL
--%>
<%@page import="subjects.Subject"%>
<%@page import="java.sql.*, teacher.*, grades.*" %>
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
            #grades {
                display: none;
            }
            #al_grades {
                display: none;
            }
            #art_classes, #maths_classes, #commerce_classes, #science_classes, #tech_classes, #regular_classes, #ol_classes, #al_sections {
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

                return (isFirstValid && isLastValid && isGenderValid && validAddress && validPassword);
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
               $("input[type=radio]").click(function() {
                  var category = $(this).val();
                  var grades = document.getElementById("grades");
                  var al_grades = document.getElementById("al_grades");
                  var al_sections = document.getElementById("al_sections");
                  
                  if (category === "non_al") {
                      grades.style.display = "block";
                      al_grades.style.display = "none";
                      al_sections.style.display = "none";
                  }
                  else if (category === "al") {
                      grades.style.display = "none";
                      al_grades.style.display = "block";
                      al_sections.style.display = "block";
                  }
               });
               
               $("#view_al_sections").change(function() {
                  var al_section = $(this).val(); 
                  var art_classes = document.getElementById("art_classes");
                  var maths_classes = document.getElementById("maths_classes");
                  var science_classes = document.getElementById("science_classes");
                  var commerce_classes = document.getElementById("commerce_classes");
                  var tech_classes = document.getElementById("tech_classes");
                  
                  switch (al_section) {
                      case "SE004" : art_classes.style.display = "block";
                                     maths_classes.style.display = "none";
                                     science_classes.style.display = "none";
                                     commerce_classes.style.display = "none";
                                     tech_classes.style.display = "none";
                                     break;
                                     
                      case "SE005" : art_classes.style.display = "none";
                                     maths_classes.style.display = "block";
                                     science_classes.style.display = "none";
                                     commerce_classes.style.display = "none";
                                     tech_classes.style.display = "none";
                                     break;
                                     
                      case "SE006" : art_classes.style.display = "none";
                                     maths_classes.style.display = "none";
                                     science_classes.style.display = "block";
                                     commerce_classes.style.display = "none";
                                     tech_classes.style.display = "none";
                                     break;
                                 
                      case "SE007" : art_classes.style.display = "none";
                                     maths_classes.style.display = "none";
                                     science_classes.style.display = "none";
                                     commerce_classes.style.display = "block";
                                     tech_classes.style.display = "none";
                                     break;
                                 
                      case "SE008" : art_classes.style.display = "none";
                                     maths_classes.style.display = "none";
                                     science_classes.style.display = "none";
                                     commerce_classes.style.display = "none";
                                     tech_classes.style.display = "block";
                                     break;
                                 
                      default : alert("please select a section");
                                break;
                  }
               });
               
               $("#regular_grades").change(function() {
                  var grade = $(this).val();
                  var regular_classes = document.getElementById("regular_classes");
                  var ol_classes = document.getElementById("ol_classes");
                  
                  if (grade >= 1 && grade < 10) {
                      regular_classes.style.display = "block";
                      ol_classes.style.display = "none";
                  }
                  else if (grade >= 10 && grade <= 11) {
                      regular_classes.style.display = "none";
                      ol_classes.style.display = "block";
                  }
                  else {
                      alert("Please select a grade");
                  }
               });
               
               $("input[type=radio]").click(function() {
                  var checked = $(this).prop("checked");
                  var row = $(this).parent().parent();
                  
                  if (checked === true) {
                    if (!row.hasClass("form-check-inline"))
                      row.css({background : "blue",color : "white"});
                  }
                  if (checked === false) {
                      row.css({background : "inherit",color : "inherit"});
                  }
               });
               
               $(".check_teachers").click(function() {
                  var teacher_id = $(this).val();
                  var allocated_teacher;
                  var grade;
                  var Class;
                  var compGrade;
                  var compClass;
                  var isTeacherFound;
                  var isGradeandClassFound;
                  
                  $(".view_teacher_subject_allocation").each(function() {
                     allocated_teacher = $(this).attr("data-teacher");
                     
                     if (teacher_id === allocated_teacher) {
                         isTeacherFound = true;
                         grade = $(this).attr("data-grade");
                         Class = $(this).attr("data-class");
                         
                         $(".form-check-input").each(function() {
                            compGrade = $(this).attr("data-grade");
                            compClass = $(this).attr("data-class");
                            var ishidden = $(this).attr("type");
                            
                            if ((grade === compGrade) && (Class === compClass)) {
                                isGradeandClassFound = true;
                                $(this).attr("disabled",true);
                                $(this).prop("checked",false);
                                $(this).parent().hide();
                            }
//                            else if (grade === compGrade) {
//                                alert(compGrade + "-" + compClass);
//                                $(this).attr("type","checkbox");
//                                $(this).parent().show();
//                            }
                         });
                     }
                     else {
                         isTeacherFound = false;
                     }     
                  });
               });
               
               $(".radio_al_teachers").click(function() {
                  var teacher_id = $(this).val();
                  var allocated_teacher;
                  var grade;
                  var Class;
                  var compGrade;
                  var compClass;
                  var isTeacherFound;
                  var isGradeandClassFound;
                  
                  $(".view_al_teacher_subject_allocation").each(function() {
                     allocated_teacher = $(this).attr("data-teacher");
                     
                     if (teacher_id === allocated_teacher) {
                         isTeacherFound = true;
                         grade = $(this).attr("data-grade");
                         Class = $(this).attr("data-class");
                         
                         $(".form-check-input").each(function() {
                            compGrade = $(this).attr("data-grade");
                            compClass = $(this).attr("data-class");
                            var ishidden = $(this).attr("type");
                            
                            if ((grade === compGrade) && (Class === compClass)) {
                                isGradeandClassFound = true;
                                $(this).attr("disabled",true);
                                $(this).prop("checked",false);
                                $(this).parent().hide();
                            }
//                            else if (grade === compGrade) {
//                                alert(compGrade + "-" + compClass);
//                                $(this).attr("type","checkbox");
//                                $(this).parent().show();
//                            }
                         });
                     }
                     else {
                         isTeacherFound = false;
                     }     
                  });
               });
            });
            
        </script>
        
        <% ResultSet teachers = Teacher.getAllTeachers(); 
           ResultSet available_teachers = Teacher.getAvailableTeachers();
//           ResultSet class_teachers = Teacher.getAllTeachers();
           ResultSet grades = Grades.viewGrades();
           ResultSet al_grades = Grades.viewALGrades();
           ResultSet al_sections = Grades.getALSection();
           ResultSet art_classes = Grades.getArtClasses();
           ResultSet maths_classes = Grades.getMathsClasses();
           ResultSet science_classes = Grades.getScienceClasses();
           ResultSet commerce_classes = Grades.getCommerceClasses();
           ResultSet tech_classes = Grades.getTechnologyClasses();
           ResultSet regular_classes = Grades.getRegularClasses();
           ResultSet ol_classes = Grades.getOLClasses();
           
           String teacher_ID = null;
           String teacher_name = null;
        %>
        <div class="container-fluid">
            <div class="row">
                <ul class="nav nav-tabs justify-content-center" style="margin: auto; margin-top: 50px">
                    <li class="nav-item">
                        <a href="#teacher_registration" data-toggle="tab" class="nav-link">Add Teacher</a>
                    </li>
                    <li class="nav-item">
                        <a href="#view_teachers" data-toggle="tab" class="nav-link">View Teacher</a>
                    </li>
                    <li class="nav-item">
                        <a href="#class_teachers" data-toggle="tab" class="nav-link">Class Teachers</a>
                    </li>
                    <li class="nav-item">
                        <a href="#section_heads" data-toggle="tab" class="nav-link">Section Heads</a>
                    </li>
                    <li class="nav-item">
                        <a href="#class_subject_assignment" data-toggle="tab" class="nav-link">Assign Classes</a>
                    </li>
                </ul>
            </div>
        </div>
        
        <div class="tab-content">
        <!--teacher registration-->
        
            <div class="card tab-pane container active" id="teacher_registration">
                <div class="card-header">
                    <h1 class="modal-title">Teacher Registration</h1>
                </div>
                <div class="card-body bg-primary">
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

            <!--view teachers-->
            <div class="card tab-pane container fade" id="view_teachers">
                <ul class="nav nav-tabs justify-content-center">
                    <li class="nav-item">
                        <a href="#all_teachers" class="nav-link" data-toggle="tab">All Teachers</a>
                    </li>
                    <li class="nav-item">
                        <a href="#subject_teachers" class="nav-link" data-toggle="tab">Subject Teachers</a>
                    </li>
                    <li class="nav-item">
                        <a href="#al_subject_teachers" class="nav-link" data-toggle="tab">A/L Subject Teachers</a>
                    </li>
                </ul>
                
                <!--tab content-->
                <div class="tab-content">
                    <!--all teachers-->
                    <div class="card-body tab-pane container active bg-primary" id="all_teachers">
                        <h1>View Teachers</h1>
                        <table class="table table-striped bg-light">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Gender</th>
                                <th>Age</th>
                                <th>Years of Experience</th>
                            </tr>
                            <% while (teachers.next()) {
                                teacher_ID = teachers.getString("teacher_ID");
                                teacher_name = teachers.getString("fname") + " " + teachers.getString("lname");
                            %>
                            <tr>
                                <td><%=teacher_ID %></td>
                                <td><%=teacher_name %></td>
                                <td><%=teachers.getString("gender") %></td>
                                <td><%=teachers.getString("age") %></td>
                                <td><%=teachers.getString("YOE") %></td>
                                <td><button type="button" class="btn btn-danger">Remove</button></td>
                            </tr>

                            <% } %>
                        </table>
                    </div>
                        
                    <!--subject teachers-->
                    <div class="card-body tab-pane container fade" id="subject_teachers">
                        <div class="card-header">
                            <h1>Subject Teachers</h1>
                        </div>
                        <% ResultSet view_grades = Grades.viewGrades();
                            while (view_grades.next()) {
                                int grade = view_grades.getInt("Grade");
                        %>
                        <div class="form-group">
                            <button class="btn btn-link" data-toggle="collapse" data-target="#view_grade_<%=grade %>">Grade <%=grade %></button>
                        </div>
                        <div class="form-control collapse" id="view_grade_<%=grade %>">
                            <h1>Subject Teachers for Grade <%=grade %></h1>
                            <% ResultSet subjects_for_grade = Subject.getSubjectsForGrade(grade);
                                while (subjects_for_grade.next()) {
                                    String sub_code = subjects_for_grade.getString("sub_code");
                                    String sub_name = subjects_for_grade.getString("sub_name");
                            %>
                            <div class="form-group">
                                <button class="btn btn-link" style="color: green" data-toggle="collapse" data-target="#<%=sub_code %>"><%=sub_name %></button>
                            </div>
                            <div class="form-control bg-primary collapse" id="<%=sub_code %>">
                                <table class="table table-striped bg-light">
                                    <tr>
                                        <th>Teacher ID</th>
                                        <th>Teacher Name</th>
                                    </tr>
                                    <% ResultSet subject_teachers = Subject.getSubjectTeachers(sub_code);
                                        while (subject_teachers.next()) {
                                            String t_ID = subject_teachers.getString("teacher_ID");
                                            String name = subject_teachers.getString("fname") + " " + subject_teachers.getString("lname");
                                    %>
                                    <tr>
                                        <td><%=t_ID %></td>
                                        <td><%=name %></td>
                                    </tr>
                                    <% } %>
                                </table>
                            </div>
                            <% } %>
                        </div>
                        <% } %>
                    </div>
                    
                    <!--A/L Subject Teachers-->
                    <div class="card-body tab-pane container fade" id="al_subject_teachers">
                        <div class="card-header">
                            <h1>A/L Subject Teachers</h1>
                        </div>
                        <% ResultSet al_subject_teacher_grades = Grades.viewALGrades();
                            while (al_subject_teacher_grades.next()) {
                                int grade = al_subject_teacher_grades.getInt("Grade");
                        %>
                        <div class="form-group">
                            <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#al_subject_teacher_<%=grade %>">Grade <%=grade %></button>
                        </div>
                            <div class="form-control collapse" id="al_subject_teacher_<%=grade %>">
                                <h1 style="color: green">Sections</h1>
                                <% ResultSet al_subject_teacher_sections = Grades.getALSection(grade);
                                    while (al_subject_teacher_sections.next()) {
                                        String section_ID = al_subject_teacher_sections.getString("section_ID");
                                        String section_name = al_subject_teacher_sections.getString("section_name");
                                %>
                                <div class="form-group">
                                    <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#al_subject_teacher_<%=grade %>_<%=section_ID %>"><b><%=section_name %></b></button>
                                </div>
                                    <div class="form-control collapse" id="al_subject_teacher_<%=grade %>_<%=section_ID %>">
                                        <h2 style="color: red">Subjects</h2>
                                        <% ResultSet al_section_subjects = Subject.getSectionSubjects(grade, section_ID);
                                            while (al_section_subjects.next()) {
                                                String sub_code = al_section_subjects.getString("sub_code");
                                                String sub_name = al_section_subjects.getString("sub_name");
                                        %>
                                        <div class="form-group">
                                            <button type="button" class="btn btn-link" style="color: green" data-toggle="collapse" data-target="#al_subject_teacher_<%=sub_code %>"><%=sub_name %></button>
                                        </div>
                                            <div class="form-control collapse" id="al_subject_teacher_<%=sub_code %>">
                                                <table class="table table-striped">
                                                    <tr>
                                                        <th>Teacher ID</th>
                                                        <th>Teacher Name</th>
                                                    </tr>
                                                    <% ResultSet al_subject_teacher = Subject.getALSubjectTeachers(sub_code);
                                                        while (al_subject_teacher.next()) {
                                                            String teacher = al_subject_teacher.getString("teacher_ID");
                                                            String fname = al_subject_teacher.getString("fname");
                                                            String lname = al_subject_teacher.getString("lname");
                                                    %>
                                                    <tr>
                                                        <td><%=teacher %></td>
                                                        <td><%=fname %> <%=lname %></td>
                                                    </tr>
                                                    <% } %>
                                                </table>
                                            </div>
                                        <% } %>
                                    </div>
                                <% } %>
                            </div>
                        <% } %>
                    </div>
                </div>
                    
                
            </div>

            <!--class teachers-->
            <div class="card tab-pane container fade" id="class_teachers">
                <div class="row">
                    <ul class="nav nav-tabs justify-content-center bg-light">
                        <li class="nav-item">
                            <a href="#assign_classes" data-toggle="tab" class="nav-link">Assign Classes</a>
                        </li>
                        <li class="nav-item">
                            <a href="#view_class_teachers" data-toggle="tab" class="nav-link">View Class Teachers</a>
                        </li>
                    </ul>
                </div>
                
                <!--class teachers tab content-->
                <div class="tab-content">
                    
                    <!--assign classes-->
                    <div class="card-body tab-pane container active" id="assign_classes">
                        <h1 class="modal-title">Assign Classes</h1>
                        <form action="<%=request.getContextPath() %>/AssignClassTeacherServlet" method="POST" class="form-control">
                            <div class="form-group">
                                <label>Teacher Name</label>
                                <select name="teacher" class="form-control" required>
                                    <option value="">select</option>
                                    <% while (available_teachers.next()) { %>
                                    <option value="<%=available_teachers.getString("teacher_ID") %>"><%=available_teachers.getString("fname") %> <%=available_teachers.getString("lname") %></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Select class category</label>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input type="radio" class="form-check-input" name="category" value="non_al" required>
                                        Non A/L
                                    </label>
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label">
                                        <input type="radio" class="form-check-input" name="category" value="al" required>
                                        A/L
                                    </label>
                                </div>
                                <div class="form-group" id="grades">
                                    <label>Select Grade</label>
                                    <select name="regular_grade" class="form-control" id="regular_grades">
                                        <option value="">Select</option>
                                        <% while (grades.next()) { %>
                                        <option value="<%=grades.getString("Grade") %>"><%=grades.getString("Grade") %></option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="form-group" id="al_grades">
                                    <label>Select A/L Grade</label>
                                    <select name="al_grade" class="form-control" id="view_al_grades">
                                        <option value="">Select</option>
                                        <% while (al_grades.next()) { %>
                                        <option value="<%=al_grades.getString("Grade") %>"><%=al_grades.getString("Grade") %></option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="form-group" id="al_sections">
                                    <label>Select Section</label>
                                    <select name="al_sections" class="form-control" id="view_al_sections">
                                        <option value="">Select</option>
                                        <% while (al_sections.next()) { %>
                                        <option value="<%=al_sections.getString("section_ID") %>"><%=al_sections.getString("section_name") %></option>
                                        <% } %>
                                    </select>
                                </div>
                                    
                                <div class="form-group" id="art_classes">
                                    <label>Select Art Class</label>
                                    <select name="art_classes" class="form-control" id="view_art_classes">
                                        <option value="">Select</option>
                                        <% while (art_classes.next()) { %>
                                        <option value="<%=art_classes.getString("class") %>"><%=art_classes.getString("class") %></option>
                                        <% } %>
                                    </select>
                                </div>
                                    
                                <div class="form-group" id="maths_classes">
                                    <label>Select Maths Class</label>
                                    <select name="maths_classes" class="form-control" id="view_maths_classes">
                                        <option value="">Select</option>
                                        <% while (maths_classes.next()) { %>
                                        <option value="<%=maths_classes.getString("class") %>"><%=maths_classes.getString("class") %></option>
                                        <% } %>
                                    </select>
                                </div>
                                    
                                <div class="form-group" id="science_classes">
                                    <label>Select Science Class</label>
                                    <select name="science_classes" class="form-control" id="view_science_classes">
                                        <option value="">Select</option>
                                        <% while (science_classes.next()) { %>
                                        <option value="<%=science_classes.getString("class") %>"><%=science_classes.getString("class") %></option>
                                        <% } %>
                                    </select>
                                </div>
                                    
                                <div class="form-group" id="commerce_classes">
                                    <label>Select Commerece Class</label>
                                    <select name="commerce_classes" class="form-control" id="view_commerce_classes">
                                        <option value="">Select</option>
                                        <% while (commerce_classes.next()) { %>
                                        <option value="<%=commerce_classes.getString("class") %>"><%=commerce_classes.getString("class") %></option>
                                        <% } %>
                                    </select>
                                </div>
                                    
                                <div class="form-group" id="tech_classes">
                                    <label>Select Tech Class</label>
                                    <select name="tech_classes" class="form-control" id="view_tech_classes">
                                        <option value="">Select</option>
                                        <% while (tech_classes.next()) { %>
                                        <option value="<%=tech_classes.getString("class") %>"><%=tech_classes.getString("class") %></option>
                                        <% } %>
                                    </select>
                                </div>
                                    
                                <div class="form-group" id="regular_classes">
                                    <label>Select Regular Class</label>
                                    <select name="regular_classes" class="form-control" id="view_regular_classes">
                                        <option value="">Select</option>
                                        <% while (regular_classes.next()) { %>
                                        <option value="<%=regular_classes.getString("class") %>"><%=regular_classes.getString("class") %></option>
                                        <% } %>
                                    </select>
                                </div>
                                    
                                <div class="form-group" id="ol_classes">
                                    <label>Select O/L Class</label>
                                    <select name="ol_classes" class="form-control" id="view_ol_classes">
                                        <option value="">Select</option>
                                        <% while (ol_classes.next()) { %>
                                        <option value="<%=ol_classes.getString("class") %>"><%=ol_classes.getString("class") %></option>
                                        <% } %>
                                    </select>
                                </div>    
                            </div>
                                    <button type="submit" class="btn btn-success">submit</button>        
                        </form>
                    </div>
                                    
                    <!--view class teachers-->
                    <div class="tab-pane container fade" id="view_class_teachers">
                        <ul class="nav nav-tabs justify-content-center">
                            <li class="nav-item">
                                <a href="#regular_class_teachers" class="nav-link" data-toggle="tab">Regular Class Teachers</a>
                            </li>
                            <li class="nav-item">
                                <a href="#al_class_teachers" class="nav-link" data-toggle="tab">A/L Class Teachers</a>
                            </li>
                        </ul>
                        
                        <!--tab content-->
                        <div class="tab-content">
                            
                            <!--regular class teachers-->
                            <div class="card-body tab-pane container active" id="regular_class_teachers">
                                <h1>List of Grades</h1>
                                <% ResultSet regular_grades = Grades.viewGrades();
                                   while (regular_grades.next()) {
                                       int grade = regular_grades.getInt("Grade");
                                %>
                                <div class="form-group">
                                    <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#<%=grade %>">Grade <%=grade %></button>
                                </div>
                                    <div class="form-control collapse" id="<%=grade %>">
                                        <h1>Class Teachers for Grade <%=grade %></h1>
                                        <hr>
                                        <table class="table table-striped">
                                            <tr>
                                                <th>Class</th>
                                                <th>Class Head</th>
                                            </tr>
                                            <% ResultSet grade_classes = Grades.getClasses(grade);
                                               while (grade_classes.next()) {
                                                   String Class = grade_classes.getString("class");
                                            %>
                                            <tr>
                                                <td><%=grade %> <%=Class %></td>
                                                <% ResultSet class_teacher = Teacher.getClassTeacher(grade, Class);
                                                   while (class_teacher.next()) {
                                                       String fname = class_teacher.getString("fname");
                                                       String lname = class_teacher.getString("lname");
                                                %>
                                                <td><%=fname %> <%=lname %></td>
                                                <% } %>
                                                <td><button type="button" class="btn btn-danger">Remove</button></td>
                                            </tr>
                                            <% } %>
                                        </table>
                                    </div>
                                <% } %>
                            </div>
                            
                            <!--a/l class teachers-->
                            <div class="card-body tab-pane container fade" id="al_class_teachers">
                                <h1>List of Grades</h1>
                                <% ResultSet advanced_grades = Grades.viewALGrades();
                                    while (advanced_grades.next()) {
                                        int grade = advanced_grades.getInt("Grade");
                                %>
                                <div class="form-group">
                                    <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#<%=grade %>">Grade <%=grade %></button>
                                </div>
                                <div class="form-control collapse" id="<%=grade %>">
                                    <h1>Class Teachers for Grade <%=grade %></h1>
                                    <hr>
                                    <% ResultSet advanced_sections = Grades.getALSection(grade);
                                        while (advanced_sections.next()) {
                                            String section_ID = advanced_sections.getString("section_ID");
                                            String section_name = advanced_sections.getString("section_name");
                                    %>
                                    <p><b><%=section_name %> section</b></p>
                                    <table class="table table-striped">
                                        <tr>
                                            <th>Class</th>
                                            <th>Class Head</th>
                                        </tr>
                                        <% ResultSet classes = Grades.getSectionClasses(section_ID);
                                            while (classes.next()) {
                                                String Class = classes.getString("class");
                                        %>
                                        <tr>
                                            <td><%=grade %>-<%=Class %></td>
                                            <% ResultSet al_class_teacher = Teacher.getALClassTeacher(grade, Class);
                                                while (al_class_teacher.next()) {
                                                    String fname = al_class_teacher.getString("fname");
                                                    String lname = al_class_teacher.getString("lname");
                                            %>
                                            <td><%=fname %> <%=lname %></td>
                                            <% } %>
                                            <td><button type="button" class="btn btn-danger">Remove</button></td>
                                        </tr>
                                        <% } %>
                                    </table>
                                    <% } %>
                                </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                                    
                </div>
                
          
                        
                    
            </div>

            <!--section heads-->

            <div class="tab-pane container fade" id="section_heads">
                <h1>Hello Teachers</h1>
            </div>
            
            <!--assign classes-->
            <div class="card-body tab-pane container fade" id="class_subject_assignment">
                <div class="card-header">
                    <h1>Assign Classes</h1>
                    <ul class="nav nav-tabs justify-content-center">
                        <li class="nav-item">
                            <a href="#regular_class_subject_assign" data-toggle="tab" class="nav-link">Regular Classes</a>
                        </li>
                        <li class="nav-item">
                            <a href="#al_class_subject_assign" data-toggle="tab" class="nav-link">A/L Classes</a>
                        </li>
                    </ul>
                </div>
                
                <!--tab content-->
                <div class="tab-content">
                    
                    <!--regular class subject assignment-->
                    <div class="card-body tab-pane container active" id="regular_class_subject_assign">
                        <div class="card-header bg-primary" style="color: white">
                            <h1>Regular Classes</h1>
                        </div>
                        <form action="<%=request.getContextPath() %>/ClassSubjectAssignServlet" method="POST" class="form-control">
                            <% ResultSet class_assign_grades = Grades.viewGrades();
                                while (class_assign_grades.next()) {
                                    int grade = class_assign_grades.getInt("Grade");
                            %>
                            <div class="form-group">
                                <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#class_assign_<%=grade %>"><b>Grade <%=grade %></b></button>
                            </div>
                                <div class="form-control collapse" id="class_assign_<%=grade %>">
                                    <h2>Teachers</h2>
                                    <table class="table table-striped">
                                        <tr>
                                            <th>Teacher ID</th>
                                            <th>Teacher Name</th>
                                            <th>Subject</th>
                                        </tr>
                                        <% ResultSet teachers_for_grade = Teacher.getTeacherForGrade(grade);
                                            while (teachers_for_grade.next()) {
                                                String teacher_id = teachers_for_grade.getString("teacher_ID");
                                                String fname = teachers_for_grade.getString("fname");
                                                String lname = teachers_for_grade.getString("lname");
                                                String sub_code = teachers_for_grade.getString("sub_code");
                                                String sub_name = teachers_for_grade.getString("sub_name");
                                        %>
                                        <tr>
                                            <td><input type="radio" name="check_teachers" value="<%=teacher_id %>" class="check_teachers"><%=teacher_id %></td>
                                            <td><%=fname %> <%=lname %></td>
                                            <td><%=sub_name %></td>
                                        </tr>
                                        <% } %>
                                    </table>
                                    <h2>Classes</h2>
                                    <% ResultSet classes = Grades.getClasses(grade);
                                        while (classes.next()) {
                                            String Class = classes.getString("class");
                                    %>
                                    <div class="form-check-inline">
                                        <label class="form-check-label">
                                            <input type="checkbox" class="form-check-input" name="check_classes" data-grade="<%=grade %>" data-class="<%=Class %>" value="<%=grade %>-<%=Class %>">
                                            <%=Class %>
                                        </label>
                                    </div>
                                    <% } %>
                                </div>
                            <% } %>
                            <button type="submit" class="btn btn-success">Assign Classes</button>
                        </form>
                    </div>
                    
                    <!--a/l class subject assignment-->
                    <div class="card-body tab-pane container fade" id="al_class_subject_assign">
                        <div class="card-header bg-primary" style="color: white">
                            <h1>A/L Classes</h1>
                        </div>
                        <form action="<%=request.getContextPath() %>/ALClassSubjectAssignServlet" method="POST" class="form-control">
                            <% ResultSet class_assign_al_grades = Grades.viewALGrades();
                                while (class_assign_al_grades.next()) {
                                    int grade = class_assign_al_grades.getInt("Grade");
                            %>
                            <div class="form-group">
                                <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#class_assign_al_<%=grade %>"><b>Grade <%=grade %></b></button>
                            </div>
                                <div class="form-control collapse" id="class_assign_al_<%=grade %>">
                                    <h2>Sections</h2>
                                    <% ResultSet class_assign_al_sections = Grades.getALSection(grade);
                                        while (class_assign_al_sections.next()) {
                                            String section_ID = class_assign_al_sections.getString("section_ID");
                                            String section_name = class_assign_al_sections.getString("section_name");
                                    %>
                                    <div class="form-group">
                                        <button type="button" class="btn btn-link" style="color: red" data-toggle="collapse" data-target="#class_assign_al_section_<%=grade %>_<%=section_ID %>"><%=section_name %></button>
                                    </div>
                                        <div class="form-control collapse" id="class_assign_al_section_<%=grade %>_<%=section_ID %>">
                                            <h2>Teachers</h2>
                                            <table class="table table-striped">
                                                <tr>
                                                    <th>Teacher ID</th>
                                                    <th>Teacher Name</th>
                                                    <th>Subject</th>
                                                </tr>
                                                <% ResultSet al_subject_teachers = Teacher.getALTeachersForGrade(grade, section_ID);
                                                    while (al_subject_teachers.next()) {
                                                        String teacher = al_subject_teachers.getString("teacher_ID");
                                                        String fname = al_subject_teachers.getString("fname");
                                                        String lname = al_subject_teachers.getString("lname");
                                                        String sub_name = al_subject_teachers.getString("sub_name");
                                                %>
                                                <tr>
                                                    <td><input type="radio" class="radio_al_teachers" name="radio_al_teachers" value="<%=teacher %>"><%=teacher %></td>
                                                    <td><%=fname %> <%=lname %></td>
                                                    <td><%=sub_name %></td>
                                                </tr>
                                                <% } %>
                                            </table>
                                            <h2>Classes</h2>
                                            <% ResultSet al_classes = Grades.getSectionClasses(section_ID);
                                                while (al_classes.next()) {
                                                    String Class = al_classes.getString("class");
                                            %>
                                            <div class="form-check-inline">
                                                <label class="form-check-label">
                                                    <input type="checkbox" class="form-check-input" name="check_al_classes" data-grade="<%=grade %>" data-class="<%=Class %>" value="<%=grade %>-<%=Class %>">
                                                    <%=Class %>
                                                </label>
                                            </div>
                                            <% } %>
                                        </div>
                                    <% } %>
                                </div>
                            <% } %>
                            <button type="submit" class="btn btn-success">Assign Classes</button>
                        </form>
                    </div>
                </div>
                            
                
                
            </div>
        </div>
        
        <!--teacher subject allocations-->
        <div class="teacher_subject_allocation">
            <% ResultSet teacher_subject_allocation = Teacher.getTeacherSubjectAllocations();
                while (teacher_subject_allocation.next()) {
                    String teacher = teacher_subject_allocation.getString("teacher_ID");
                    int grade = teacher_subject_allocation.getInt("Grade");
                    String Class = teacher_subject_allocation.getString("class");
            %>
            <input type="hidden" class="view_teacher_subject_allocation" data-teacher="<%=teacher %>" data-grade="<%=grade %>" data-class="<%=Class %>">
            <% } %>
        </div>
        
        <!--a/l teacher subject allocations-->
        <div class="al_teacher_subject_allocation">
            <% ResultSet al_teacher_subject_allocation = Teacher.getALTeacherSubjectAllocations();
                while (al_teacher_subject_allocation.next()) {
                    String teacher = al_teacher_subject_allocation.getString("teacher_ID");
                    int grade = al_teacher_subject_allocation.getInt("Grade");
                    String Class = al_teacher_subject_allocation.getString("class");
            %>
            <input type="hidden" class="view_al_teacher_subject_allocation" data-teacher="<%=teacher %>" data-grade="<%=grade %>" data-class="<%=Class %>">
            <% } %>
        </div>
        
    </body>
</html>
