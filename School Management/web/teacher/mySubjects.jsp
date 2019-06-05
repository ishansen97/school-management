<%-- 
    Document   : mySubjects
    Created on : Nov 10, 2018, 8:16:12 AM
    Author     : DELL
--%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="teacher.*, java.sql.*, subjects.*, grades.*, classes.*, exam.*, student.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Subjects</title>
        <%@include file="../layouts/Navigation.jsp" %>
        <%@include file="../layouts/Scripts.jsp" %>
        <%@include file="../layouts/Styles.jsp" %>
    </head>
    <body class="w3-main">
        <script>
            $(document).ready(function() {
               $(".student_marks").keyup(function() {
                   var mark = $(this).val();
                   Number(mark);
                   var student_id = $(this).attr("data-id");
                   var credits = $(this).attr("data-credits");
                   var grade_point;
                   
                   $(".student_grade_points").each(function() {
                      var student_grade = $(this).attr("data-id");
                      
                      if (student_id === student_grade) {
                        $(".view_grade_points").each(function() {
                           var lower_mark = $(this).attr("data-lower");
                           var upper_mark = $(this).attr("data-upper");
                           var points = $(this).attr("data-points");
                           
                           if (mark >= lower_mark && mark <= upper_mark) {
                               grade_point = credits * points;
                           }
                           else if (mark >= 80 && mark <= 100) {
                               grade_point = credits * 4;
                           }
                        });
                          
                          $(this).attr("value",grade_point);
//                          $(this).prop("readonly", true);
                      }
                   });
               }); 
               $(".btn-primary").click(function() {
                   var value = $(this).parent().parent().find("input[type=number]").val();
                   var exam_ID = $(this).parent().parent().find("input[type=number]").attr("data-exam");
                   var subject = $(this).parent().parent().find("input[type=number]").attr("data-subject");
                   var grade_point = $(this).parent().parent().find("input[type=text]").val();
                   var student_ID = $(this).parent().parent().find("input[type=number]").attr("data-id");
                   var grade = $(this).parent().parent().find("input[type=number]").attr("data-grade");
                   
                   if (value === "") {
                       alert("Please fill the marks column");
                   }
                   else {
                        var response = confirm("Are you sure?");

                       if (response === true) {
                            $(this).parent().parent().prop("hidden",true);
                            
                            $.post("<%=request.getContextPath() %>/ExamMarkSubmissionServlet", {exam_ID : exam_ID, student_ID : student_ID, subject : subject, marks : value, grade : grade, grade_points : grade_point}, function(data) {
                               alert(data); 
                            });
                       }
                   }
               });
              
            });
        </script>
        <% Teacher teacher = (Teacher) session.getAttribute("teacher");
            String teacher_ID = teacher.getTeacher_ID();
            DecimalFormat formatter = new DecimalFormat("#0.0");
        %>
        <%@include file="../layouts/teacher_profile_navigation.jsp" %>
        <div class="container" style="margin-top: 20px">
            <ul class="nav nav-tabs justify-content-around">
                <li class="nav-item">
                    <a href="#my_subjects" class="nav-link" data-toggle="tab">My Subjects</a>
                </li>
                <li class="nav-item">
                    <a href="#exam_marks" class="nav-link" data-toggle="tab">Exam Marks</a>
                </li>
            </ul>
        </div>
        
        <!--tab content-->
        <div class="tab-content">
            
            <!--my subjects-->
            <div class="card-body tab-pane container active" id="my_subjects">
                <div class="card-header">
                    <h1>My Subjects</h1>
                </div>
                <%  try {  
                        ResultSet[] my_grades = null;
                        my_grades = teacher.getMySubjectGrades();
                            while (my_grades[0].next()) {
                                int grade = my_grades[0].getInt("grade");
                %>
                <div class="form-control">
                    <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#my_grade_<%=grade %>"><b>Grade <%=grade %></b></button>
                </div>
                    <div class="form-control collapse" id="my_grade_<%=grade %>">
                        <h2 style="color: blue">Classes</h2>
                        <% ResultSet classes = teacher.getMyClasses(grade);
                            while (classes.next()) {
                                String Class = classes.getString("class");
                        %>
                        <div class="form-group">
                            <button type="button" class="btn btn-link" style="color: red" data-toggle="collapse" data-target="#my_class_<%=grade %>_<%=Class %>"><b><%=grade %>-<%=Class %></b></button>
                        </div>
                            <div class="form-control collapse" id="my_class_<%=grade %>_<%=Class %>">
                                <table class="table table-striped">
                                    <tr>
                                        <th>Subject Code</th>
                                        <th>Subject Name</th>
                                    </tr>
                                    <% ResultSet my_subjects = teacher.getMySubjects(grade, Class);
                                        while (my_subjects.next()) {
                                            String sub_code = my_subjects.getString("sub_code");
                                            String sub_name = my_subjects.getString("sub_name");
                                    %>
                                    <tr>
                                        <td><%=sub_code %></td>
                                        <td><%=sub_name %></td>
                                        <td><button type="button" class="btn btn-danger">Request for Change</button></td>
                                        <td><button type="button" class="btn btn-success" data-toggle="collapse" data-target="#sub_code_class_<%=sub_code %>_<%=grade %>_<%=Class %>">Show Exam marks</button></td>
                                    </tr>
                                    <tr class="form-control collapse" id="sub_code_class_<%=sub_code %>_<%=grade %>_<%=Class %>">
                                        <td colspan="4">
                                            <h2>Exams</h2>
                                            <% ResultSet[] exams = null;
                                                exams = Exam.getAnyExam(grade, Class);
                                                while (exams[0].next()) {
                                                    String exam_ID = exams[0].getString("exam_ID");
                                                    String exam_name = exams[0].getString("exam_name");
                                            %>
                                            <div class="form-control bg-primary">
                                                <button type="button" class="btn btn-link" style="color: white" data-toggle="collapse" data-target="#<%=grade %>_<%=Class %>_<%=sub_code %>_<%=exam_ID %>"><%=exam_name %></button>
                                            </div>
                                                <table class="table table-hover bg-warning collapse" id="<%=grade %>_<%=Class %>_<%=sub_code %>_<%=exam_ID %>" style="width: 100%">
                                                    <tr>
                                                        <th>Student ID</th>
                                                        <th>Student Name</th>
                                                        <th>Marks</th>
                                                        <th>Grade Points</th>
                                                    </tr>
                                                    <% ResultSet student_marks = Exam.getStudentExamMarks(exam_ID, grade, Class, sub_code);
                                                    while (student_marks.next()) {
                                                        String student_ID = student_marks.getString("student_ID");
                                                        String fname = student_marks.getString("fname");
                                                        String lname = student_marks.getString("lname");
                                                        double marks = student_marks.getDouble("marks");
                                                        double grade_points = student_marks.getDouble("grade_points");
                                                        double real_grade_points = Double.parseDouble(formatter.format(grade_points));
                                                %>
                                                <tr>
                                                    <td><%=student_ID %></td>
                                                    <td><%=fname %> <%=lname %></td>
                                                    <td>
                                                        <input type="number" class="view_student_marks" value="<%=marks %>">
                                                    </td>
                                                    <td>
                                                        <input type="number" class="view_student_grade_points" value="<%=real_grade_points %>">
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-primary">Update</button>
                                                    </td>
                                                </tr>
                                                <% } %>
                                                </table>
                                            <% } %>
                                        </td>
                                    </tr>
                                    <% } %>
                                </table>
                            </div>
                        <% } %>
                    </div>
                    <% } %>
                    <% while (my_grades[1].next()) {
                        int grade = my_grades[1].getInt("grade");
                    %>
                    <div class="form-control">
                        <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#my_al_grade_<%=grade %>"><b>Grade <%=grade %></b></button>
                    </div>
                    <div class="form-control collapse" id="my_al_grade_<%=grade %>">
                        <h2 style="color: blue">Classes</h2>
                        <% ResultSet classes = teacher.getMyClasses(grade);
                            while (classes.next()) {
                                String Class = classes.getString("class");
                        %>
                        <div class="form-group">
                            <button type="button" class="btn btn-link" style="color: red" data-toggle="collapse" data-target="#my_class_<%=grade %>_<%=Class %>"><b><%=grade %>-<%=Class %></b></button>
                        </div>
                            <div class="form-control collapse" id="my_class_<%=grade %>_<%=Class %>">
                                <table class="table table-striped">
                                    <tr>
                                        <th>Subject Code</th>
                                        <th>Subject Name</th>
                                    </tr>
                                    <% ResultSet my_subjects = teacher.getMySubjects(grade, Class);
                                        while (my_subjects.next()) {
                                            String sub_code = my_subjects.getString("sub_code");
                                            String sub_name = my_subjects.getString("sub_name");
                                    %>
                                    <tr>
                                        <td><%=sub_code %></td>
                                        <td><%=sub_name %></td>
                                        <td><button type="button" class="btn btn-danger">Request for Change</button></td>
                                        <td><button type="button" class="btn btn-success" data-toggle="collapse" data-target="#sub_code_class_<%=sub_code %>_<%=grade %>_<%=Class %>">Show Exam marks</button></td>
                                    </tr>
                                    <tr class="collapse" id="sub_code_class_<%=sub_code %>_<%=grade %>_<%=Class %>">
                                        <td colspan="4">
                                            <h2>Exams</h2>
                                            <% ResultSet[] exams = null;
                                                exams = Exam.getAnyExam(grade, Class);
                                                while (exams[1].next()) {
                                                    String exam_ID = exams[1].getString("exam_ID");
                                                    String exam_name = exams[1].getString("exam_name");
                                            %>
                                            <div class="form-control bg-primary">
                                                <button type="button" class="btn btn-link" style="color: white" data-toggle="collapse" data-target="#<%=grade %>_<%=Class %>_<%=sub_code %>_<%=exam_ID %>"><%=exam_name %></button>
                                            </div>
                                            <table class="table table-hover bg-warning collapse" id="<%=grade %>_<%=Class %>_<%=sub_code %>_<%=exam_ID %>" style="width: 100%">
                                                <tr>
                                                    <th>Student ID</th>
                                                    <th>Student Name</th>
                                                    <th>Marks</th>
                                                    <th>Grade Points</th>
                                                </tr>
                                                <% ResultSet student_marks = Exam.getStudentExamMarks(exam_ID, grade, Class, sub_code);
                                                    while (student_marks.next()) {
                                                        String student_ID = student_marks.getString("student_ID");
                                                        String fname = student_marks.getString("fname");
                                                        String lname = student_marks.getString("lname");
                                                        double marks = student_marks.getDouble("marks");
                                                        double grade_points = student_marks.getDouble("grade_points");
                                                        double real_grade_points = Double.parseDouble(formatter.format(grade_points));
                                                %>
                                                <tr>
                                                    <td><%=student_ID %></td>
                                                    <td><%=fname %> <%=lname %></td>
                                                    <td>
                                                        <input type="number" class="view_student_marks" data-student="<%=student_ID %>" value="<%=marks %>" readonly>
                                                    </td>
                                                    <td>
                                                        <input type="number" class="view_student_grade_points" data-student="<%=student_ID %>" value="<%=real_grade_points %>" readonly>
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-primary">Change</button>
                                                    </td>
                                                </tr>
                                                <% } %>
                                            </table>
                                            <% } %>
                                        </td>
                                    </tr>
                                    <% } %>
                                </table>
                            </div>
                        <% } %>
                        </div>
                    <% } %>
                    
                
            </div>
            
            <!--exam marks-->
            <div class="card-body tab-pane container fade" id="exam_marks">
                <div class="card-header">
                    <h1>Exam Marks</h1>
                    <% ResultSet my_exam_grades[] = null;
                       my_exam_grades = teacher.getMySubjectGrades();
                       while (my_exam_grades[0].next()) {
                           int grade = my_exam_grades[0].getInt("grade");
                    %>
                    <div class="form-control">
                        <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#my_exam_grade_<%=grade %>"><b>Grade <%=grade %></b></button>
                    </div>
                        <div class="form-control collapse bg-dark" id="my_exam_grade_<%=grade %>">
                            <h2 class="bg-light">Classes</h2>
                            <% ResultSet my_classes = teacher.getMyClasses(grade);
                                while (my_classes.next()) {
                                    String Class = my_classes.getString("class");
                            %>
                            <div class="form-control">
                                <button type="button" class="btn btn-link" style="color: red" data-toggle="collapse" data-target="#my_exam_classes_<%=grade %>_<%=Class %>"><%=grade %>-<%=Class %></button>
                            </div>
                                <div class="form-control collapse" id="my_exam_classes_<%=grade %>_<%=Class %>">
                                    <h3>Exams</h3>
                                    <% ResultSet[] view_exams = null;
                                        view_exams = Exam.getAnyExam(grade, Class);
                                        while (view_exams[0].next()) {
                                            String exam_ID = view_exams[0].getString("exam_ID");
                                            String exam_name = view_exams[0].getString("exam_name");
                                    %>
                                    <div class="form-control">
                                        <button type="button" class="btn btn-link" style="color: violet" data-toggle="collapse" data-target="#my_exams_<%=grade %>_<%=exam_ID %>_<%=Class %>"><b><%=exam_name %></b></button>
                                    </div>
                                        <div class="form-control collapse bg-primary" id="my_exams_<%=grade %>_<%=exam_ID %>_<%=Class %>">
                                            <table class="table table-striped bg-light" style="color: black">
                                                <tr>
                                                    <th>Subject Code</th>
                                                    <th>Subject Name</th>
                                                </tr>
                                                <% ResultSet[] teacher_exam_subjects = null;
                                                   teacher_exam_subjects = Exam.getExamSubjectsForTeacher(exam_ID, teacher_ID, grade);
                                                   
                                                   while (teacher_exam_subjects[0].next()) {
                                                       String sub_code = teacher_exam_subjects[0].getString("sub_code");
                                                       String sub_name = teacher_exam_subjects[0].getString("sub_name");
                                                       double credits = teacher_exam_subjects[0].getDouble("credits");
                                                %>
                                                <tr>
                                                    <td><%=sub_code %></td>
                                                    <td><%=sub_name %></td>
                                                    <td><button type="button" class="btn btn-success" data-toggle="collapse" data-target="#my_exams_<%=grade %>_<%=exam_ID %>_<%=Class %>_<%=sub_code %>">Enter Student Marks</button></td>
                                                </tr>
                                                 
                                                <tr class="collapse" style="background-color: black; color: white" id="my_exams_<%=grade %>_<%=exam_ID %>_<%=Class %>_<%=sub_code %>">
                                                    <td colspan="4">
                                                        <table class="table table-hover bg-warning">
                                                            <tr>
                                                                <th>Student ID</th>
                                                                <th>Student Name</th>
                                                                <th>Marks</th>
                                                            </tr>
                                                            <% ResultSet enter_student_marks = Student.getSubjectStudentsForClass(grade, Class, sub_code, exam_ID);
                                                                while (enter_student_marks.next()) {
                                                                    String student_ID = enter_student_marks.getString("student_ID");
                                                                    String fname = enter_student_marks.getString("fname");
                                                                    String lname = enter_student_marks.getString("lname");
                                                            %>
                                                            <tr>
                                                                <td><%=student_ID %></td>
                                                                <td><%=fname %> <%=lname %></td>
                                                                <td><input type="number" class="student_marks" max="100" min="0" name="st_mark" data-id="<%=student_ID %>" data-grade="<%=grade %>" data-subject="<%=sub_code %>" data-student="<%=student_ID %>_<%=sub_code %>" data-exam="<%=exam_ID %>" data-credits="<%=credits %>"></td>
                                                                <td><input type="text" class="student_grade_points" name="grade_points" data-id="<%=student_ID %>" data-student="<%=student_ID %>_<%=sub_code %>"></td>
                                                                <td><button type="button" class="btn btn-primary">Confirm</button></td>
                                                            </tr>
                                                            <% } %>
                                                        </table>
                                                    </td>                                                   
                                                </tr>
                                                <% } %>                    
                                            </table>
                                        </div>
                                    <% } %>
                                </div>
                            <% } %>
                        </div>
                    <% } %>
                    <% while (my_exam_grades[1].next()) {
                        int grade = my_exam_grades[1].getInt("grade");
                    %>
                    <div class="form-control">
                        <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#my_exam_al_grade_<%=grade %>"><b>Grade <%=grade %></b></button>
                    </div>
                        <div class="form-control collapse bg-dark" id="my_exam_al_grade_<%=grade %>">
                            <h2 class="bg-light">Classes</h2>
                            <% ResultSet my_classes = teacher.getMyClasses(grade);
                                while (my_classes.next()) {
                                    String Class = my_classes.getString("class");
                            %>
                            <div class="form-control">
                                <button type="button" class="btn btn-link" style="color: red" data-toggle="collapse" data-target="#my_exam_classes_<%=grade %>_<%=Class %>"><%=grade %>-<%=Class %></button>
                            </div>
                                <div class="form-control collapse" id="my_exam_classes_<%=grade %>_<%=Class %>">
                                    <h3>Exams</h3>
                                    <% ResultSet[] view_exams = null;
                                        view_exams = Exam.getAnyExam(grade, Class);
                                        while (view_exams[1].next()) {
                                            String exam_ID = view_exams[1].getString("exam_ID");
                                            String exam_name = view_exams[1].getString("exam_name");
                                    %>
                                    <div class="form-control">
                                        <button type="button" class="btn btn-link" style="color: violet" data-toggle="collapse" data-target="#al_exams_<%=grade %>_<%=exam_ID %>_<%=Class %>"><b><%=exam_name %></b></button>
                                    </div>
                                        <div class="form-control collapse bg-primary" id="al_exams_<%=grade %>_<%=exam_ID %>_<%=Class %>">
                                            <table class="table table-striped bg-light" style="color: black">
                                                <tr>
                                                    <th>Subject Code</th>
                                                    <th>Subject Name</th>
                                                </tr>
                                                <% ResultSet[] teacher_exam_subjects = null;
                                                   teacher_exam_subjects = Exam.getExamSubjectsForTeacher(exam_ID, teacher_ID, grade);
                                                   
                                                   while (teacher_exam_subjects[1].next()) {
                                                       String sub_code = teacher_exam_subjects[1].getString("sub_code");
                                                       String sub_name = teacher_exam_subjects[1].getString("sub_name");
                                                       double credits = teacher_exam_subjects[1].getDouble("credits");
                                                %>
                                                <tr>
                                                    <td><%=sub_code %></td>
                                                    <td><%=sub_name %></td>
                                                    <td><button type="button" class="btn btn-success" data-toggle="collapse" data-target="#al_exams_<%=grade %>_<%=exam_ID %>_<%=Class %>_<%=sub_code %>">Enter Student Marks</button></td>
                                                </tr>
                                                
                                                <tr class="collapse" style="background-color: black; color: white"  id="al_exams_<%=grade %>_<%=exam_ID %>_<%=Class %>_<%=sub_code %>">      
                                                    <td colspan="4">
                                                        <table class="table table-hover bg-warning">
                                                            <tr>
                                                                <th>Student ID</th>
                                                                <th>Student Name</th>
                                                                <th>Marks</th>
                                                                <th>Grade Points</th>
                                                            </tr>
                                                            <% ResultSet enter_student_marks = Student.getSubjectStudentsForClass(grade, Class, sub_code, exam_ID);
                                                                while (enter_student_marks.next()) {
                                                                    String student_ID = enter_student_marks.getString("student_ID");
                                                                    String fname = enter_student_marks.getString("fname");
                                                                    String lname = enter_student_marks.getString("lname");
                                                            %>
                                                            <tr>
                                                                <td><%=student_ID %></td>
                                                                <td><%=fname %> <%=lname %></td>
                                                                <td><input type="number" max="100" min="0" class="student_marks" name="st_mark" data-id="<%=student_ID %>" data-grade="<%=grade %>" data-subject="<%=sub_code %>" data-student="<%=student_ID %>_<%=sub_code %>" data-exam="<%=exam_ID %>" data-credits="<%=credits %>"></td>
                                                                <td><input type="text" name="grade_points" class="student_grade_points" data-student="<%=student_ID %>_<%=sub_code %>"></td>
                                                                <td><button type="button" class="btn btn-primary">Confirm</button></td>
                                                            </tr>
                                                            <% } %>
                                                        </table>
                                                    </td>  
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
            
            <% } catch (Exception ex) { %>
                <p style="color: red"><%=ex.getMessage() %></p>
            <% } %>
        </div>
        
        <div class="div_grade_points">
            <% ResultSet view_grade_points = Exam.viewGradePoints();
                while (view_grade_points.next()) {
                    String grade = view_grade_points.getString("Grade");
                    int lower = view_grade_points.getInt("lower_mark");
                    int upper = view_grade_points.getInt("upper_mark");
                    double points = view_grade_points.getDouble("Points");
            %>
            <input type="hidden" class="view_grade_points" data-grade="<%=grade %>" data-lower="<%=lower %>" data-upper="<%=upper %>" data-points="<%=points %>">
            <% } %>
        </div>
    </body>
</html>
