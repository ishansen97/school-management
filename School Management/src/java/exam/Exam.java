/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package exam;
import java.sql.*;
import dbconnection.*;
import grades.Grades;
import java.text.DecimalFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class Exam {
    private String exam_ID;
    private String exam_name;
    private int semester;
    private int grade;
    private String section;
    private String category;

    public Exam(String exam_name, int semester, int grade, String category) {
        this.exam_name = exam_name;
        this.semester = semester;
        this.grade = grade;
        this.category = category;
    }

    public Exam(String exam_name, int semester, int grade, String section, String category) {
        this.exam_name = exam_name;
        this.semester = semester;
        this.grade = grade;
        this.section = section;
        this.category = category;
    }

    public String getExam_ID() {
        return exam_ID;
    }

    public String getExam_name() {
        return exam_name;
    }

    public int getSemester() {
        return semester;
    }

    public int getGrade() {
        return grade;
    }

    public String getSection() {
        return section;
    }

    public String getCategory() {
        return category;
    }

    public void setExam_ID(String exam_ID) {
        this.exam_ID = exam_ID;
    }

    public void setExam_name(String exam_name) {
        this.exam_name = exam_name;
    }

    public void setSemester(int semester) {
        this.semester = semester;
    }

    public void setGrade(int grade) {
        this.grade = grade;
    }

    public void setSection(String section) {
        this.section = section;
    }

    public void setCategory(String category) {
        this.category = category;
    }
    
    
    
    public String generateExamID() {
        String query = null;
        String final_ID = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            if (this.category.equalsIgnoreCase("non_al")) {
                query = "SELECT exam_ID FROM exam ORDER BY exam_ID DESC LIMIT 1";
            }
            else {
                query = "SELECT exam_ID FROM al_exam ORDER BY exam_ID DESC LIMIT 1";
            }
            
            ResultSet result = st.executeQuery(query);
            
            if (result.next()) {
                String id = result.getString("exam_ID");
                String[] idParts = null;
                int integerID = 0;
                
                if (this.category.equalsIgnoreCase("non_al")) {
                    idParts = id.split("EX", 2);
                    integerID = Integer.parseInt(idParts[1]);
                    integerID++;
                    
                    if (integerID >=1 && integerID < 10) {
                        final_ID = "EX000" + integerID;
                    }
                    else if (integerID >= 10 && integerID < 100) {
                        final_ID = "EX00" + integerID;
                    }
                    else if (integerID >= 100 && integerID < 1000) {
                        final_ID = "EX0" + integerID;
                    }
                    else if (integerID >= 1000 && integerID < 10000) {
                        final_ID = "EX" + integerID;
                    }
                }
                else {
                    idParts = id.split("ALEX", 2);
                    integerID = Integer.parseInt(idParts[1]);
                    integerID++;
                    
                    if (integerID >=1 && integerID < 10) {
                        final_ID = "ALEX000" + integerID;
                    }
                    else if (integerID >= 10 && integerID < 100) {
                        final_ID = "ALEX00" + integerID;
                    }
                    else if (integerID >= 100 && integerID < 1000) {
                        final_ID = "ALEX0" + integerID;
                    }
                    else if (integerID >= 1000 && integerID < 10000) {
                        final_ID = "ALEX" + integerID;
                    }
                }
            }
            else {
                if (this.category.equalsIgnoreCase("non_al")) {
                    final_ID = "EX0001";
                }
                else {
                    final_ID = "ALEX0001";
                }
            }
            
            
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return final_ID;
        }
    }
    
    public boolean addExam() {
        String query = null;
        this.exam_ID = generateExamID();
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            
            if (this.category.equalsIgnoreCase("non_al")) {
                query = "INSERT INTO exam(exam_ID,exam_name,grade,semester) VALUES(?,?,?,?)";
            }
            else {
                query = "INSERT INTO al_exam(exam_ID,exam_name,Grade,section,semester) VALUES(?,?,?,?,?)";
            }
            
            PreparedStatement pst = con.prepareStatement(query);
            
            if (this.category.equalsIgnoreCase("non_al")) {
                pst.setString(1, this.exam_ID);
                pst.setString(2, this.exam_name);
                pst.setInt(3, this.grade);
                pst.setInt(4, this.semester);
            }
            else {
                pst.setString(1, this.exam_ID);
                pst.setString(2, this.exam_name);
                pst.setInt(3, this.grade);
                pst.setString(4, this.section);
                pst.setInt(5, this.semester);
            }
            
            int result = pst.executeUpdate();
            
            if (result > 0)
                return true;
            else
                return false;
            
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
        
        
    }
    
    public static ResultSet getSemesters() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM semester";
            result = st.executeQuery(query);
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getExams() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM exam";
            result = st.executeQuery(query);
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getALExams() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM al_exam";
            result = st.executeQuery(query);
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getExamsForGrade(int grade) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM exam WHERE grade = " + grade + " AND exam_ID NOT IN (SELECT exam_ID FROM subject_exam)";
            result = st.executeQuery(query);
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getAllExamsForGrade(int grade, String Class) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            String section = null;
            
            if (grade >= 12 && grade <= 13) {
                section = Grades.getALSection(Class);
                query = "SELECT * FROM al_exam WHERE grade = " +grade+ " AND section = '" +section+ "'";
            }    
            else
                query = "SELECT * FROM exam WHERE grade = " + grade;
            
            result = st.executeQuery(query);
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getAllExamsForGrade(int grade) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            String section = null;
            
            query = "SELECT * FROM exam WHERE grade = " + grade;
            
            result = st.executeQuery(query);
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getClassExamsForGrade(int grade, String Class, String type) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            String section = null;
            
            if (type.equalsIgnoreCase("regular"))
                result = getAllExamsForGrade(grade, Class);
            else if (type.equalsIgnoreCase("a/l")) {
                section = Grades.getALSection(Class);
                result = getAllALExamsForGrade(grade, section);
            }
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet[] getAnyExam(int grade, String Class) {
        String query = null;
        ResultSet regular_exam = null;
        ResultSet al_exam = null;
        ResultSet[] all_exams = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            String section = null;
            all_exams = new ResultSet[2];
            
            
            if (grade >= 12 && grade <= 13) {
                section = Grades.getALSection(Class);
                al_exam = getAllALExamsForGrade(grade,section);
                System.out.println(section);
                all_exams[1] = al_exam;
//                System.out.println(all_exams[1]);
            }
            else {
                regular_exam = getAllExamsForGrade(grade, Class);
                System.out.println(grade);
                all_exams[0] = regular_exam;
            }
            
            
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return all_exams;
        }
    }
    
    public static ResultSet getAllALExamsForGrade(int grade, String section) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM al_exam WHERE grade = " +grade+ " AND section = '" +section+ "'";
            result = st.executeQuery(query);
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    
    
    public static ResultSet getExamSubjects(String exam) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `exam_student_count_view` WHERE exam_ID = '" +exam+ "'";
            result = st.executeQuery(query);
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    
    public static ResultSet[] getExamSubjectsForTeacher(String exam, String teacher, int grade) {
        String query = null;
        ResultSet regular_result = null;
        ResultSet al_result = null;
        ResultSet[] subject_result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            subject_result = new ResultSet[2];
            
            if (grade >= 12 && grade <= 13) {
                query = "SELECT vaees.exam_ID, vaees.exam_name, vaees.grade, vaees.section, vaees.sub_code, vaees.sub_name, asub.credits, vaees.no_of_students " + 
                        " FROM view_al_exam_eligible_students vaees, al_subject_teacher ast, al_subject asub " + 
                        " WHERE vaees.sub_code = ast.sub_code AND vaees.sub_code = asub.sub_code AND ast.teacher_ID = '" +teacher+ "' AND vaees.exam_ID = '" +exam+ "'";
                
                al_result = st.executeQuery(query);
                subject_result[1] = al_result;
            }
            else {
                query = "SELECT DISTINCT escv.exam_ID, escv.exam_name, escv.grade, escv.sub_code, escv.sub_name, s.credits, escv.no_of_students " + 
                        " FROM exam_student_count_view escv, teacher_subject ts, subject s " + 
                        " WHERE exam_ID = '" +exam+ "' AND escv.sub_code = ts.sub_code AND escv.sub_code = s.sub_code AND ts.teacher_ID = '" +teacher+ "'";
                regular_result = st.executeQuery(query);    
                subject_result[0] = regular_result;
            }
            
            
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return subject_result;
        }
    }
    
    public static ResultSet getALExamSubjects(String exam) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `view_al_exam_eligible_students` WHERE exam_ID = '" +exam+ "'";
            result = st.executeQuery(query);
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getALExamsForGrade(int grade) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM al_exam WHERE Grade = " + grade + " AND exam_ID NOT IN (SELECT exam_ID FROM al_subject_exam)";
            result = st.executeQuery(query);
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getALExamsForSection(int grade, String section) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM al_exam WHERE Grade = "+grade+ " AND section = '"+section+"' AND exam_ID NOT IN (SELECT exam_ID FROM al_subject_exam)";
            result = st.executeQuery(query);
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getALSubjectsForSection(int grade, String section) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM al_subject WHERE grade = "+grade+ " AND section = '"+section+"'";
            result = st.executeQuery(query);
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static void assignSubjectsForExams(String[] exams, String[] subjects) {
        String query = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();

            query = "INSERT INTO subject_exam(exam_ID,subject_ID) VALUES(?,?)";

            for (String exam : exams) {
                PreparedStatement pst = con.prepareStatement(query);
                for (String subject : subjects) {
                    pst.setString(1, exam);
                    pst.setString(2, subject);
                    pst.executeUpdate();
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void assignSubjectsForALExams(String[] exams, String[] subjects) {
        String query = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();

            query = "INSERT INTO al_subject_exam(exam_ID,subject_ID) VALUES(?,?)";

            for (String exam : exams) {
                PreparedStatement pst = con.prepareStatement(query);
                for (String subject : subjects) {
                    pst.setString(1, exam);
                    pst.setString(2, subject);
                    pst.executeUpdate();
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static ResultSet getStudentCountSubjects(String exam, String subject) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT s.sub_code, s.sub_name, COUNT(*) " + 
                    "FROM exam e, subject_exam se, subject s, student_subject ss " + 
                    "WHERE e.exam_ID = se.exam_ID AND se.subject_ID = s.sub_code AND s.sub_code = ss.sub_code AND e.exam_ID = " +exam+ "' AND s.sub_code = '" +subject+ 
                    "' GROUP BY s.sub_code, s.sub_name";
            result = st.executeQuery(query);
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getStudentExamSubjects(String exam, String student, String type) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            if (type.equalsIgnoreCase("regular")) {
                query = "SELECT s.sub_code, s.sub_name, s.credits, ses.marks, ses.grade_points " + 
                        "FROM subject_exam_student ses, subject s WHERE ses.subject_ID = s.sub_code " + 
                        " AND ses.student_ID = '" +student+ "' AND ses.exam_ID = '" +exam+ "'";
            }
            else if (type.equalsIgnoreCase("a/l")) {
                query = "SELECT s.sub_code, s.sub_name, s.credits, ses.marks, ses.grade_points " + 
                        "FROM al_subject_exam_student ses, al_subject s WHERE ses.subject_ID = s.sub_code " + 
                        " AND ses.student_ID = '" +student+ "' AND ses.exam_ID = '" +exam+ "'";
            }
            
            result = st.executeQuery(query);
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getStudentExamMarks(String exam, int grade, String Class, String subject) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            if (grade >= 12 && grade <= 13) {
                query = "SELECT s.student_ID, s.fname, s.lname, ses.marks, ses.grade_points " + 
                        " FROM al_subject_exam_student ses, al_student s " + 
                        " WHERE ses.student_ID = s.student_ID AND ses.exam_ID = '" +exam+ "' AND ses.subject_ID = '" +subject+ "' AND s.grade = " +grade+ " AND s.class = '" +Class+ "'";
            }
            else {
                query = "SELECT s.student_ID, s.fname, s.lname, ses.marks, ses.grade_points " + 
                        " FROM subject_exam_student ses, student s " + 
                        " WHERE ses.student_ID = s.student_ID AND ses.exam_ID = '" +exam+ "' AND ses.subject_ID = '" +subject+ "' AND s.grade = " +grade+ "  AND s.class = '" +Class+ "'";
            }
            
            System.out.println(query);
            result = st.executeQuery(query);
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet viewGradePoints() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `grade_points`";
            result = st.executeQuery(query);
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static String getGrade(int mark) {
        String query = null;
        String grade = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT Grade FROM `grade_points` WHERE lower_mark <= " +mark+ " AND upper_mark >= " +mark;
            result = st.executeQuery(query);
            
            if (result.next()) {
                grade = result.getString("Grade");
            }
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return grade;
        }
    }
    
    public static String getGrade(double mark) {
        String query = null;
        String grade = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT Grade FROM `gpa_grade` WHERE lower_gpa <= " +mark+ " AND upper_gpa >= " +mark;
            result = st.executeQuery(query);
            
            if (result.next()) {
                grade = result.getString("Grade");
            }
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return grade;
        }
    }
    
    public static String insertStudentExamMarks(String exam, String student, String subject, double grade_points, double marks, int grade) {
        String query = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            
            if (grade >= 12 && grade <= 13) {
                query = "INSERT INTO al_subject_exam_student(exam_ID,subject_ID,student_ID,marks,grade_points) VALUES(?,?,?,?,?)";
            }
            else {
                query = "INSERT INTO subject_exam_student(exam_ID,subject_ID,student_ID,marks,grade_points) VALUES(?,?,?,?,?)";
            }
            
            DecimalFormat formatter = new DecimalFormat("#0.0");
            grade_points  = Double.parseDouble(formatter.format(grade_points));
            
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, exam);
            pst.setString(2, subject);
            pst.setString(3, student);
            pst.setDouble(4, marks);
            pst.setDouble(5, grade_points);
            
            int result = pst.executeUpdate();
            
            if (result > 0)
                return "Successfully Inserted";
            else
                return "Not Inserted";
            
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
            return ex.getMessage();
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
            return ex.getMessage();
        }
    }
    
    public static ResultSet getSemesterExamForGrade(int grade, int semester) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
  
            query = "SELECT * FROM `exam` WHERE grade = " +grade+ " AND semester = " +semester;
            result = st.executeQuery(query);
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getSemesterALExamForGrade(int grade, int semester, String section) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
  
            query = "SELECT * FROM `al_exam` WHERE grade = " +grade+ " AND semester = " +semester+ " AND section = '" +section+ "'";
            result = st.executeQuery(query);
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static String insertStudentExamRecords(String student, String exam, int grade, double average, double gpa, int total, int rank, String Class) {
        String query = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            
            if (grade >= 12 && grade <= 13)
                query = "INSERT INTO al_exam_records(student_ID,exam_ID,total,average,gpa,rank,class) VALUES(?,?,?,?,?,?,?)";
            else
                query = "INSERT INTO regular_exam_records(student_ID,exam_ID,total,average,gpa,rank,class) VALUES(?,?,?,?,?,?,?)";
            
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, student);
            pst.setString(2, exam);
            pst.setInt(3, total);
            pst.setDouble(4, average);
            pst.setDouble(5, gpa);
            pst.setInt(6, rank);
            pst.setString(7, Class);
            
            int result = pst.executeUpdate();
            
            if (result > 0)
                return "record inserted";
            else
                return "record not inserted";

            
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
            return ex.getMessage();
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
            return ex.getMessage();
        }
    }
    
    public static ResultSet getMyExamStatistics(String student, String exam, int grade) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            if (grade >= 12 && grade <= 13)
                query = "SELECT * FROM `al_exam_records` WHERE student_ID = '" +student+ "' AND exam_ID = '" +exam+ "'";
            else
                query = "SELECT * FROM `regular_exam_records` WHERE student_ID = '" +student+ "' AND exam_ID = '" +exam+ "'";
            
            result = st.executeQuery(query);
                    
        } catch (SQLException ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Exam.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
}
