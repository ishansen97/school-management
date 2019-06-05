<%-- 
    Document   : subject
    Created on : Nov 10, 2018, 2:00:19 PM
    Author     : DELL
--%>
<%@page import="java.sql.*, grades.*, subjects.*, teacher.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Subject Management</title>
        <%@include file="../layouts/Navigation.jsp" %>
        <%@include file="../layouts/Scripts.jsp" %>
        <%@include file="../layouts/Styles.jsp" %>
        
        <style>
            li {
                margin-left: 20px;
            }
            .form-group {
                margin-top: 20px;
            }
            #non_al_grade {
                display: none;
            }
            #al_grade {
                display: none;
            }
            #non_al_cat {
                display: none;
            }
            #al_cat {
                display: none;
            }
            #al_sections {
                display: none;
            }
        </style>
        
    </head>
    <body class="w3-main">
        <%@include file="../layouts/admin_navigation.jsp" %>
        <script>
            function nameValidation(name) {
                var sub_name = name.toString();
                var pattern = /^[0-9]+$/;
                
                if (sub_name.match(pattern)) {
                    alert("subject name should contain text");
                    return false;
                }
                else {
                    return true;
                }
            }
            
            function typeValidation(t) {
                var type = t.toString();
                var grade,category,section,isGradeValid,isCategoryValid,isSectionValid;
                if (type === "non_al") {
                    grade = document.forms["add_subjects"]["grade"].value;
                    category = document.forms["add_subjects"]["category"].value;
                    
                    if (grade === "") {
                        alert("Please select a grade");
                        isGradeValid = false;
                    }
                    else {
                        isGradeValid = true;
                    }
                    
                    if (category === "") {
                        alert("Please select a category");
                        isCategoryValid = false;
                    }
                    else {
                        isCategoryValid = true;
                    }
                    
                    return (isGradeValid && isCategoryValid);
                    
                }
                else if (type === "al") {
                    grade = document.forms["add_subjects"]["al_grade"].value;
                    category = document.forms["add_subjects"]["al_category"].value;
                    section = document.forms["add_subjects"]["al_section"].value;
                    
                    if (grade === "") {
                        alert("Please select an a level grade");
                        isGradeValid = false;
                    }
                    else {
                        isGradeValid = true;
                    }
                    
                    if (category === "") {
                        alert("Please select an a level category");
                        isCategoryValid = false;
                    }
                    else {
                        isCategoryValid = true;
                    }
                    
                    if (section === "") {
                        alert("Please select an a level section");
                        isSectionValid = false;
                    }
                    else {
                        isSectionValid = true;
                    }
                    
                    return (isGradeValid && isCategoryValid && isSectionValid);
                }
            }
            
            
            function subject_validation() {
                var type = document.forms["add_subjects"]["sub_type"].value;
                var sub_name = document.forms["add_subjects"]["subject_name"].value;
                
                var isNameValid = nameValidation(sub_name);
                var isTypeValid = typeValidation(type);
                
                return (isNameValid && isTypeValid);
                
            }
            
            $(document).ready(function() {
                $(".form-check-input").click(function() {
                    var type = $(this).val();
                    var non_al = document.getElementById("non_al_grade");
                    var al = document.getElementById("al_grade");
                    var non_al_cat = document.getElementById("non_al_cat");
                    var al_cat = document.getElementById("al_cat");
                    var al_sections = document.getElementById("al_sections");
                    
                    if (type === "non_al") {
                        non_al.style.display = "block";
                        non_al_cat.style.display = "block";
                        al.style.display = "none";
                        al_cat.style.display = "none";
                        al_sections.style.display = "none";
                    }
                    else if (type === "al") {
                        al.style.display = "block";
                        al_sections.style.display = "block";
                        al_cat.style.display = "block";
                        non_al.style.display = "none";
                        non_al_cat.style.display = "none";
                    }
                });
            });
            
            
            $(document).ready(function() {
               $("#select_al_teacher").change(function() {
                  var id = $(this).val();
                  var assigned_id;
                  var isFound = false;

                  $(".assigned_al_subjects").each(function() {
                     assigned_id = $(this).attr("data-id");
                     if (id === assigned_id) {
                         isFound = true;
                         var sub_code = $(this).attr("data-code");
                         
                         $(".form-check-input").each(function() {
                            var found_id = $(this).val();
                            if (sub_code === found_id) {
                                $(this).attr("type","hidden");
                                $(this).parent().html("");
                            }
                         });
                     }
                  });
                  if (isFound) {
                      alert("This teacher has been assigned some subjects");
                  }
                  else {
                      alert("No subjects has been assigned for this teacher");
                  }
               });
               
               $("#select_teacher").change(function() {
                  var id = $(this).val();
                  var assigned_id;
                  var isFound = false;

                  $(".assigned_subjects").each(function() {
                     assigned_id = $(this).attr("data-id");
                     if (id === assigned_id) {
                         isFound = true;
                         var sub_code = $(this).attr("data-code");
                         
                         $(".form-check-input").each(function() {
                            var found_id = $(this).val();
                            if (sub_code === found_id) {
                                $(this).attr("type","hidden");
                                $(this).parent().html("");
                            }
                         });
                     }
                  });
                  if (isFound) {
                      alert("This teacher has been assigned some subjects");
                  }
                  else {
                      alert("No subjects has been assigned for this teacher");
                  }
               });
               
                $("#regular_assigned").click(function() {
                    $(".view_assigned_subjects").each(function() {
                        var assigned_sub_code = $(this).attr("data-code");
                        
                        $(".form-check-input").each(function() {
                           var sub_code = $(this).val();
                           if (assigned_sub_code === sub_code) {
                               $(this).attr("type", "hidden");
                               $(this).parent().html("");
                           }
                         });
                    });
                });
                
                $("#regular_non_assigned").click(function() {
                    $(".view_non_assigned_subjects").each(function() {
                        var assigned_sub_code = $(this).attr("data-code");
                        
                        $(".form-check-input").each(function() {
                           var sub_code = $(this).val();
                           if (assigned_sub_code === sub_code) {
                               $(this).attr("type", "hidden");
                               $(this).parent().html("");
                           }
                         });
                    });
                });
                
                $("#al_assigned").click(function() {
                    $(".view_non_assigned_al_subjects").each(function() {
                        var assigned_sub_code = $(this).attr("data-code");
                        
                        $(".form-check-input").each(function() {
                           var sub_code = $(this).val();
                           if (assigned_sub_code === sub_code) {
                               $(this).attr("type", "hidden");
                               $(this).parent().html("");
                           }
                         });
                    });
                });
                
                $("#al_non_assigned").click(function() {
                    $(".view_assigned_al_subjects").each(function() {
                        var assigned_sub_code = $(this).attr("data-code");
                        
                        $(".form-check-input").each(function() {
                           var sub_code = $(this).val();
                           if (assigned_sub_code === sub_code) {
                               $(this).attr("type", "hidden");
                               $(this).parent().html("");
                           }
                         });
                    });
                });
                
                $(".btn-primary").click(function() {
                   $(this).parent().parent().find("input[type=checkbox]").attr("checked","checked");
                });
                
                $(".btn-danger").click(function() {
                   var checked = $(this).parent().parent().find("input[type=checkbox]").attr("checked");
                   if (checked === "checked") {
                       $(this).parent().parent().find("input[type=checkbox]").attr("checked", false);
                   }
                });
                    
            });
        </script>
        
        <% ResultSet grades = Grades.viewGrades(); 
           ResultSet assign_grades = Grades.viewGrades();
           
           ResultSet al_grades = Grades.viewALGrades(); 
           ResultSet assign_al_grades = Grades.viewALGrades();
           
           ResultSet categories = Subject.getSubjectCategories();
           ResultSet al_categories = Subject.getALSubjectCategories();
           ResultSet al_sections = Grades.getALSection();
           ResultSet subjects = Subject.getSubjects();
           ResultSet al_subjects = Subject.getALSubjects();
           
           ResultSet allsubjects = Subject.getSubjects();
           
