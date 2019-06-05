/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package grades;
import java.sql.*;
import dbconnection.DBConnection;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class Grades {
    private String type;
    
    public static ResultSet viewGrades() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT Grade FROM grade";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Grades.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
        
    }
    
    public static ResultSet viewALGrades() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT DISTINCT Grade FROM al_grades";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Grades.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
        
    }
    
    
    public static ResultSet viewALClasses() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM al_classes";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Grades.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
        
    }
    
    public static ResultSet getALSection() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM section WHERE section_name LIKE 'A/L%'";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Grades.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getALSection(int grade) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT s.section_ID, s.section_name FROM section s, al_grades al WHERE s.section_ID = al.section AND al.Grade = " + grade;
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Grades.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    
    public static ResultSet getClasses(int grade) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT class FROM classes WHERE Grade = " +grade;
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Grades.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getArtClasses() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT DISTINCT class FROM `al_classes` WHERE class LIKE 'A%'";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Grades.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getScienceClasses() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT DISTINCT class FROM `al_classes` WHERE class LIKE 'B%'";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Grades.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getCommerceClasses() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT DISTINCT class FROM `al_classes` WHERE class LIKE 'C%'";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Grades.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getMathsClasses() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT DISTINCT class FROM `al_classes` WHERE class LIKE 'M%'";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Grades.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getTechnologyClasses() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT DISTINCT class FROM `al_classes` WHERE class LIKE 'T%'";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Grades.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getRegularClasses() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT DISTINCT class FROM classes WHERE Grade BETWEEN 1 AND 9";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Grades.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getOLClasses() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT DISTINCT class FROM classes WHERE Grade BETWEEN 10 AND 11";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Grades.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getSectionClasses(String section) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            if (section.equalsIgnoreCase("SE004")) {
                result = getArtClasses();
            }
            else if (section.equalsIgnoreCase("SE005")) {
                result = getMathsClasses();
            }
            else if (section.equalsIgnoreCase("SE006")) {
                result = getScienceClasses();
            }
            else if (section.equalsIgnoreCase("SE007")) {
                result = getCommerceClasses();
            }
            else if (section.equalsIgnoreCase("SE008")) {
                result = getTechnologyClasses();
            } 
            
        } catch (SQLException ex) {
            Logger.getLogger(Grades.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static String getALSection(String Class) {
        if (Class.contains("A"))
            return "SE004";
        else if (Class.contains("M"))
            return "SE005";
        else if (Class.contains("B"))
            return "SE006";
        else if (Class.contains("C"))
            return "SE007";
        else if (Class.contains("T"))
            return "SE008";
        else
            return null;
    }
    
    public static String getSectionName(String Class) {
        String query = null;
        String section_name = null;
        ResultSet result = null;
        String section = getALSection(Class);
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT section_name FROM section WHERE section_ID = '" +section+ "'";
            result = st.executeQuery(query);
            
            while (result.next()) {
                section_name = result.getString("section_name");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Grades.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return section_name;
        }
    }
    
}
