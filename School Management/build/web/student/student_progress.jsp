<%-- 
    Document   : student_progress
    Created on : Nov 5, 2018, 9:46:06 PM
    Author     : DELL
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.*, student.*, subjects.*, grades.*, exam.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Progress</title>
        <%@include file="../layouts/Navigation.jsp" %>
        <%@include file="../layouts/Scripts.jsp" %>
        <%@include file="../layouts/Styles.jsp" %>
        
    </head>
    <body class="w3-main">
        <%@include file="../layouts/student_profile_navigation.jsp" %>
        <script>
            $(document).ready(function() {
               $(".class_grade").each(function() {
                   var class_grade = $(this).attr("data-class");
                   
                   if (class_grade === "A") {
                       $(this).parent().css({background : "green", color : "white"});
                   }
                   else if (class_grade === "F") {
                       $(this).parent().css({background : "red", color : "white"});
                   }
               }); 
               
               $(".ranking").each(function() {
                  var rank = $(this).attr("data-rank");
                  
                  if (rank === "1") {
                      $(this).parent().css({background : "green", color : "white"});
                  }
               });
            });
        </script>
        <%  try {    
                Student student = (Student) session.getAttribute("student");
                String student_ID = student.getStudentID();
                int grade = student.getGrade();
                String Class = student.getClasses();
                DecimalFormat formatter = new DecimalFormat("#0.0");
        %>
        <div class="container" style="margin-top: 20px">
            <div class="card">
                <ul class="nav nav-tabs justify-content-around">
                    <li class="nav-item">
                        <a href="#my_subjects" class="nav-link" data-toggle="tab">My Subjects</a>
                    </li>
                    <li class="nav-item">
                        <a href="#my_subject_marks" class="nav-link" data-toggle="tab">Subject Marks</a>
                    </li>
                </ul>
            </div>
            
            <div class="tab-content">
                <div class="card-body bg-primary tab-pane container active" id="my_subjects">
                    <div class="card-header bg-light">
                        <% if (grade >= 1 && grade < 12) { %>
                            <span style="font-size: 40px">My Subjects - Grade <%=grade %></span>
                        <% } else if (grade >= 12 && grade <= 13) {
                                String section_name = Grades.getSectionName(Class);
                        %>
                            <span style="font-size: 40px">My Subjects - Grade <%=grade %>(<%=section_name %>)</span>
                        <% } %>
                    </div>
                    <table class="table table-striped bg-light">
                        <tr>
                            <th>Subject Code</th>
                            <th>Subject Name</th>
                        </tr>
                        <% ResultSet my_subjects = null;
                           ResultSet bucket_subjects = null;
                            
                           if (grade >= 1 && grade < 12) {
                               my_subjects = Subject.getMySubjects(student_ID);
                           }
                           else if (grade >= 12 && grade <= 13) {
                               my_subjects = Subject.getMyALSubjects(student_ID);
                           }
               
                            while (my_subjects.next()) {
                                String sub_code = my_subjects.getString("sub_code");
                                String sub_name = my_subjects.getString("sub_name");
                        %>
                        <tr>
                            <td><%=sub_code %></td>
                            <td><%=sub_name %></td>
                        </tr>
                        <% } %>
                    </table>
                    <div class="form-group bg-light">
                        <h1>Bucket Subjects</h1>
                        <% if (Subject.isBucketStudent(student)) { %>
                            <p style="color: red">There are no more bucket subjects to be chosen</p>
                        <% } else { %>
                            <p style="color: red">Please select your bucket subject(s)</p>
                            <form action="<%=request.getContextPath() %>/BucketSubjectSelectionServlet" method="POST">
                                <% if (grade >= 1 && grade < 12) {
                                       bucket_subjects = Subject.getBucketSubjects(grade);
                                   }
                                   else if (grade >= 12 && grade <= 13) {
                                       bucket_subjects = Subject.getALBucketSubjects(grade,Class);
                                   }


                                    while (bucket_subjects.next()) {
                                        String sub_code = bucket_subjects.getString("sub_code");
                                        String sub_name = bucket_subjects.getString("sub_name");
                                %>
                                <div class="form-check-inline">
                                    <label class="form-check-label">
                                        <% if (grade >= 1 && grade < 10) { %>
                                            <input type="radio" class="form-check-input" name="bucket_subjects" value="<%=sub_code %>" required>
                                            <%=sub_name %>
                                        <% } else if (grade >= 10 && grade <= 13) { %>
                                            <input type="checkbox" class="form-check-input" name="bucket_subjects" value="<%=sub_code %>">
                                            <%=sub_name %>
                                        <% } %>
                                    </label>
                                </div>   
                                <% } %>
                                <div class="form-group" style="margin-top: 20px">
                                    <button type="submit" class="btn btn-success">Submit</button>
                                </div> 
                            </form>
                        <% } %>
                    </div>
                </div>
                
                <div class="card-body tab-pane container fade" id="my_subject_marks">
                    <div class="card-header">
                        <h1>My Subject Marks</h1>
                        <% ResultSet my_exams = Exam.getAllExamsForGrade(grade, Class); 
                            while (my_exams.next()) {
                                String exam_ID = my_exams.getString("exam_ID");
                                String exam_name = my_exams.getString("exam_name");
                        %>
                        <div class="form-control bg-primary">
                            <button type="button" class="btn btn-link" style="color: white" data-toggle="collapse" data-target="#my_exam_<%=exam_ID %>">Grade <%=grade %> - <%=exam_name %></button>
                        </div>
                            <div class="form-control collapse" id="my_exam_<%=exam_ID %>">
                                <h2>Subject Marks</h2>
                                <table class="table table-hover bg-dark" style="color: white">
                                    <tr>
                                        <th>Subject ID</th>
                                        <th>Subject Name</th>
                                        <th>Marks</th>
                                        <th>Grade Points</th>
                                    </tr>
                                    <% ResultSet my_marks = Student.getMyExamMarks(grade, exam_ID, student_ID);
                                        while (my_marks.next()) {
                                            String sub_code = my_marks.getString("sub_code");
                                            String sub_name = my_marks.getString("sub_name");
                                            double marks = my_marks.getDouble("marks");
                                            double grade_points = my_marks.getDouble("grade_points");
                                            double real_grade_points = Double.parseDouble(formatter.format(grade_points));
                                            
                                           
                                    %>
                                    <tr>
                                        <td><%=sub_code %></td>
                                        <td><%=sub_name %></td>
                                        <td><%=marks %></td>
                                        <td><%=real_grade_points %></td>
                                    </tr>
                                    <% } %>
                                    <% ResultSet my_exam_stats = Exam.getMyExamStatistics(student_ID, exam_ID, grade);
                                        while (my_exam_stats.next()) {
                                            int total = my_exam_stats.getInt("total");
                                            double average = my_exam_stats.getDouble("average");
                                            double gpa = my_exam_stats.getDouble("gpa");
                                            int rank = my_exam_stats.getInt("rank");
                                            String class_grade = my_exam_stats.getString("class");
                                    %>
                                        <tr>
                                            <td colspan="2"><b>Total</b></td>
                                            <td><b><%=total %></b></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"><b>Average</b></td>
                                            <td><b><%=average %></b></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"><b>GPA</b></td>
                                            <td><b><%=gpa %></b></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"><b>Rank</b></td>
                                            <td class="ranking" data-rank="<%=rank %>"><b><%=rank %></b></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"><b>Class</b></td>
                                            <td class="class_grade" data-class="<%=class_grade %>"><b><%=class_grade %></b></td>
                                        </tr>
                                    <% } %>
                                </table>
                            </div>
                        <% } %>
                    </div>
                </div>
                
            </div>
        </div>
    </body>
    <% } catch(Exception ex) { 
            out.println(ex.getMessage());
       }
    %>
</html>