//           assigning teachers
           ResultSet teachers = Teacher.getAllTeachers();
           ResultSet view_assigned_subjects = Subject.getSubjectsAssigned();
        %>
        
        <div class="container-fluid">
            <div class="row">
                <ul class="nav nav-tabs justify-content-center" style="margin: auto; margin-top: 50px">
                    <li class="nav-item">
                        <a href="#add_subjects" data-toggle="tab" class="nav-link">Add Subjects</a>
                    </li>
                    <li class="nav-item">
                        <a href="#view_subjects" data-toggle="tab" class="nav-link">View Subjects</a>
                    </li>
                    <li class="nav-item">
                        <a href="#assign_teachers" data-toggle="tab" class="nav-link">Assign Teachers</a>
                    </li>
                    <li class="nav-item">
                        <a href="#credit_points" data-toggle="tab" class="nav-link">Credit Points</a>
                    </li>
                </ul>
            </div>
        </div>
        
        <!--tab content-->
        <div class="tab-content">
            <!--adding subjects-->
            <div class="card tab-pane container fade" id="add_subjects">
                <div class="card-header">
                    <h1>Add Subjects</h1>
                </div>
                <div class="card-body bg-primary">
                    <form action="<%=request.getContextPath() %>/AddSubjectServlet" method="POST" name="add_subjects" class="form-control" onsubmit="return subject_validation()">
                        <label>Select Subject Class</label>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input type="radio" name="sub_type" value="non_al" class="form-check-input" required>Non A/L
                            </label>
                        </div>
                        <div class="form-check">
                            <label class="form-check-label">
                                <input type="radio" name="sub_type" value="al" class="form-check-input" required>A/L
                            </label>
                        </div>
                        <div class="form-group">
                            <label for="subject_name">Subject Name</label>
                            <input type="text" name="subject_name" class="form-control">
                        </div>
                        <div class="form-group" id="non_al_grade">
                            <label for="grade">Grade</label>
                            <select name="grade" class="form-control">
                                <option value="">select</option>
                                <% while (grades.next()) { %>
                                <option value="<%=grades.getString("Grade") %>"><%=grades.getString("Grade") %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group" id="al_grade">
                            <label for="al_grade">A/L Grade</label>
                            <select name="al_grade" class="form-control">
                                <option value="">select</option>
                                <% while (al_grades.next()) { %>
                                <option value="<%=al_grades.getString("Grade") %>"><%=al_grades.getString("Grade") %></option>
                                <% } %>
                            </select>
                        </div> 
                        <div class="form-group" id="al_sections">
                            <label for="al_section">A/L sections</label>
                            <select name="al_section" class="form-control" >
                                <option value="">select</option>
                                <% while (al_sections.next()) { %>
                                <option value="<%=al_sections.getString("section_ID") %>"><%=al_sections.getString("section_name") %></option>
                                <% } %>
                            </select>
                        </div>    
                        <div class="form-group" id="non_al_cat">
                            <label for="category">Category</label>
                            <select name="category" class="form-control">
                                <option value="">select</option>
                                <% while (categories.next()) { %>
                                <option value="<%=categories.getString("category_code") %>"><%=categories.getString("category_name") %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group" id="al_cat">
                            <label for="al_category">A/L Category</label>
                            <select name="al_category" class="form-control">
                                <option value="">select</option>
                                <% while (al_categories.next()) { %>
                                <option value="<%=al_categories.getString("category_code") %>"><%=al_categories.getString("category_name") %></option>
                                <% } %>
                            </select>
                        </div>    
                        <div class="form-group">
                            <label for="credits">Credits Allocated</label>
                            <select name="credits" class="form-control" required>
                                <option value="">select</option>
                                <option value="4.0">4.0</option>
                                <option value="3.0">3.0</option>
                                <option value="2.0">2.0</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-success">Add</button>
                            <button type="reset" class="btn btn-danger">Reset</button>
                        </div>    
                    </form>
                </div>
            </div>
            
            <!--viewing subjects-->
            <div class="card tab-pane container fade" id="view_subjects">
                <div class="card-header">
                    <ul class="nav nav-tabs bg-white">
                        <li class="nav-item">
                            <a href="#regular_subjects" data-toggle="tab" class="nav-link">Regular Subjects</a>
                        </li>
                        <li class="nav-item">
                            <a href="#al_subjects" data-toggle="tab" class="nav-link">A/L Subjects</a>
                        </li>
                    </ul>
                    <h1>View subjects</h1>
                    <form>
                        <div class="input-group">
                            <span class="input-group-prepend">Search</span>
                            <input type="text" class="input-group-prepend">
                        </div>
                    </form>
                </div>
                
                <div class="tab-content">
                    <!--regular subjects-->
                    <div class="card-body bg-primary tab-pane container fade" id="regular_subjects">
                        <table class="table table-striped bg-light">
                            <tr>
                                <th>Subject code</th>
                                <th>Subject Name</th>
                                <th>Grade</th>
                                <th>Credits</th>
                                <th>Category</th>
                            </tr>
                            <% while (subjects.next()) { %>
                            <tr>
                                <td><%=subjects.getString("sub_code") %></td>
                                <td><%=subjects.getString("sub_name") %></td>
                                <td><%=subjects.getString("grade") %></td>
                                <td><%=subjects.getString("credits") %></td>
                                <td><%=subjects.getString("category_name") %></td>
                                <td><a href="admin_profile.jsp?id=<%=subjects.getString("sub_code") %>" class="btn btn-success" >Update</a></td>
                                <td><a href="admin_profile.jsp?id=<%=subjects.getString("sub_code") %>" class="btn btn-danger" >Delete</a></td>
                            </tr>
                            <% } %>
                        </table>
                    </div>
                    
                    <!--a/l subjects-->
                    <div class="card-body bg-primary tab-pane container fade" id="al_subjects">
                        <table class="table table-striped bg-light">
                            <tr>
                                <th>Subject code</th>
                                <th>Subject Name</th>
                                <th>Grade</th>
                                <th>Section</th>
                                <th>Credits</th>
                                <th>Category</th>
                            </tr>
                            <% while (al_subjects.next()) { %>
                            <tr>
                                <td><%=al_subjects.getString("sub_code") %></td>
                                <td><%=al_subjects.getString("sub_name") %></td>
                                <td><%=al_subjects.getString("grade") %></td>
                                <td><%=al_subjects.getString("section_name") %></td>
                                <td><%=al_subjects.getString("credits") %></td>
                                <td><%=al_subjects.getString("category_name") %></td>
                                <td><a href="admin_profile.jsp?id=<%=al_subjects.getString("sub_code") %>" class="btn btn-success" >Update</a></td>
                                <td><a href="admin_profile.jsp?id=<%=al_subjects.getString("sub_code") %>" class="btn btn-danger" >Delete</a></td>
                            </tr>
                            <% } %>
                        </table>
                    </div>
                </div>    
            </div>
            
            <!--assign teachers-->
            <div class="card tab-pane container fade" id="assign_teachers">
                <ul class="nav nav-tabs justify-content-center">
                    <li class="nav-item">
                        <a href="#regular_subject_teachers" data-toggle="tab" class="nav-link">Regular Subjects</a>
                    </li>
                    <li class="nav-item">
                        <a href="#al_subject_teachers" data-toggle="tab" class="nav-link">A/L Subjects</a>
                    </li>
                </ul>
                
                <!--tab content-->
                <div class="tab-content">
                
                    <!--assigning regular subjects-->
                    <div class="card-body tab-pane container fade" id="regular_subject_teachers">
                        <h1>Assign Teachers</h1>
                        <form action="<%=request.getContextPath() %>/AssignSubjectServlet" name="assign_teachers" class="form-control">
                            <div class="form-group">
                                <label for="teacher_name">Teacher Name</label>
                                <select name="teacher_name" class="form-control" id="select_teacher">
                                    <option value="">select</option>
                                    <% while (teachers.next()) { %>
                                    <option value="<%=teachers.getString("teacher_ID") %>" data-value="<%=teachers.getString("fname") %>"><%=teachers.getString("fname") %> <%=teachers.getString("lname") %></option>
                                    <% } %>
                                </select>
                            </div>
                            <% while (assign_grades.next()) { %>  
                                <div class="form-group">
                                    <label><b>Grade <%=assign_grades.getInt("Grade") %></b></label>
                                </div>
                                    <% ResultSet subjects_for_grade = Subject.getSubjectsForGrade(assign_grades.getInt("Grade")); %>
                                    <% while (subjects_for_grade.next()) { %> 
                                        <div class="form-check-inline">
                                            <label class="form-check-label">
                                                <input type="checkbox" class="form-check-input" name="subjects" data-value="<%=subjects_for_grade.getString("sub_name") %>" value="<%=subjects_for_grade.getString("sub_code") %>">
                                                <%=subjects_for_grade.getString("sub_name") %>
                                            </label>
                                        </div>
                                    <% } %>

                            <% } %>
                            <div class="form-group">
                                <button type="submit" class="btn btn-success">Submit</button>
                                <button type="button" class="btn btn-primary" id="regular_assigned">Show Assigned Subjects</button>
                                <button type="button" class="btn btn-danger" id="regular_non_assigned">Show Non-assigned Subjects</button>    
                            </div>
                        </form>
                    </div>
                            
                    <!--assigning a/l subjects-->
                    <div class="card-body tab-pane container fade" id="al_subject_teachers">
                        <h1>Assign Teachers</h1>
                        <form action="<%=request.getContextPath() %>/AssignALSubjectServlet" method="POST" name="assign_al_subjects" class="form-control">
                            <% ResultSet all_teachers = Teacher.getAllTeachers(); 
                            %>
                            <div class="form-group">
                                <label><b>Teacher Name</b></label>
                                <select name="al_teacher" class="form-control" id="select_al_teacher">
                                    <option value="">select</option>
                                    <% while (all_teachers.next()) {
                                        String teacher_ID = all_teachers.getString("teacher_ID");
                                        String fname = all_teachers.getString("fname");
                                        String lname = all_teachers.getString("lname");
                                    %>
                                    <option value="<%=teacher_ID %>"><%=fname %> <%=lname %></option>
                                    <% } %>
                                </select>
                            </div>
                            <% while (assign_al_grades.next()) {
                                int grade = assign_al_grades.getInt("Grade");
                            %>
                            <div class="form-group">
                                <label><b>Grade <%=grade %></b></label>
                                <% ResultSet section_grade = Grades.getALSection(grade);
                                    while (section_grade.next()) {
                                        String section_ID = section_grade.getString("section_ID");
                                        String section_name = section_grade.getString("section_name");
                                %>
                                <div class="form-control">
                                    <div class="form-group">
                                        <p><b><%=section_name %> Section</b></p>
                                        <% ResultSet section_subjects = Subject.getSectionSubjects(grade, section_ID);
                                            while (section_subjects.next()) {
                                                String sub_code = section_subjects.getString("sub_code");
                                                String sub_name = section_subjects.getString("sub_name");
                                        %>
                                        <div class="form-check-inline">
                                            <label class="form-check-label">
                                                <input type="checkbox" class="form-check-input" name="al_subject_check" data-value="<%=sub_name %>" value="<%=sub_code %>">
                                                <%=sub_name %>
                                            </label>
                                        </div>
                                        <% } %>
                                    </div>
                                </div>
                                <% } %>    
                            </div>
                            <% } %>
                            <button type="submit" class="btn btn-success">Submit</button>
                            <button type="button" class="btn btn-primary" id="al_assigned">Show Assigned Subjects</button>
                            <button type="button" class="btn btn-danger" id="al_non_assigned">Show Non-assigned Subjects</button>
                        </form>
                    </div>
                </div>
                
            </div>
            
            <!--credit points-->
            <div class="card-body tab-pane container fade" id="credit_points">
                <div class="card-header">
                    <ul class="nav nav-tabs justify-content-center">
                        <li class="nav-item">
                            <a href="#regular_allocation" class="nav-link" data-toggle="tab">Regular Subjects</a>
                        </li>
                        <li class="nav-item">
                            <a href="#al_allocation" class="nav-link" data-toggle="tab">A/L Subjects</a>
                        </li>
                        <li class="nav-item">
                            <a href="#regular_bucket" class="nav-link" data-toggle="tab">Regular Bucket Subjects</a>
                        </li>
                        <li class="nav-item">
                            <a href="#al_bucket" class="nav-link" data-toggle="tab">A/L Bucket Subjects</a>
                        </li>
                    </ul>
                </div>
                
                <!--tab content-->
                
                <div class="tab-content">
                    <!--regular subject allocation-->
                    <div class="card-body tab-pane container active" id="regular_allocation">
                        <h1>Subject Allocation for Students</h1>
                        <form action="<%=request.getContextPath() %>/StudentSubjectAllocationServlet" method="POST">
                            <% ResultSet subject_grades = Grades.viewGrades();
                                while (subject_grades.next()) {
                                    int grade = subject_grades.getInt("Grade");
                            %>
                            <div class="form-group">
                                <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#manage_<%=grade %>">Grade <%=grade %></button>
                            </div>
                                <div class="form-control collapse" id="manage_<%=grade %>">
                                    <h2>All Subjects for Grade <%=grade %></h2>
                                    <p style="color: red">Tick the compulsory subjects</p>
                                    <% ResultSet subjects_for_grade = Subject.getSubjectsWithNoStudents(grade);
                                        while (subjects_for_grade.next()) {
                                            String sub_code = subjects_for_grade.getString("sub_code");
                                            String sub_name = subjects_for_grade.getString("sub_name");
                                    %>
                                    <div class="form-check-inline">
                                        <label class="form-check-label">
                                            <input type="checkbox" class="form-check-input" name="compulsory_subjects" id="manage_subjects" value="<%=sub_code %>">
                                            <%=sub_name %>
                                        </label>
                                    </div>
                                    <% } %>
                                    <div class="form-group" style="margin-top: 20px;">
                                        <button type="button" class="btn btn-primary" id="select_compulsory">Select All</button>
                                        <button type="button" class="btn btn-danger" id="deselect_compulsory">Deselect All</button>
                                    </div>
                                </div>
                            <% } %>
                            <div class="fotm-group">
                                <button type="submit" class="btn btn-success">Allocate</button>
                            </div>
                        </form>
                    </div>
                            
                    <!--a/l subject allocation-->
                    <div class="card-body tab-pane container fade" id="al_allocation">
                        <h1>Subject Allocation for A/L Students</h1>
                        <form action="<%=request.getContextPath() %>/ALSubjectAllocationServlet" method="POST">
                            <% ResultSet al_subject_grades = Grades.viewALGrades();
                                while (al_subject_grades.next()) {
                                    int grade = al_subject_grades.getInt("Grade");
                            %>
                            <div class="form-group">
                                <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#manage_al_<%=grade %>">Grade <%=grade %></button>
                            </div>
                                <div class="form-control collapse" id="manage_al_<%=grade %>">
                                    <% ResultSet view_al_sections = Grades.getALSection(grade);
                                        while (view_al_sections.next()) {
                                            String section_ID = view_al_sections.getString("section_ID");
                                            String section_name = view_al_sections.getString("section_name");
                                    %>
                                    <div class="form-group">
                                        <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#<%=grade %><%=section_ID %>"><b><%=section_name %></b></button>
                                    </div>
                                        <div class="form-control collapse" id="<%=grade %><%=section_ID %>">
                                            <h1>Subjects</h1>
                                            <% ResultSet section_subjects = Subject.getALSubjectsWithNoStudents(grade, section_ID);
                                                while (section_subjects.next()) {
                                                    String sub_code = section_subjects.getString("sub_code");
                                                    String sub_name = section_subjects.getString("sub_name");
                                            %>
                                            <div class="form-check-inline">
                                                <label class="form-check-label">
                                                    <input type="checkbox" class="form-check-input" name="al_compulsory_subjects" value="<%=sub_code %>">
                                                    <%=sub_name %>
                                                </label>
                                            </div>
                                            <% } %>
                                            <div class="form-group">    
                                                <button type="button" class="btn btn-primary" id="select_al_compulsory">Select ALL</button>
                                                <button type="button" class="btn btn-danger" id="deselect_al_compulsory">Deselect ALL</button>
                                            </div>
                                        </div>
                                    <% } %>
                                </div>
                            <% } %>
                            <button type="submit" class="btn btn-success">Allocate</button>
                        </form>
                    </div>
                            
                    <!--regular bucket subjects-->
                    <div class="card-body tab-pane container fade" id="regular_bucket">
                        <div class="card-header">
                            <h1>Regular Bucket Subjects</h1>
                        </div>
                                <form action="<%=request.getContextPath() %>/BucketSubjectServlet" method="POST">
                                <% ResultSet regular_bucket_grades = Grades.viewGrades();
                                    while (regular_bucket_grades.next()) {
                                        int grade = regular_bucket_grades.getInt("Grade");
                                %>
                                <div class="form-group">
                                    <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#regular_bucket_<%=grade %>">Grade <%=grade %></button>
                                </div>
                                    <div class="form-control collapse" id="regular_bucket_<%=grade %>">
                                        <h2>All Subjects for Grade <%=grade %></h2>
                                        <p style="color: red">Tick the Bucket subjects</p>
                                        <% ResultSet subjects_for_grade = Subject.getNonBucketSubjects(grade);
                                            while (subjects_for_grade.next()) {
                                                String sub_code = subjects_for_grade.getString("sub_code");
                                                String sub_name = subjects_for_grade.getString("sub_name");
                                        %>
                                        <div class="form-check-inline">
                                            <label class="form-check-label">
                                                <input type="checkbox" class="form-check-input" name="bucket_subjects" value="<%=sub_code %>">
                                                <%=sub_name %>
                                            </label>
                                        </div>
                                        <% } %>
                                        <div class="form-group" style="margin-top: 20px;">
                                            <button type="button" class="btn btn-primary">Select All</button>
                                            <button type="button" class="btn btn-danger">Deselect All</button>
                                        </div>
                                    </div>
                                <% } %>
                                <div class="fotm-group">
                                    <button type="submit" class="btn btn-success">Add Bucket Subjects</button>
                                </div>
                            </form>
                        
                    </div>
                                
                    <!--a/l bucket subjects-->
                    <div class="card-body tab-pane container fade" id="al_bucket">
                        <div class="card-header">
                            <h1>A/L Bucket Subjects</h1>
                        </div>
                        <form action="<%=request.getContextPath() %>/ALBucketSubjectServlet" method="POST">
                            <% ResultSet al_bucket_grades = Grades.viewALGrades();
                                while (al_bucket_grades.next()) {
                                    int grade = al_bucket_grades.getInt("Grade");
                            %>
                            <div class="form-group">
                                <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#al_bucket_<%=grade %>">Grade <%=grade %></button>
                            </div>
                                <div class="form-control collapse" id="al_bucket_<%=grade %>">
                                    <% ResultSet view_al_sections = Grades.getALSection(grade);
                                        while (view_al_sections.next()) {
                                            String section_ID = view_al_sections.getString("section_ID");
                                            String section_name = view_al_sections.getString("section_name");
                                    %>
                                    <div class="form-group">
                                        <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#al_bucket_<%=grade %><%=section_ID %>"><b><%=section_name %></b></button>
                                    </div>
                                        <div class="form-control collapse" id="al_bucket_<%=grade %><%=section_ID %>">
                                            <h1>Subjects</h1>
                                            <% ResultSet section_subjects = Subject.getALNonBucketSubjects(grade, section_ID);
                                                while (section_subjects.next()) {
                                                    String sub_code = section_subjects.getString("sub_code");
                                                    String sub_name = section_subjects.getString("sub_name");
                                            %>
                                            <div class="form-check-inline">
                                                <label class="form-check-label">
                                                    <input type="checkbox" class="form-check-input" name="al_bucket_subjects" value="<%=sub_code %>">
                                                    <%=sub_name %>
                                                </label>
                                            </div>
                                            <% } %>
                                            <div class="form-group">    
                                                <button type="button" class="btn btn-primary">Select ALL</button>
                                                <button type="button" class="btn btn-danger">Deselect ALL</button>
                                            </div>
                                        </div>
                                    <% } %>
                                </div>
                            <% } %>
                            <button type="submit" class="btn btn-success">Add Bucket Subjects</button>
                        </form>
                        
                    </div>
                </div>
                
                
            </div>
            
            <!--view assigned subjects-->
            <div id="teacher_subjects">
                <% while (view_assigned_subjects.next()) {
                    String teacher_ID = view_assigned_subjects.getString("teacher_ID");
                    String subject_code = view_assigned_subjects.getString("sub_code");
                %>
                <input type="hidden" class="assigned_subjects" data-id="<%=teacher_ID %>" data-code="<%=subject_code %>">
                <% } %>
            </div>
            
            <div id="al_teacher_subjects">
                <% ResultSet view_assigned_al_subjects = Subject.getALSubjectsAssigned();
                   while (view_assigned_al_subjects.next()) {
                    String teacher_ID = view_assigned_al_subjects.getString("teacher_ID");
                    String subject_code = view_assigned_al_subjects.getString("sub_code");
                %>
                <input type="hidden" class="assigned_al_subjects" data-id="<%=teacher_ID %>" data-code="<%=subject_code %>">
                <% } %>
            </div>
            
            <div id="assigned_subjects">
                <% ResultSet assigned_subjects = Subject.getAssignedSubject();
                    while (assigned_subjects.next()) {
                        String sub_code = assigned_subjects.getString("sub_code");
                %>
                <input type="hidden" class="view_assigned_subjects" data-code="<%=sub_code %>">
                <% } %>
            </div>
            
            <div id="non_assigned_subjects">
                <% ResultSet non_assigned_subjects = Subject.getNonAssignedSubject();
                    while (non_assigned_subjects.next()) {
                        String sub_code = non_assigned_subjects.getString("sub_code");
                %>
                <input type="hidden" class="view_non_assigned_subjects" data-code="<%=sub_code %>">
                <% } %>
            </div>
            
            <div id="non_assigned_al_subjects">
                <% ResultSet non_assigned_al_subjects = Subject.getNonAssignedALSubject();
                    while (non_assigned_al_subjects.next()) {
                        String sub_code = non_assigned_al_subjects.getString("sub_code");
                %>
                <input type="hidden" class="view_non_assigned_al_subjects" data-code="<%=sub_code %>">
                <% } %>
            </div>
            
            <div id="assigned_al_subjects">
                <% ResultSet assigned_al_subjects = Subject.getAssignedALSubject();
                    while (assigned_al_subjects.next()) {
                        String sub_code = assigned_al_subjects.getString("sub_code");
                %>
                <input type="hidden" class="view_assigned_al_subjects" data-code="<%=sub_code %>">
                <% } %>
            </div>
          
        </div>
        
    </body>
</html>
