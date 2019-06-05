<%-- 
    Document   : examination
    Created on : Nov 16, 2018, 1:00:18 PM
    Author     : DELL
--%>
<%@page import="subjects.Subject"%>
<%@page import="java.sql.*, grades.*, exam.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Examination Management</title>
        <%@include file="../layouts/Navigation.jsp" %>
        <%@include file="../layouts/Scripts.jsp" %>
        <%@include file="../layouts/Styles.jsp" %>
        
        <style>
            .form-group {
                margin-top: 20px;
            }
            #sections {
                display: none;
            }
            #al_grades {
                display: none;
            }
        </style>
    </head>
    <body class="w3-main">
        <script>
            $(document).ready(function() {
                $("input[type=radio]").click(function() {
                    var radio = $(this).val();
                    var grades = document.getElementById("grades");
                    var al_grades = document.getElementById("al_grades");
                    var sections = document.getElementById("sections");
                    
                    if (radio === "non_al") {
                        grades.style.display = "block";
                        al_grades.style.display = "none";
                        sections.style.display = "none";
                    }
                    else if (radio === "al") {
                        al_grades.style.display = "block";
                        sections.style.display = "block";
                        grades.style.display = "none";
                    }
                });
            });
            
            $(document).ready(function() {
               $(".btn-primary").click(function() {
                   $(this).parent().find("input[type=checkbox]").attr("checked",true);
               }) ;
            });
            
            $(document).ready(function() {
               $(".btn-danger").click(function() {
                   var checkboxes = $(this).parent().find("input[type=checkbox]");
                   var checked = checkboxes.attr("checked");
                   if (checked === "checked") {
                       checkboxes.attr("checked",false);
                   }
               });
               
//               $("#select").click(function() {
//                  var parent = $(this).parent().attr("class");
//                  alert(parent);
//               });
            });
            
            
            
        </script>
        <%@include file="../layouts/admin_navigation.jsp" %>
        <% ResultSet semesters = Exam.getSemesters(); 
           ResultSet grades = Grades.viewGrades();
           ResultSet regular_grades = Grades.viewGrades();
           ResultSet al_grades = Grades.viewALGrades();
           ResultSet al_grades1 = Grades.viewALGrades();
           ResultSet al_sections = Grades.getALSection();
           ResultSet exams = Exam.getExams();
           ResultSet al_exams = Exam.getALExams();
        %>
        
        <div class="container-fluid">
            <div class="row">
                <ul class="nav nav-tabs justify-content-center" style="margin: auto; margin-top: 50px">
                    <li class="nav-item">
                        <a href="#add_exam" data-toggle="tab" class="nav-link">Add Examinations</a>
                    </li>
                    <li class="nav-item">
                        <a href="#view_exam" data-toggle="tab" class="nav-link">View Examinations</a>
                    </li>
                    <li class="nav-item">
                        <a href="#assign_subjects" data-toggle="tab" class="nav-link">Assign Subjects</a>
                    </li>
                </ul>
            </div>
        </div>
        
        <!--add exam-->
        <div class="tab-content">
            <div class="card tab-pane container active" id="add_exam">
                <div class="card-header">
                    <h1>Add Exam</h1>
                </div>
                <div class="card-body bg-light">
                    <form action="<%=request.getContextPath() %>/ExamServlet" method="POST" name="add_exam" class="form-control">
                        <label><b>Select Exam Category</b></label>
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
                        <div class="form-group">
                            <label><b>Exam name</b></label>
                            <input type="text" name="exam_name" class="form-control" required>
                        </div>
                        <div class="form-group" id="grades">
                            <label><b>Grade</b></label>
                            <select name="grade" class="form-control">
                                <option value="">select</option>
                                <% while (grades.next()) { %>
                                <option value="<%=grades.getString("Grade") %>"><%=grades.getString("Grade") %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group" id="al_grades">
                            <label><b>Grade</b></label>
                            <select name="al_grade" class="form-control"id="al_grade_select">
                                <option value="">select</option>
                                <% while (al_grades.next()) { %>
                                <option value="<%=al_grades.getString("Grade") %>"><%=al_grades.getString("Grade") %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group" id="sections">
                            <label><b>Section</b></label>
                            <select name="al_sections" class="form-control" id="al_sections">
                                <option value="">select</option>
                                <% while (al_sections.next()) { %>
                                <option value="<%=al_sections.getString("section_ID") %>"><%=al_sections.getString("section_name") %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><b>Semester</b></label>
                            <select name="semester" class="form-control" required>
                                <option value="">select</option>
                                <% while (semesters.next()) { %>
                                <option value="<%=semesters.getString("semester_num") %>"><%=semesters.getString("Year") %> - <%=semesters.getString("semester_num") %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-success">Submit</button>
                            <button type="reset" class="btn btn-danger">Reset</button>
                        </div>
                    </form>
                </div>
            </div>
                            
            <!--view examinations-->
            <div class="card tab-pane container fade" id="view_exam">
                <div class="card-header">
                    <ul class="nav nav-tabs justify-content-center">
                        <li class="nav-item">
                            <a href="#exams" class="nav-link" data-toggle="tab">Regular Exams</a>
                        </li>
                        <li class="nav-item">
                            <a href="#al_exams" class="nav-link" data-toggle="tab">A/L Exams</a>
                        </li>
                        <li class="nav-item">
                            <a href="#regular_exam_overview" class="nav-link" data-toggle="tab">Regular Exam Overview</a>
                        </li>
                        <li class="nav-item">
                            <a href="#al_exam_overview" class="nav-link" data-toggle="tab">A/L Exam Overview</a>
                        </li>
                    </ul>
                </div>
                
                <div class="tab-content">
                        <!--regular exams-->
                        <div class="card-body bg-primary tab-pane container active" id="exams">
                            <table class="table table-striped bg-light">
                                <tr>
                                    <th>Exam ID</th>
                                    <th>Exam Name</th>
                                    <th>Grade</th>
                                    <th>Semester</th>
                                </tr>
                                <% while (exams.next()) { %>
                                <tr>
                                    <td><%=exams.getString("exam_ID") %></td>
                                    <td><%=exams.getString("exam_name") %></td>
                                    <td><%=exams.getString("grade") %></td>
                                    <td><%=exams.getString("semester") %></td>
                                </tr>
                                <% } %>
                            </table>
                        </div>
                            
                        <!--a/l exams-->  
                        <div class="card-body bg-primary tab-pane container fade" id="al_exams">
                            <table class="table table-striped bg-light">
                                <tr>
                                    <th>Exam ID</th>
                                    <th>Exam Name</th>
                                    <th>Grade</th>
                                    <th>Section</th>
                                    <th>Semester</th>
                                </tr>
                                <% while (al_exams.next()) { %>
                                <tr>
                                    <td><%=al_exams.getString("exam_ID") %></td>
                                    <td><%=al_exams.getString("exam_name") %></td>
                                    <td><%=al_exams.getString("Grade") %></td>
                                    <td><%=al_exams.getString("section") %></td>
                                    <td><%=al_exams.getString("semester") %></td>
                                </tr>
                                <% } %>
                            </table>
                        </div>
                            
                        <!--regular exam overview-->
                        <div class="card-body tab-pane container fade" id="regular_exam_overview">
                            <div class="card-header">
                                <h1>Regular Exams Overview</h1>
                            </div>
                            <% ResultSet view_regular_grades = Grades.viewGrades();
                                    while (view_regular_grades.next()) {
                                        int grade = view_regular_grades.getInt("Grade");
                                %>
                                <div class="form-group">
                                    <button class="btn btn-link" data-toggle="collapse" data-target="#regular_exam_<%=grade %>">Grade <%=grade %></button>
                                </div>
                                    <div class="form-control collapse" id="regular_exam_<%=grade %>">
                                        <h1>Grade <%=grade %> Exams</h1>
                                        <% ResultSet exams_for_grade = Exam.getAllExamsForGrade(grade);
                                            while (exams_for_grade.next()) {
                                                String exam_ID = exams_for_grade.getString("exam_ID");
                                                String exam_name = exams_for_grade.getString("exam_name");
                                        %>
                                        <div class="form-group">
                                            <button class="btn btn-link" data-toggle="collapse" data-target="#regular_exam_<%=exam_ID %>"><b><%=exam_name %></b></button>
                                        </div>
                                            <div class="form-control collapse" id="regular_exam_<%=exam_ID %>">
                                                <h1 style="color: red">Eligible subjects for <%=exam_name %></h1>
                                                <table class="table table-striped">
                                                    <tr class="bg-primary">
                                                        <th>Subject Code</th>
                                                        <th>Subject Name</th>
                                                        <th>No Of Eligible Students</th>
                                                    </tr>
                                                    <% ResultSet exam_subjects = Exam.getExamSubjects(exam_ID);
                                                        while (exam_subjects.next()) {
                                                            String sub_code = exam_subjects.getString("sub_code");
                                                            String sub_name = exam_subjects.getString("sub_name");
                                                            int student_count = exam_subjects.getInt("no_of_students");
                                                    %>
                                                    <tr>
                                                        <td><%=sub_code %></td>
                                                        <td><%=sub_name %></td>
                                                        <td><%=student_count %></td>
                                                        <td><button type="button" class="btn btn-danger" onclick="confirm('Are you sure?')">Remove</button></td>
                                                    </tr>
                                                    <% } %>
                                                </table>
                                            </div>
                                        <% } %>
                                    </div>
                                <% } %>
                        </div>
                        <div class="card-body tab-pane container fade" id="al_exam_overview">
                            <div class="card-header">
                                <h1>A/L Exams Overview</h1>
                            </div>
                            <% ResultSet al_grades_overview = Grades.viewALGrades();
                                while (al_grades_overview.next()) {
                                    int grade = al_grades_overview.getInt("Grade");
                            %>
                            <div class="form-group">
                                <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#al_grade_<%=grade %>">Grade <%=grade %></button>
                            </div>
                                <div class="form-control collapse" id="al_grade_<%=grade %>">
                                    <h1>Sections</h1>
                                    <% ResultSet al_exam_sections = Grades.getALSection(grade);
                                        while (al_exam_sections.next()) {
                                            String section_ID = al_exam_sections.getString("section_ID");
                                            String section_name = al_exam_sections.getString("section_name");
                                    %>
                                    <div class="form-group">
                                        <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#al_exam_section_<%=grade %>_<%=section_ID %>"><b><%=section_name %></b></button>
                                    </div>
                                        <div class="form-control collapse" id="al_exam_section_<%=grade %>_<%=section_ID %>">
                                            <h2 style="color: red">View Exams</h2>
                                            <% ResultSet al_exams_for_sections = Exam.getAllALExamsForGrade(grade, section_ID);
                                                while (al_exams_for_sections.next()) {
                                                    String exam_ID = al_exams_for_sections.getString("exam_ID");
                                                    String exam_name = al_exams_for_sections.getString("exam_name");
                                            %>
                                            <div class="form-group">
                                                <button type="button" class="btn btn-link" style="color: green" data-toggle="collapse" data-target="#al_exam_<%=exam_ID %>"><%=exam_name %></button>
                                            </div>
                                                <div class="form-control collapse" id="al_exam_<%=exam_ID %>">
                                                    <table class="table table-striped">
                                                        <tr>
                                                            <th>Subject Code</th>
                                                            <th>Subject Name</th>
                                                            <th>No Of Eligible Students</th>
                                                        </tr>
                                                        <% ResultSet al_exam_subject_overview = Exam.getALExamSubjects(exam_ID);
                                                            while (al_exam_subject_overview.next()) {
                                                                String sub_code = al_exam_subject_overview.getString("sub_code");
                                                                String sub_name = al_exam_subject_overview.getString("sub_name");
                                                                int student_count = al_exam_subject_overview.getInt("no_of_students");
                                                        %>
                                                        <tr>
                                                            <td><%=sub_code %></td>
                                                            <td><%=sub_name %></td>
                                                            <td><%=student_count %></td>
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
            
            <!--assign subjects-->
            <div class="card tab-pane container fade" id="assign_subjects">
                <div class="card-header">
                    <ul class="nav nav-tabs justify-content-center">
                        <li class="nav-item">
                            <a href="#regular_subjects" data-toggle="tab" class="nav-link">Regular Subjects</a>
                        </li>
                        <li class="nav-item">
                            <a href="#al_subjects" data-toggle="tab" class="nav-link">A/L Subjects</a>
                        </li>
                    </ul>
                    
                    <!--regular subjects-->
                    <div class="tab-content">
                        <div class="card-body bg-light tab-pane container active" id="regular_subjects">
                            <h1>Regular Subjects</h1>
                            <form action="<%=request.getContextPath() %>/ExamSubjectServlet" method="POST" name="assign_subjects" class="form-control">
                                <% while (regular_grades.next()) {
                                    int grade = regular_grades.getInt("Grade");
                                %>
                                <div class="form-group">
                                    <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#<%=grade %>"><label>Grade <%=grade %></label></button>
                                    <div class="form-control collapse" id="<%=grade %>">
                                        <h1>Exams and subjects available for Grade <%=grade %></h1>
                                        <p><b>Exams</b></p>
                                        <% ResultSet exams_for_grade = Exam.getExamsForGrade(grade); 
                                       
                                        while (exams_for_grade.next()) { %>
                                        <div class="form-check-inline">
                                            <label class="form-check-label">
                                                <input type="checkbox" name="grade_exams" class="form-check-input" value="<%=exams_for_grade.getString("exam_ID") %>">
                                                <%=exams_for_grade.getString("exam_name") %>
                                            </label>
                                        </div>
                                        <% } %>
                                        <div class="form-group">
                                            <p><b>Subjects</b></p>
                                            <% ResultSet subjects_for_grade = Subject.getSubjectsForGrade(grade);
                                               while (subjects_for_grade.next()) {
                                            %>
                                            <div class="form-check-inline">
                                                <label class="form-check-label">
                                                    <input type="checkbox" class="form-check-input" name="grade_subjects" value="<%=subjects_for_grade.getString("sub_code") %>">
                                                    <%=subjects_for_grade.getString("sub_name") %>
                                                </label>
                                            </div>
                                            <% } %>
                                        </div>
                                        <button type="button" class="btn btn-primary">select all</button>
                                        <button type="button" class="btn btn-danger">deselect all</button>
                                    </div>      
                                </div>      
                                <% } %>
                                <button type="submit" class="btn btn-success">Submit</button>
                            </form>
                        </div>
                                
                        <!--a/l subjects-->
                        <div class="card-body tab-pane container fade" id="al_subjects">
                            <h1>A/L Subjects</h1>
                            <form action="<%=request.getContextPath() %>/ALExamSubjectServlet" method="POST" name="assign_al_subjects" class="form-control">
                                <% while (al_grades1.next()) {
                                    int grade = Integer.parseInt(al_grades1.getString("Grade"));
                                %>
                                <div class="form-group">
                                    <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#<%=grade %>"><label>Grade <%=grade %></label></button>
                                    <div class="form-control collapse" id="<%=grade %>">
                                        <h1 style="color: purple">Sections available for Grade <%=grade %></h1>
                                        <hr>
                                        <% ResultSet al_grade_sections = Grades.getALSection(grade);
                                            while (al_grade_sections.next()) {
                                                String section_ID = al_grade_sections.getString("section_ID");
                                                String section_name = al_grade_sections.getString("section_name");
                                        %>
                                        <p style="font-size: 25px"><b><%=section_name %></b></p>
                                        <p style="color: green"><b>Exams</b></p>
                                            <% ResultSet grade_sections = Exam.getALExamsForSection(grade, section_ID);
                                                while (grade_sections.next()) {
                                            %>
                                            <div class="form-check-inline">
                                                <label class="form-check-label">
                                                    <input type="checkbox" class="form-check-input" name="al_section_exams" value="<%=grade_sections.getString("exam_ID") %>">
                                                    <%=grade_sections.getString("exam_name") %>
                                                </label>
                                            </div>  
                                            <% } %>
                                            <hr>
                                        <p style="color: darkblue"><b>Subjects</b></p>
                                            <% ResultSet grade_subjects = Exam.getALSubjectsForSection(grade, section_ID);
                                                while (grade_subjects.next()) {
                                            %>
                                            <div class="form-check-inline">
                                                <label class="form-check-label">
                                                    <input type="checkbox" class="form-check-input" name="al_section_subjects" value="<%=grade_subjects.getString("sub_code") %>">
                                                    <%=grade_subjects.getString("sub_name") %>
                                                </label>
                                            </div>
                                            <% } %>
                                            <br>
                                            <button type="button" class="btn btn-primary" id="select">Select All</button>
                                            <button type="button" class="btn btn-danger" id="deselect">Deselect All</button>
                                            <hr style="border: 2px solid black">
                                        <% } %>
                                    </div>
                                </div>
                                <% } %>
                                <button type="submit" class="btn btn-success">Submit</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
        
    </body>
</html>
