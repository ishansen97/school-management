/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;
import dbconnection.DBConnection;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class Class_Management {
    
    public static ResultSet getClassSubjectAllocation(int grade, String Class) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnection = DBConnection.getInstance();
            Connection con = dbconnection.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `view_class_subjects` WHERE Grade = " +grade+ " AND class = '" +Class+ "'";
            
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Class_Management.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Class_Management.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getClassSubjectTeacher(int grade, String Class, String sub_code) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnection = DBConnection.getInstance();
            Connection con = dbconnection.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT ts.teacher_ID, t.fname, t.lname FROM teacher_subject ts, teacher_subject_class tsc, teacher t " + 
                    " WHERE ts.teacher_ID = tsc.teacher_ID AND ts.teacher_ID = t.teacher_ID AND tsc.Grade = " +grade+ " AND tsc.class = '" +Class+ "' AND ts.sub_code = '" +sub_code+ "'";
            
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Class_Management.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Class_Management.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getALClassSubjectTeacher(int grade, String Class, String sub_code) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnection = DBConnection.getInstance();
            Connection con = dbconnection.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT ast.teacher_ID, t.fname, t.lname " +
                    " FROM al_subject_teacher_class astc, al_subject_teacher ast, al_subject asub, teacher t " + 
                    " WHERE astc.teacher_ID = ast.teacher_ID AND astc.teacher_ID = t.teacher_ID AND ast.sub_code = asub.sub_code " + 
                    "AND astc.Grade = " +grade+ " AND astc.class = '" +Class+ "' AND asub.grade = " +grade+ " AND asub.sub_code = '" +sub_code+ "'";
            
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Class_Management.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Class_Management.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static int getNoOfTotalSubjects(int grade, String Class) {
        String query = null;
        int count = 0;
        ResultSet result = null; 
        try {
            DBConnection dbconnection = DBConnection.getInstance();
            Connection con = dbconnection.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT COUNT(*) FROM view_class_subjects WHERE Grade = " +grade+ " AND class = '" +Class+ "'";
            
            result = st.executeQuery(query);
            
            while (result.next()) {
                count = result.getInt("COUNT(*)");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Class_Management.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Class_Management.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return count;
        }
    }
    
    public static int getNoOfTotalALSubjects(int grade, String section) {
        String query = null;
        int count = 0;
        ResultSet result = null; 
        try {
            DBConnection dbconnection = DBConnection.getInstance();
            Connection con = dbconnection.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT grade, section, COUNT(*) FROM al_subject WHERE grade = " +grade+ " AND section = '" +section+ "'";
            
            result = st.executeQuery(query);
            
            while (result.next()) {
                count = result.getInt("COUNT(*)");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Class_Management.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Class_Management.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return count;
        }
    }
    
        public static int getNoOfAllocatedSubjects(int grade, String Class) {
            String query = null;
            int count = 0;
            ResultSet result = null; 
            try {
                DBConnection dbconnection = DBConnection.getInstance();
                Connection con = dbconnection.getCon();
                Statement st = con.createStatement();

                query = "SELECT Grade, class, COUNT(*) FROM `view_temp_teacher_subject` WHERE Grade = " +grade+ " AND class = '" +Class+ "' AND sub_grade = " +grade;

                result = st.executeQuery(query);

                while (result.next()) {
                    count = result.getInt("COUNT(*)");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Class_Management.class.getName()).log(Level.SEVERE, null, ex);
            } catch (Exception ex) {
                Logger.getLogger(Class_Management.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                return count;
            }
        }
        
        public static int getNoOfAllocatedALSubjects(int grade, String Class, String section) {
            String query = null;
            int count = 0;
            ResultSet result = null; 
            try {
                DBConnection dbconnection = DBConnection.getInstance();
                Connection con = dbconnection.getCon();
                Statement st = con.createStatement();

                query = "SELECT grade, class, COUNT(*) FROM `view_temp_al_subject_class_teachers` " + 
                        " WHERE grade = " +grade+ " AND class = '" +Class+ "' AND sub_grade = " +grade+ " AND section = '" +section+ "'";

                result = st.executeQuery(query);

                while (result.next()) {
                    count = result.getInt("COUNT(*)");
                }
            } catch (SQLException ex) {
                Logger.getLogger(Class_Management.class.getName()).log(Level.SEVERE, null, ex);
            } catch (Exception ex) {
                Logger.getLogger(Class_Management.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                return count;
            }
        }
        
    }
