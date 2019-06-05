/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package subjects;
import java.sql.*;
import dbconnection.DBConnection;
import java.util.logging.Level;
import java.util.logging.Logger;
import student.Student;
import grades.Grades;

/**
 *
 * @author DELL
 */
public class Subject {
    private String subject_code;
    private String type;
    private String name;
    private int grade;
    private String section;
    private double credits;
    private String category;

    public Subject() {}

    public Subject(String name, String type, int grade, double credits, String category) {
        this.name = name;
        this.type = type;
        this.grade = grade;
        this.credits = credits;
        this.category = category;
    }

    public Subject(String name, String type, int grade, String section, double credits, String category) {
        this.name = name;
        this.type = type;
        this.grade = grade;
        this.section = section;
        this.credits = credits;
        this.category = category;
    }
    
    

    public void setSubject_code(String subject_code) {
        this.subject_code = subject_code;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }

    public void setCredits(double credits) {
        this.credits = credits;
    }

    public void setCategory(String category) {
        this.category = category;
    }
    
    

    public String getSubject_code() {
        return subject_code;
    }

    public String getName() {
        return name;
    }

    public int getGrade() {
        return grade;
    }

    public double getCredits() {
        return credits;
    }

    public String getCategory() {
        return category;
    }
    
    public String generateSubjectCode() {
        String query = null;
        String finalID = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            if (this.type.equalsIgnoreCase("non_al"))
                query = "SELECT sub_code FROM subject ORDER BY sub_code DESC LIMIT 1";
            else
                query = "SELECT sub_code FROM al_subject ORDER BY sub_code DESC LIMIT 1";
            
            ResultSet result = st.executeQuery(query);
            
            if (result.next()) {
                String[] idParts = null;
                String id = result.getString("sub_code");
                if (this.type.equalsIgnoreCase("non_al"))
                    idParts = id.split("SU", 2);
                else
                    idParts = id.split("ALSU", 2);
                int integerID = Integer.parseInt(idParts[1]);
                integerID++;
                
                if (this.type.equalsIgnoreCase("non_al")) {
                    if (integerID >= 1 && integerID < 10) {
                        finalID = "SU00" + integerID;
                    }
                    else if (integerID >= 10 && integerID < 100) {
                        finalID = "SU0" + integerID;
                    }
                    else if (integerID > 100 && integerID < 1000) {
                        finalID = "SU" + integerID;
                    }
                }
                else {
                    if (integerID >= 1 && integerID < 10) {
                        finalID = "ALSU0" + integerID;
                    }
                    else if (integerID >= 10 && integerID < 100) {
                        finalID = "ALSU" + integerID;
                    }
                }
            }
            else {
                if (this.type.equalsIgnoreCase("non_al"))
                    finalID = "SU001";
                else 
                    finalID = "ALSU001";
            }
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return finalID;
        }
    }
    
    public boolean addSubject() {
        String query = null;
        subject_code = generateSubjectCode();
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            
            if (this.type.equalsIgnoreCase("non_al"))
                query = "INSERT INTO subject(sub_code,sub_name,grade,credits,category) VALUES(?,?,?,?,?)";
            else
                query = "INSERT INTO al_subject(sub_code,sub_name,grade,section,credits,category) VALUES(?,?,?,?,?,?)";
            
            PreparedStatement pst = con.prepareStatement(query);
            if (this.type.equalsIgnoreCase("non_al")) {
                pst.setString(1, this.subject_code);
                pst.setString(2,this.name);
                pst.setInt(3, this.grade);
                pst.setDouble(4, this.credits);
                pst.setString(5, this.category);
            }
            else {
                pst.setString(1, this.subject_code);
                pst.setString(2,this.name);
                pst.setInt(3, this.grade);
                pst.setString(4, this.section);
                pst.setDouble(5, this.credits);
                pst.setString(6, this.category);
            }
            
            int result = pst.executeUpdate();
            
            if (result > 0)
                return true;
            else
                return false;
            
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        
    }
    
    public static ResultSet getSubjectCategories() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM subject_category";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
        
    }
    
    public static ResultSet getALSubjectCategories() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM al_subject_category";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
        
    }
    
    public static ResultSet getSubjects() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT s.sub_code, s.sub_name, s.grade, s.credits, sc.category_name FROM subject s, subject_category sc WHERE s.category = sc.category_code";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getSubjectsForGrade(int grade) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM subject WHERE grade = " + grade;
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getALSubjects() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT al.sub_code, al.sub_name, al.grade, s.section_name, al.credits, alsc.category_name " + 
                    "FROM al_subject al, al_subject_category alsc, section s " + 
                    "WHERE al.category = alsc.category_code AND al.section = s.section_ID";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static void assignSubjects(String teacher_ID, String[] subjects) {
        String query = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();

            query = "INSERT INTO teacher_subject(teacher_ID, sub_code) VALUES(?,?)";
            for (int i = 0; i < subjects.length; i++) {
                PreparedStatement pst = con.prepareStatement(query);
                pst.setString(1, teacher_ID);
                pst.setString(2, subjects[i]);
                pst.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void assignALSubjects(String teacher_ID, String[] subjects) {
        String query = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();

            query = "INSERT INTO al_subject_teacher(teacher_ID, sub_code) VALUES(?,?)";
            System.out.println(teacher_ID);
            for (int i = 0; i < subjects.length; i++) {
                PreparedStatement pst = con.prepareStatement(query);
                pst.setString(1, teacher_ID);
                pst.setString(2, subjects[i]);
                pst.executeUpdate();
            }
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static ResultSet getSubjectsAssigned() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM teacher_subject";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getALSubjectsAssigned() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM al_subject_teacher";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getSectionSubjects(int grade, String section) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM al_subject WHERE grade = " +grade+ " AND section = '" +section+ "'";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getSubjectTeachers(String sub_code) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `view_subject_teacher_names` WHERE sub_code = '"+sub_code+"'";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getALSubjectTeachers(String sub_code) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `al_subject_teacher_view` WHERE sub_code = '"+sub_code+"'";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getAssignedSubject() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM teacher_subject";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getNonAssignedSubject() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `subject` WHERE sub_code NOT IN (SELECT sub_code FROM teacher_subject)";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getAssignedALSubject() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM al_subject_teacher";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getNonAssignedALSubject() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `al_subject` WHERE sub_code NOT IN (SELECT sub_code FROM al_subject_teacher)";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getSubjectsWithNoStudents(int grade) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `subject` WHERE grade = " +grade+ " AND sub_code NOT IN (SELECT sub_code FROM student_subject)";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getALSubjectsWithNoStudents(int grade, String section) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `al_subject` WHERE grade = " +grade+ " AND section = '" +section+ "' AND sub_code NOT IN (SELECT sub_code FROM al_student_subject)";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static int getSubjectGrade(String[] subjects) {
        String query = null;
        int grade = 0;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT DISTINCT grade FROM subject WHERE ";
            
            for (int i = 0; i < subjects.length - 1; i++) {
                query += "sub_code = '" +subjects[i]+ "' OR "; 
            }
            query += "sub_code = '" +subjects[subjects.length - 1]+ "'";
            
            ResultSet result = st.executeQuery(query);
            
            if (result.next()) {
                grade = result.getInt("grade");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return grade;
        }
    }
    
    public static int getALSubjectGrade(String[] subjects) {
        String query = null;
        int grade = 0;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT DISTINCT grade FROM al_subject WHERE ";
            
            for (int i = 0; i < subjects.length - 1; i++) {
                query += "sub_code = '" +subjects[i]+ "' OR "; 
            }
            query += "sub_code = '" +subjects[subjects.length - 1]+ "'";
            
            ResultSet result = st.executeQuery(query);
            
            if (result.next()) {
                grade = result.getInt("grade");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return grade;
        }
    }
    
    public static String getALSubjectSection(String[] subjects) {
        String query = null;
        String section = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT DISTINCT section FROM al_subject WHERE ";
            
            for (int i = 0; i < subjects.length - 1; i++) {
                query += "sub_code = '" +subjects[i]+ "' OR "; 
            }
            query += "sub_code = '" +subjects[subjects.length - 1]+ "'";
            
            ResultSet result = st.executeQuery(query);
            
            if (result.next()) {
                section = result.getString("section");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return section;
        }
    }
    
    public static ResultSet getStudentsForSubjects(int grade) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `student` WHERE grade = " +grade;
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    

    
    public static void alStudentSubjectAllocation(String[] subjects) {
        String query = null;
        int grade = getALSubjectGrade(subjects);
        String section = getALSubjectSection(subjects);
        ResultSet students = Student.getSectionStudents(grade, section);
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            
            while (students.next()) {
                String student_ID = students.getString("student_ID");
                for (String subject : subjects) {
                    query = "INSERT INTO al_student_subject(student_ID,sub_code) VALUES(?,?)";
                    PreparedStatement pst = con.prepareStatement(query);
                    pst.setString(1, student_ID);
                    pst.setString(2, subject);
                    
                    int result = pst.executeUpdate();
                }
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    
    public static void studentSubjectAllocation(String[] subjects) {
        String query = null;
        int grade = getALSubjectGrade(subjects);
//        String section = getALSubjectSection(subjects);
        ResultSet students = getStudentsForSubjects(grade);
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            
            while (students.next()) {
                String student_ID = students.getString("student_ID");
                for (String subject : subjects) {
                    query = "INSERT INTO student_subject(student_ID,sub_code) VALUES(?,?)";
                    PreparedStatement pst = con.prepareStatement(query);
                    pst.setString(1, student_ID);
                    pst.setString(2, subject);
                    
                    int result = pst.executeUpdate();
                }
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    
    public static ResultSet getMySubjects(String student_ID) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT s.sub_code, s.sub_name FROM student_subject ss, subject s WHERE student_ID = '" +student_ID+ "' AND s.sub_code = ss.sub_code";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getMyALSubjects(String student_ID) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT DISTINCT a_sub.sub_code, a_sub.sub_name " + 
                    "FROM al_student_subject ass, al_subject a_sub " + 
                    "WHERE ass.student_ID = '" +student_ID+ "' AND ass.sub_code = a_sub.sub_code";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getNonBucketSubjects(int grade) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `subject` " + 
                    "WHERE grade = " + grade +" AND sub_code " + 
                    "NOT IN (SELECT sub_code FROM bucket_subjects) AND sub_code " + 
                    "NOT IN (SELECT sub_code FROM student_subject)";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getALNonBucketSubjects(int grade, String section) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `al_subject` " + 
                    "WHERE grade = " + grade +" AND section = '" +section+ "' AND sub_code " + 
                    "NOT IN (SELECT sub_code FROM al_bucket_subjects) AND sub_code " + 
                    "NOT IN (SELECT sub_code FROM al_student_subject)";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static void addBucketSubjects(String[] subjects) {
        String query = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            query = "INSERT INTO bucket_subjects(sub_code) VALUES(?)";
            
            for (String subject : subjects) {
                PreparedStatement pst = con.prepareStatement(query);
                pst.setString(1, subject);
                
                int result = pst.executeUpdate();
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    
    public static void addALBucketSubjects(String[] subjects) {
        String query = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            query = "INSERT INTO al_bucket_subjects(sub_code) VALUES(?)";
            
            for (String subject : subjects) {
                PreparedStatement pst = con.prepareStatement(query);
                pst.setString(1, subject);
                
                int result = pst.executeUpdate();
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    
    public static ResultSet getBucketSubjects(int grade) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT s.sub_code, s.sub_name FROM bucket_subjects bs, subject s WHERE s.sub_code = bs.sub_code AND s.grade = " +grade;
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getBucketSubjectsWithNoStudents(int grade) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT s.sub_code, s.sub_name " + 
                    "FROM bucket_subjects bs, subject s " +
                    " WHERE bs.sub_code = s.sub_code AND s.grade = " +grade+ 
                    " AND s.sub_code NOT IN (SELECT sub_code FROM student_subject)";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getALBucketSubjects(int grade, String Class) {
        String query = null;
        ResultSet result = null;
        String section = Grades.getALSection(Class);
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT abs.sub_code, a_sub.sub_name " + 
                    "FROM al_bucket_subjects abs, al_subject a_sub " + 
                    "WHERE abs.sub_code = a_sub.sub_code AND a_sub.grade = " +grade+ " AND a_sub.section = '" +section+ "'";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static void addStudentSubject(String[] subjects, Student student) {
        String query = null;
        String student_ID = student.getStudentID();
        int grade = student.getGrade();
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            
            if (grade >= 1 && grade < 12) {
                query = "INSERT INTO student_subject(student_ID,sub_code) VALUES(?,?)";
            }
            else if (grade >= 12 && grade <= 13) {
                query = "INSERT INTO al_student_subject(student_ID,sub_code) VALUES(?,?)";
            }
            
            for (String subject : subjects) {
                PreparedStatement pst = con.prepareStatement(query);
                pst.setString(1, student_ID);
                pst.setString(2, subject);
                
                int result = pst.executeUpdate();
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    
    public static ResultSet getBucketStudents() {
        String query = null;
        ResultSet result = null;
        
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT ss.student_ID FROM student_subject ss, bucket_subjects bs WHERE ss.sub_code = bs.sub_code";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getALBucketStudents() {
        String query = null;
        ResultSet result = null;
        
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT ass.student_ID FROM al_student_subject ass, al_bucket_subjects abs WHERE ass.sub_code = abs.sub_code";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static boolean isBucketStudent(Student student) {
        String query = null;
        ResultSet bucketStudents = null;
        String student_ID = student.getStudentID();
        int grade = student.getGrade();
        boolean isBucketStudent = false;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            if (grade >= 1 && grade < 12) {
                bucketStudents = getBucketStudents();
            }
            else if (grade >= 12 && grade <= 13) {
                bucketStudents = getALBucketStudents();
            }
            
            while (bucketStudents.next()) {
                String id = bucketStudents.getString("student_ID");
                
                if (id.equalsIgnoreCase(student_ID)) {
                    isBucketStudent = true;
                }
            }
            
            
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return isBucketStudent;
        }
    }
    
    public static ResultSet getStudentsNotDoingSubject(int grade, String Class, String sub_code) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM student " + 
                    " WHERE grade = " +grade+ 
                    " AND class = '" +Class+ "' AND student_ID NOT IN " + 
                    "(SELECT ss.student_ID FROM student_subject ss, subject s " + 
                    " WHERE ss.sub_code = s.sub_code AND s.sub_code = '" +sub_code+ "') LIMIT 8";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static double getCredits(String subject) {
        String query = null;
        ResultSet result = null;
        double credits = 0;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM subject WHERE sub_code = '" +subject+ "'";
            result = st.executeQuery(query);
            
            if (result.next()) {
                credits = result.getDouble("credits");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return credits;
        }
    }
    
    public static double getALCredits(String subject) {
        String query = null;
        ResultSet result = null;
        double credits = 0;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM al_subject WHERE sub_code = '" +subject+ "'";
            result = st.executeQuery(query);
            
            if (result.next()) {
                credits = result.getDouble("credits");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Subject.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return credits;
        }
    }
    
    
}
