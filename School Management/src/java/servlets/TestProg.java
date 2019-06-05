/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;
import java.sql.*;
import dbconnection.DBConnection;
import teacher.Teacher;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class TestProg {
    
    public static void main(String[] args) {
        Teacher teacher = new Teacher();
        DBConnection dbconnect = DBConnection.getInstance();
        Connection con = dbconnect.getCon();
        String query = null;
        
        
        String[] fnames = {"Jayalath","Maheshika","Kelum","Devindi","Dilum","Ishanee","Hemal","Kusum","Dhananjaya","Avanthi"};
        String[] lnames = {"Rathwatte", "Sinhawansha"};
        String[] genders = {"male","female"};
        
        try {
            for (String lname : lnames) {
                int count = 0;
                for (String fname : fnames) {
                    count++;
                    String teacher_ID = teacher.generateTeacherID();
                    int yoe = count + 15;
                    String email = fname + "_" + lname + "@gmail.com";
                    String username = fname + lname + count + "IEI";
                    String password = fname + lname + count + "IEI" + count;
                    query = "INSERT INTO teacher(teacher_ID,fname,lname,address,age,gender,YOE,email,username,password) VALUES (?,?,?,?,?,?,?,?,?,?)";
                    PreparedStatement pst = con.prepareStatement(query);

                    pst.setString(1, teacher_ID);
                    pst.setString(2, fname);
                    pst.setString(3, lname);
                    pst.setString(4, null);
                    pst.setInt(5, count + 40);
                    if (count % 2 == 0)
                        pst.setString(6, "female");
                    else
                        pst.setString(6, "male");
                    pst.setInt(7, yoe);
                    pst.setString(8, email);
                    pst.setString(9, username);
                    pst.setString(10, password);

                    int result = pst.executeUpdate();
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
