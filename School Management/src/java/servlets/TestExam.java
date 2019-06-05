/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;
import java.sql.*;
import dbconnection.DBConnection;
import exam.Exam;
import subjects.Subject;
import student.Student;
import grades.Grades;
import classes.Class_Management;
import java.text.DecimalFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class TestExam {
    
    public static void main(String[] args) {
        int count = 0;
        int insertedRecords = 0;
        String query = null;
        DecimalFormat formatter = new DecimalFormat("#0.0");
        DBConnection dbconnect = DBConnection.getInstance();
        Connection con = dbconnect.getCon();
        try {
            //get the grades
            ResultSet grades = Grades.viewALGrades();
            while (grades.next()) {
                int grade = grades.getInt("Grade");
//                System.out.println("Grade : " + grade);
                ResultSet grade_sections = Grades.getALSection(grade);
                
                //get the sections for each grade
                while (grade_sections.next()) {
                    String section_ID = grade_sections.getString("section_ID");
                    String section_name = grade_sections.getString("section_name");
                    
                    System.out.println("\tSection : " + grade + "-" + section_name);
                    
                    ResultSet al_classes = Grades.getSectionClasses(section_ID);
                    while (al_classes.next()) {
                        String classes = al_classes.getString("class");
                        System.out.println("\t\tClass : " +grade+ " - " + classes);
                        
                        //get the exams available for each grade
                        ResultSet exams = Exam.getSemesterALExamForGrade(grade, 1, section_ID);
                        while (exams.next()) {
                            String exam_ID = exams.getString("exam_ID");
                            String exam_name = exams.getString("exam_name");

                            System.out.println("\t\tExam : " + exam_name);

                            //get the subjects available for each exam
                            ResultSet subjects = Exam.getALExamSubjects(exam_ID);
                            while (subjects.next()) {
                                String sub_code = subjects.getString("sub_code");
                                String sub_name = subjects.getString("sub_name");
                                double credits = 0;

                                credits = Subject.getALCredits(sub_code);

                                System.out.println("\t\t\tSubject : " + sub_name);

                                //get the students for each subject
                                ResultSet students = Student.getSubjectStudentsForClass(grade, classes, sub_code, exam_ID);
                                while (students.next()) {
                                    count++;
                                    String student_ID = students.getString("student_ID");
                                    String fname = students.getString("fname");
                                    String lname = students.getString("lname");
                                    int number = (int)(Math.random() * 100);
                                    double grade_points = 0;
                                    double real_grade_points = 0;

                                    System.out.print("\t\t\t\tStudent ID : " + student_ID);
                                    System.out.print("\tName : " + fname + " " + lname);
                                    System.out.print("\tMarks : " + number);

                                    ResultSet view_grade_points = Exam.viewGradePoints();
                                    while (view_grade_points.next()) {
                                        String view_grade = view_grade_points.getString("Grade");
                                        int lower = view_grade_points.getInt("lower_mark");
                                        int upper = view_grade_points.getInt("upper_mark");
                                        double points = view_grade_points.getDouble("Points");
                                        
                                        if (number >= lower && number <= upper) {
                                            grade_points = credits * points;
                                            real_grade_points = Double.parseDouble(formatter.format(grade_points));
                                        }
                                    }
                                    System.out.println("\tGrade Points : " + real_grade_points);

//                                    query = "INSERT INTO al_subject_exam_student(exam_ID,subject_ID,student_ID,marks,grade_points) VALUES(?,?,?,?,?)";
//                                    PreparedStatement pst = con.prepareStatement(query);
//                                    pst.setString(1,exam_ID);
//                                    pst.setString(2, sub_code);
//                                    pst.setString(3, student_ID);
//                                    pst.setDouble(4, number);
//                                    pst.setDouble(5, grade_points);
//                                    
//                                    int result = pst.executeUpdate();
//                                    
//                                    if (result > 0)
//                                        insertedRecords++;

                                }
                            }
                        }
                    }
                }
            }
            System.out.println("Records : " + count);
            System.out.println("Inserted Records : " + insertedRecords);
            
//        int validNumbers = 0;
//        int invalidNumbers = 0;
//        
//        for (int i = 0; i < 40; i++) {
//            int number = (int)(Math.random() * 100);
//            
//            if (number >= 30) {
//                System.out.println("Valid Number " + i + " : " + number);
//                validNumbers++;
//            }
//            else {
//                System.out.println("\tInvalid Number " + i + " : " + number);
//                invalidNumbers++;
//            }
//        }
//        
//        System.out.println("Number of valid numbers : " + validNumbers);
//        System.out.println("Number of invalid numbers : " + invalidNumbers);
        } catch (SQLException ex) {
            Logger.getLogger(TestExam.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
