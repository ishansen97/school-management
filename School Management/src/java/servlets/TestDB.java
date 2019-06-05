/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;
import java.sql.*;
import dbconnection.DBConnection;
import java.util.logging.Level;
import java.util.logging.Logger;
import student.Student;

/**
 *
 * @author DELL
 */
public class TestDB {
    public static void main(String[] args) {
//        Student student = new Student();
//        String[] fnames = {"Romesh","Viraj","Pavan","Ravindu","Vidath","Pasindu","Lakshan","Matheesha","Achira","Anupa"};
//        String[] lnames = {"Samarakoon","Costa","Palliyaguru"};
//        String[] classes = {"A1","A2","A3","A4","A5","B1","B2","B3","B4","B5","C1","C2","C3","C4","C5","M1","M2","M3","M4","M5","T1","T2","T3","T4","T5"};
//        
//        DBConnection dbconnect = DBConnection.getInstance();
//        Connection con = dbconnect.getCon();
//        String query = null;
//        
//        try {
//            for (int i = 12; i <= 13; i++) {
//                for (String cla : classes) {
//                    for (String lname : lnames) {
//                        for (String fname : fnames) {
//                            query = "INSERT INTO al_student(student_ID,fname,lname,address,age,gender,grade,class,email,username,password) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
//                            String student_ID = student.generateStudentID();
//                            String email = fname + lname + cla + "@gmail.com";
//                            String username = fname + lname + i + cla;
//                            String password = fname + lname + i + cla + "123";
//                            
//                            PreparedStatement pst = con.prepareStatement(query);
//                            pst.setString(1, student_ID);
//                            pst.setString(2, fname);
//                            pst.setString(3, lname);
//                            pst.setString(4, null);
//                            pst.setInt(5, i + 5);
//                            pst.setString(6, "male");
//                            pst.setInt(7, i);
//                            pst.setString(8, cla);
//                            pst.setString(9, email);
//                            pst.setString(10, username);
//                            pst.setString(11, password);
//                            
//                            int result = pst.executeUpdate();
//                            
//                        }
//                    }
//                }
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
//        } catch (Exception ex) {
//            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
//        }

        
    }
    
}
