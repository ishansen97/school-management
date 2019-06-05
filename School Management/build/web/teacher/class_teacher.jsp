<%-- 
    Document   : class_teacher
    Created on : Dec 20, 2018, 3:16:24 PM
    Author     : DELL
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.*, exam.*, teacher.*, subjects.*, grades.*, classes.*, student.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Class</title>
        <%@include file="../layouts/Navigation.jsp" %>
        <%@include file="../layouts/Scripts.jsp" %>
        <%@include file="../layouts/Styles.jsp" %>
    </head>
    <body class="w3-main">
        <script>
            $(document).ready(function() {
                var marks = [];
               $(".average").each(function() {
                   marks[marks.length] = $(this).attr("data-value");
               }); 
//               alert(marks);
               var i,j,k;
               for (i = 1; i < marks.length; i++) {
                   var key = marks[i];
                   j = i - 1;
                   while (j > -1 && marks[j] > key) {
                       marks[j+1] = marks[j];
                       j = j - 1;
                   }
                   marks[j+1] = key;
               }
//               alert("after sorting : " + marks);
               
               for (k = 0; k < marks.length; k++) {
                   $(".average").each(function() {
                      var average = $(this).attr("data-value");
                      
                      if (marks[k] === average) {
                          var ranking = marks.length - k;
                          $(this).parent().parent().find(".ranking").html(ranking);
                          $(this).parent().parent().find(".ranking").attr("data-rank",ranking);
                          
                          if (ranking === 1) {
                            $(this).parent().parent().find(".ranking").parent().css({background : "green"});
                          }
                          else if (ranking === marks.length) {
                            $(this).parent().parent().find(".ranking").parent().css({background : "red"});  
                          }
                      }
                   });
               }
               
               $(".btn-success").click(function() {
                   var response = confirm("Are you sure?");
                   
                   if (response === true) {
                        $(".total").each(function() {
                           var total = $(this).attr("data-total");
                           var grade = $(this).attr("data-grade");
                           var exam = $(this).attr("data-exam");
                           var student = $(this).attr("data-student");
                           var average = $(this).parent().parent().find(".average").attr("data-value");
                           var gpa = $(this).parent().parent().find(".gpa").attr("data-gpa");
                           var class_grade = $(this).parent().parent().find(".class_grade").attr("data-grade");
                           var rank = $(this).parent().parent().find(".ranking").attr("data-rank");

     //                      alert("total : " +total+ "\naverage : " +average+ "\ngpa : " +gpa+ "\nclass grade : " +class_grade+ "\nrank : " +rank+ "\ngrade : " +grade);

                           $.post("<%=request.getContextPath() %>/ExamRecordSubmissionServlet", {student : student, exam : exam, total : total, grade : grade, average : average, gpa : gpa, class_grade : class_grade, rank : rank}, function(data) {
                               alert(data);
                           });
                        });
                   }
               });
               
            });
        </script>
        <% try {
            Teacher teacher = (Teacher) session.getAttribute("teacher");
            String teacher_ID = teacher.getTeacher_ID();
            String type = teacher.ClassTeacherType();
            int grade = 0;
            String Class = null;
            DecimalFormat formatter = new DecimalFormat("#0.0");
        %>
            <%@include file="../layouts/teacher_profile_navigation.jsp" %>
            <div class="container" style="margin-top: 20px">
                <ul class="nav nav-tabs justify-content-around">
                    <li class="nav-item">
                        <a href="#my_class" class="nav-link" data-toggle="tab">My Class</a>
                    </li>
                    <li class="nav-item">
                        <a href="#class_exam_marks" class="nav-link" data-toggle="tab">Class Exam Marks</a>
                    </li>
                </ul>
            </div>

            <!--tab content-->
            <div class="tab-content">

                <!--My Class-->
                <div class="card-body tab-pane container active" id="my_class">
                    <div class="card-header">
                        <h1>Class Overview</h1>
                    </div>
                    <div class="form-control">
                        <% ResultSet my_class = teacher.getMyClass();
                            while (my_class.next()) {
                                grade = my_class.getInt("grade");
                                Class = my_class.getString("class");
                        %>
                        <p><b>Class :  <%=grade %>-<%=Class %></b></p>
                        <% } %>
                        <p><b>Name :  <%=teacher.getFirstName() %> <%=teacher.getLastName() %></b></p>
                        <% int student_count = teacher.ClassStudentCount(grade, Class); %>
                        <p><b>No Of Students :  <%=student_count %></b></p>
                        <table class="table table-hover">
                            <tr class="bg-primary">
                                <th>Student ID</th>
                                <th>Student Name</th>
                            </tr>
                            <% ResultSet class_students = Student.getClassStudents(grade, Class, type);
                                while (class_students.next()) {
                                    String student_ID = class_students.getString("student_ID");
                                    String fname = class_students.getString("fname");
                                    String lname = class_students.getString("lname");
                            %>
                            <tr>
                                <td><%=student_ID %></td>
                                <td><%=fname %> <%=lname %></td>
                            </tr>
                            <% } %>
                        </table>
                    </div>
                </div>

                <!--Class Exam Marks-->
                <div class="card-body tab-pane container fade" id="class_exam_marks">
                    <div class="card-header">
                        <h1>Class Exam Marks</h1>
                    </div>
                    <div class="form-control">
                        <h2>Exams</h2>
                        <% ResultSet exams = Exam.getClassExamsForGrade(grade, Class, type);
                            while (exams.next()) {
                                String exam_ID = exams.getString("exam_ID");
                                String exam_name = exams.getString("exam_name");
                        %>
                        <div class="form-control bg-primary">
                            <button type="button" class="btn btn-link" style="color: white" data-toggle="collapse" data-target="#<%=exam_ID %>"><b><%=exam_name %></b></button>
                        </div>
                            <div class="form-control collapse" id="<%=exam_ID %>">
                                <h3>Students</h3>
                                <table class="table table-striped">
                                    <tr class="bg-warning" style="color: black">
                                        <th>Student ID</th>
                                        <th>Student Name</th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                <% ResultSet class_exam_students = Student.getClassStudents(grade, Class, type);
                                    while (class_exam_students.next()) {
                                        String student_ID = class_exam_students.getString("student_ID");
                                        String fname = class_exam_students.getString("fname");
                                        String lname = class_exam_students.getString("lname");
                                        int total = 0;
                                        double subject_count = 0;
                                        double total_credits = 0;
                                        double total_grade_points = 0;
                                %>
                                <tr>
                                    <td><%=student_ID %></td>
                                    <td><%=fname %> <%=lname %></td>
                                    <td><button type="button" class="btn btn-primary" data-toggle="collapse" data-target="#student_marks_<%=student_ID %>">View Student Marks</button></td>
                                </tr>
                                <tr class="collapse" id="student_marks_<%=student_ID %>">
                                    <td colspan="4">
                                        <table class="table table-striped bg-dark" style="color: white">
                                            <tr>
                                                <th>Subject Code</th>
                                                <th>Subject Name</th>
                                                <th>Marks</th>
                                                <th>Grade</th>
                                                <th>Grade Points</th>
                                            </tr>
                                            <% ResultSet student_marks = Exam.getStudentExamSubjects(exam_ID, student_ID, type);
                                                while (student_marks.next()) {
                                                    String sub_code = student_marks.getString("sub_code");
                                                    String sub_name = student_marks.getString("sub_name");
                                                    int marks = student_marks.getInt("marks");
                                                    double grade_points = student_marks.getDouble("grade_points");
                                                    double credits = student_marks.getDouble("credits");
                                                    String mark_grade = Exam.getGrade(marks);
                                                    
                                                    total = total + marks;
                                                    total_credits = total_credits + credits;
                                                    total_grade_points = total_grade_points + grade_points;
                                                    subject_count++;
                                            %>
                                            <tr>
                                                <td><%=sub_code %></td>
                                                <td><%=sub_name %></td>
                                                <td><%=marks %></td>
                                                <td><%=mark_grade %></td>
                                                <td><%=formatter.format(grade_points) %></td>
                                            </tr>
                                            <% } %>
                                            <% double average = total / subject_count;
                                               double real_average = Double.parseDouble(formatter.format(average));
                                               double gpa = total_grade_points / total_credits;
                                               double real_gpa = Double.parseDouble(formatter.format(gpa));
                                               String class_grade = Exam.getGrade(real_gpa);
                                            %>
                                            <tr>
                                                <td colspan="2"><b>Total</b></td>
                                                <td class="total" data-total="<%=total %>" data-grade="<%=grade %>" data-exam="<%=exam_ID %>" data-student="<%=student_ID %>"><b><%=total %></b></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2"><b>Average</b></td>
                                                <td class="average" data-value="<%=real_average %>"><b><%=real_average %></b></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2"><b>GPA</b></td>
                                                <td class="gpa" data-gpa="<%=real_gpa %>"><b><%=real_gpa %></b></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2"><b>Class</b></td>
                                                <td class="class_grade" data-grade="<%=class_grade %>"><b><%=class_grade %></b></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2"><b>Ranking</b></td>
                                                <td class="ranking" data-rank=""></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <% } %>
                                </table>
                            </div>
                                <div class="form-control">
                                    <button type="button" class="btn btn-success">Submit Student rankings</button>
                                </div>    
                        <% } %>
                    </div>
                </div>
            </div>
        <% } catch (Exception ex) { %>
<!--//                response.sendRedirect("../Registration/login.jsp");-->
<p><%=ex.getMessage() %></p>
   
        <% } %>
    </body>
</html>
