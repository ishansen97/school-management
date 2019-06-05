<%-- 
    Document   : class_management
    Created on : Dec 14, 2018, 11:28:51 AM
    Author     : DELL
--%>

<%@page import="grades.*, java.sql.*, classes.*, subjects.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Class Management</title>
        
        <%@include file="../layouts/Navigation.jsp" %>
        <%@include file="../layouts/Scripts.jsp" %>
        <%@include file="../layouts/Styles.jsp" %>
    </head>
    <body class="w3-main">
        <%@include file="../layouts/admin_navigation.jsp" %>
        
        <div class="container" style="margin-top: 20px">
            <ul class="nav nav-tabs justify-content-around">
                <li class="nav-item">
                    <a href="#add_class" class="nav-link" data-toggle="tab">Add Classes</a>
                </li>
                <li class="nav-item">
                    <a href="#class_subject_distribution" class="nav-link" data-toggle="tab">Class-Subject Distribution</a>
                </li>
            </ul>
            
        </div>
        
        <!--tab content-->
        <div class="tab-content">
            <!--add classes-->
            <div class="card-body tab-pane container active" id="add_class">
                
            </div>
            
            <!--subject distribution-->
            <div class="card-body tab-pane container fade" id="class_subject_distribution">
                <div class="card-header">
                    <ul class="nav nav-tabs justify-content-around">
                        <li class="nav-item">
                            <a href="#regular_class_subject_distribution" class="nav-link" data-toggle="tab">Regular</a>
                        </li>
                        <li class="nav-item">
                            <a href="#al_class_subject_distribution" class="nav-link" data-toggle="tab">A/L</a>
                        </li>
                    </ul>
                </div>
                
                <!--class-subject tab content-->
                <div class="tab-content">
                    
                    <!--regular class-subject distributions-->
                    <div class="card-body tab-pane container active" id="regular_class_subject_distribution">
                        <div class="card-header">
                            <h1>Regular Class-Subject Distribution</h1>
                        </div>
                        <% ResultSet grades = Grades.viewGrades(); 
                            while (grades.next()) {
                                int grade = grades.getInt("Grade");
                        %>
                        <div class="form-group">
                            <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#regular_grade_<%=grade %>">Grade <%=grade %></button>
                        </div>
                        <div class="form-control collapse" id="regular_grade_<%=grade %>">
                            <h1 style="color: blue">Classes in Grade <%=grade %></h1>
                            <% ResultSet grade_classes = Grades.getClasses(grade);
                                while (grade_classes.next()) {
                                    String Class = grade_classes.getString("class");
                            %>
                            <div class="row bg-white" style="height: 80px; border: 1px solid blue">
                                <div class="col-2">
                                    <button type="button" class="btn btn-link" style="color: red" data-toggle="collapse" data-target="#grade_class_<%=grade %>_<%=Class %>"><%=grade %>-<%=Class %></button>
                                </div>
                                <div class="col-6">
                                </div>
                                <div class="col-4">
                                    <% int total_subjects = Class_Management.getNoOfTotalSubjects(grade, Class);
                                       int allocated_subjects = Class_Management.getNoOfAllocatedSubjects(grade, Class);
                                       int non_allocated_subjects = total_subjects - allocated_subjects;
                                    %>
                                    <span>Allocated No Of Subjects : <%=total_subjects %></span><br>
                                    <span style="color: blue">Appointed No Of Teachers : <%=allocated_subjects %></span><br>
                                    <span style="color: red">No Of Teachers needed to be appointed: <%=non_allocated_subjects %></span>
                                </div>
                            </div>
                                <div class="form-control collapse" id="grade_class_<%=grade %>_<%=Class %>">
                                    <table class="table table-striped">
                                        <tr>
                                            <th>Subject Code</th>
                                            <th>Subject Name</th>
                                            <th>Teacher Name</th>
                                        </tr>
                                        <% ResultSet class_subject_distribution = Class_Management.getClassSubjectAllocation(grade, Class); 
                                            while (class_subject_distribution.next()) {
                                                String sub_code = class_subject_distribution.getString("sub_code");
                                                String sub_name = class_subject_distribution.getString("sub_name");
                                        %>
                                        <tr>
                                            <td><%=sub_code %></td>
                                            <td><%=sub_name %></td>
                                            <% ResultSet class_subject_teacher = null; %>
                                            <% try { 
                                                class_subject_teacher = Class_Management.getClassSubjectTeacher(grade, Class, sub_code);
                                                if (class_subject_teacher != null) {
                                                    while (class_subject_teacher.next()) {
                                                        String teacher_ID = class_subject_teacher.getString("teacher_ID");
                                                        String fname = class_subject_teacher.getString("fname");
                                                        String lname = class_subject_teacher.getString("lname");
                                            %>
                                            <td><%=fname %> <%=lname %></td>
                                                    <% } %>
                                                <% } %>
                                            <% } catch (Exception ex) { %>
                                            <td><%=ex.getMessage() %></td>
                                            <% } %>
                                        </tr>
                                        <% } %>
                                    </table>
                                </div>
                            <% } %>
                        </div>
                        <% } %>
                        
                    </div>
                    
                    <!--a/l class-subject distributions-->
                    <div class="card-body tab-pane container fade" id="al_class_subject_distribution">
                        <div class="card-header">
                            <h1>A/L Class-Subject Distribution</h1>
                        </div>
                        <% ResultSet al_grades = Grades.viewALGrades(); 
                            while (al_grades.next()) {
                                int al_grade = al_grades.getInt("Grade");
                        %>
                        <div class="form-group">
                            <button type="button" class="btn btn-link" data-toggle="collapse" data-target="#al_grade_<%=al_grade %>"><b>Grade <%=al_grade %></b></button>
                        </div>
                            <div class="form-control collapse" id="al_grade_<%=al_grade %>">
                                <h1>Sections</h1>
                                <% ResultSet al_sections = Grades.getALSection(al_grade);
                                    while (al_sections.next()) {
                                        String section_ID = al_sections.getString("section_ID");
                                        String section_name = al_sections.getString("section_name");
                                %>
                                <div class="form-group">
                                    <button type="button" class="btn btn-link" style="color: red" data-toggle="collapse" data-target="#al_section_<%=al_grade %>_<%=section_ID %>"><b><%=section_name %></b></button>
                                </div>
                                    <div class="form-control collapse" id="al_section_<%=al_grade %>_<%=section_ID %>">
                                        <h2>Classes</h2>
                                        <% ResultSet al_classes = Grades.getSectionClasses(section_ID);
                                            while (al_classes.next()) {
                                                String al_class = al_classes.getString("class");
                                        %>
                                        <div class="row bg-white" style="height: 80px; border: 1px solid blue">
                                            <div class="col-2">
                                                <button type="button" class="btn btn-link" style="color: violet" data-toggle="collapse" data-target="#al_class_<%=al_grade %>_<%=al_class %>"><b><%=al_grade %>-<%=al_class %></b></button>
                                            </div>
                                            <div class="col-6"></div>
                                            <div class="col-4">
                                                <% int al_total_subjects = Class_Management.getNoOfTotalALSubjects(al_grade, section_ID);
                                                   int allocated_subjects = Class_Management.getNoOfAllocatedALSubjects(al_grade, al_class, section_ID);
                                                   int remaining_subjects = al_total_subjects - allocated_subjects;
                                                %>
                                                <span>Total No Of Subjects : <%=al_total_subjects %></span><br>
                                                <span style="color: blue">No Of Teachers Allocated : <%=allocated_subjects %></span><br>
                                                <span style="color: red">No Of Teachers needed to be allocated : <%=remaining_subjects %></span><br>
                                                                                                    
                                            </div>
                                        </div>
                                            <div class="form-control collapse" id="al_class_<%=al_grade %>_<%=al_class %>">
                                                <table class="table table-striped">
                                                    <tr>
                                                        <th>Subject Code</th>
                                                        <th>Subject Name</th>
                                                        <th>Teacher Name</th>
                                                    </tr>
                                                    <% ResultSet al_section_subjects = Subject.getSectionSubjects(al_grade, section_ID);
                                                        while (al_section_subjects.next()) {
                                                            String sub_code = al_section_subjects.getString("sub_code");
                                                            String sub_name = al_section_subjects.getString("sub_name");
                                                    %>
                                                    <tr>
                                                        <td><%=sub_code %></td>
                                                        <td><%=sub_name %></td>
                                                        <% try {
                                                            ResultSet subject_teacher = null;
                                                            subject_teacher = Class_Management.getALClassSubjectTeacher(al_grade, al_class, sub_code);
                                                            
                                                            if (subject_teacher != null) {
                                                                while (subject_teacher.next()) {
                                                                    String teacher_ID = subject_teacher.getString("teacher_ID");
                                                                    String fname = subject_teacher.getString("fname");
                                                                    String lname = subject_teacher.getString("lname");
                                                        %>
                                                        <td><%=fname %> <%=lname %></td>
                                                                <% } %>
                                                            <% } else { %>
                                                        <td>N/A</td>    
                                                            <% } %>
                                                        <% } catch (Exception ex) { %>
                                                        <td><%=ex.getMessage() %></td>    
                                                        <% } %>
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
        </div>
    </body>
</html>
