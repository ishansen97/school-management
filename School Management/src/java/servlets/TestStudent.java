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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class TestStudent {
    
    public static void main(String[] args) {
        String query = null;
        int count = 0;
        int insertedCount = 0;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            ResultSet grades = Grades.viewGrades(); 
//            while (grades.next()) {
//                int grade = grades.getInt("Grade");
                int grade = 13;
                System.out.println("Grade : " + grade);
                
                ResultSet no_students = Subject.getBucketSubjectsWithNoStudents(grade);
//                while (no_students.next()) {
//                    String sub_code = no_students.getString("sub_code");
//                    String sub_name = no_students.getString("sub_name");
//                    
//                    System.out.print("\tSubject Code : " + sub_code + "\tSubject Name : " + sub_name);
//                    System.out.println();
                    
                    ResultSet classes = Grades.getSectionClasses("SE008");
                    while (classes.next()) {
                        String Class = classes.getString("class");
                        
                        System.out.println("\t\tClass : " + grade + "-" + Class);
                        
                        ResultSet not_doing_students = Student.getALStudentsWithNoBucketSubjects(grade, Class);
                        while (not_doing_students.next()) {
                            String student_ID = not_doing_students.getString("student_ID");
                            String fname = not_doing_students.getString("fname");
                            String lname = not_doing_students.getString("lname");
                            
                            System.out.print("\t\t\tStudent ID : " + student_ID + "\tName : " + fname + " " + lname);
                            System.out.println();
                            count++;
                            
                            String[] subjects = {"ALSU41"};
                            for (String subject : subjects) {
                            
                                query = "INSERT INTO al_student_subject(student_ID, sub_code) VALUES(?,?)";
        //                            
                                PreparedStatement pst = con.prepareStatement(query);
                                pst.setString(1, student_ID);
                                pst.setString(2, subject);

                                int result = pst.executeUpdate();

                                if (result > 0)
                                    insertedCount++;
                            }
//                            
                        }
                    }
//                }
                System.out.println("Count : " + count);
                System.out.println("Inserted Records : " + insertedCount);
//            }
            
        } catch (SQLException ex) {
            Logger.getLogger(TestStudent.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
