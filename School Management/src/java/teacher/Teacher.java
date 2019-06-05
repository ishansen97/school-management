/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package teacher;
import java.sql.*;
import dbconnection.DBConnection;
import grades.Grades;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class Teacher {
    private String teacher_ID;
    private String firstName;
    private String lastName;
    private String address;
    private String gender;
    private int age;
    private int years_of_experience;
    private String email;
    private String username;
    private String password;

    public Teacher() {}
    
    

    public Teacher(String firstName, String lastName, String address, String gender, int age, int years_of_experience, String email, String username, String password) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.gender = gender;
        this.age = age;
        this.years_of_experience = years_of_experience;
        this.email = email;
        this.username = username;
        this.password = password;
    }

    public void setTeacher_ID(String teacher_ID) {
        this.teacher_ID = teacher_ID;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public void setYears_of_experience(int years_of_experience) {
        this.years_of_experience = years_of_experience;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getTeacher_ID() {
        return teacher_ID;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getAddress() {
        return address;
    }

    public String getGender() {
        return gender;
    }

    public int getAge() {
        return age;
    }

    public int getYears_of_experience() {
        return years_of_experience;
    }

    public String getEmail() {
        return email;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }
    
    
    
    public String generateTeacherID() {
        String query = null;
        String finalID = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT teacher_ID FROM teacher ORDER BY teacher_ID DESC LIMIT 1";
            
            ResultSet result = st.executeQuery(query);
            
            if (result.next()) {
                String t_id = result.getString("teacher_ID");
                String[] idParts = t_id.split("IEIT", 2);
                int integerID = Integer.parseInt(idParts[1]);
                integerID++;
                
                if (integerID >= 1 && integerID <= 9) {
                    finalID = "IEIT00" + integerID;
                }
                else if (integerID >= 10 && integerID < 100) {
                    finalID = "IEIT0" + integerID;
                }
                else if (integerID >= 100 && integerID < 1000) {
                    finalID = "IEIT" + integerID;
                }
            }
            else {
                finalID = "IEIT001";
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return finalID;
        }
    }
    
    public boolean registerTeacher() {
        String query = null;
        teacher_ID = generateTeacherID();
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            
            query = "INSERT INTO teacher(teacher_ID,fname,lname,address,age,gender,YOE,email,username,password) VALUES(?,?,?,?,?,?,?,?,?,?)";
            
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, this.teacher_ID);
            pst.setString(2, this.firstName);
            pst.setString(3, this.lastName);
            pst.setString(4, this.address);
            pst.setInt(5, this.age);
            pst.setString(6, this.gender);
            pst.setInt(7, this.years_of_experience);
            pst.setString(8, this.email);
            pst.setString(9, this.username);
            pst.setString(10, this.password);
            
            int result = pst.executeUpdate();
            
            if (result > 0)
                return true;
            else
                return false;
            
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    public static boolean updateTeacher(Teacher teacher) {
        String query = null;
        String teacher_ID = teacher.getTeacher_ID();
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            query = "UPDATE teacher SET fname = ?, lname = ?, address = ?, age = ?, gender = ?, YOE = ?, email = ?, username = ?, password = ? WHERE teacher_ID = '" +teacher_ID+ "'";
            
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, teacher.getFirstName());
            pst.setString(2, teacher.getLastName());
            pst.setString(3, teacher.getAddress());
            pst.setInt(4, teacher.getAge());
            pst.setString(5, teacher.getGender());
            pst.setInt(6, teacher.getYears_of_experience());
            pst.setString(7, teacher.getEmail());
            pst.setString(8, teacher.getUsername());
            pst.setString(9, teacher.getPassword());
            
            int result = pst.executeUpdate();
            
            if (result > 0) 
                return true;
            else
                return false;
            
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    public static Teacher getTeacher(String username, String password) {
        String query = null;
        Teacher teacher = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM teacher WHERE username = '" +username+ "' AND password = '" +password+ "'";
            ResultSet result = st.executeQuery(query);
            
            while (result.next()) {
                teacher = new Teacher();
                teacher.setTeacher_ID(result.getString("teacher_ID"));
                teacher.setFirstName(result.getString("fname"));
                teacher.setLastName(result.getString("lname"));
                teacher.setAge(result.getInt("age"));
                teacher.setYears_of_experience(result.getInt("YOE"));
                teacher.setGender(result.getString("gender"));
                teacher.setEmail(result.getString("email"));
                teacher.setUsername(result.getString("username"));
                teacher.setPassword(result.getString("password"));
                teacher.setAddress(result.getString("address"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return teacher;
        }
    }
    
    public static ResultSet getAllTeachers() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM teacher";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
        
       
    }
    
    public static ResultSet getAvailableTeachers() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM teacher WHERE teacher_ID NOT IN (SELECT teacher_ID FROM class_head) AND teacher_ID NOT IN (SELECT teacher_ID FROM al_class_head)";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static boolean assignClassTeachers(String teacher_ID, String category, int grade, String Class) {
        String query = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            
            if (category.equalsIgnoreCase("non_al")) {
                query = "INSERT INTO class_head(teacher_ID,grade,class) VALUES(?,?,?)";
            }
            else if (category.equalsIgnoreCase("al")) {
                query = "INSERT INTO al_class_head(teacher_ID,grade,class) VALUES(?,?,?)";
            }
            
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, teacher_ID);
            pst.setInt(2, grade);
            pst.setString(3, Class);
            
            int result = pst.executeUpdate();
            
            if (result > 0)
                return true;
            else
                return false;
            
            
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } catch (Exception ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    public static ResultSet getClassTeacher(int grade, String Class) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT fname, lname FROM `view_class_teacher_names` WHERE Grade = " +grade+ " AND class = '" +Class+ "'";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getALClassTeacher(int grade, String Class) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT fname, lname FROM `view_al_class_teacher_names` WHERE Grade = " +grade+ " AND class = '" +Class+ "'";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getTeacherForGrade(int grade) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT DISTINCT teacher_ID, fname, lname, sub_code, sub_name FROM `regular_grade_subject_teachers` WHERE grade = " +grade;
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getALTeachersForGrade(int grade, String section) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `al_subject_teacher_view` WHERE grade = " + grade +" AND section = '" +section+ "'";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static void teacherSubjectClassAllocation(String[] teachers, String[] classes) {
        String query = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            query = "INSERT INTO teacher_subject_class (teacher_ID,Grade,class) VALUES(?,?,?)";

            for (String teacher : teachers) {
                PreparedStatement pst = con.prepareStatement(query);
                for (String Class : classes) {
                    String[] classParts = Class.split("-", 2);
                    int grade = Integer.parseInt(classParts[0]);
                    pst.setString(1, teacher);
                    pst.setInt(2, grade);
                    pst.setString(3, classParts[1]);
                    
                    int result = pst.executeUpdate();
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void alTeacherSubjectClassAllocation(String teacher, String[] classes) {
        String query = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            query = "INSERT INTO al_subject_teacher_class (teacher_ID,Grade,class) VALUES(?,?,?)";

            for (String Class : classes) {
                PreparedStatement pst = con.prepareStatement(query);
                String[] classParts = Class.split("-", 2);
                int grade = Integer.parseInt(classParts[0]);
                pst.setString(1, teacher);
                pst.setInt(2, grade);
                pst.setString(3, classParts[1]);

                int result = pst.executeUpdate();
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static ResultSet getTeacherSubjectAllocations() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `teacher_subject_class`";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getALTeacherSubjectAllocations() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `al_subject_teacher_class`";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public ResultSet[] getMySubjectGrades() {
        String query = null;
        String query1 = null;
        ResultSet result = null;
        ResultSet result1 = null;
        ResultSet[] resultset_grades = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            Statement st1 = con.createStatement();
            resultset_grades = new ResultSet[2];
            
            query = "SELECT DISTINCT s.grade FROM teacher_subject ts, subject s " + 
                    "WHERE ts.sub_code = s.sub_code AND ts.teacher_ID = '" +teacher_ID+ "'";
            result = st.executeQuery(query);
            resultset_grades[0] = result;
            
            query1 = "SELECT DISTINCT asub.grade FROM al_subject asub, al_subject_teacher ast " + 
                    "WHERE ast.sub_code = asub.sub_code AND ast.teacher_ID = '" +teacher_ID+ "'";
            
            result1 = st1.executeQuery(query1);
            resultset_grades[1] = result1;
            
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return resultset_grades;
        }
    }
    
    public ResultSet getMyClasses(int grade) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            if (grade >= 12 && grade <= 13) 
                query = "SELECT DISTINCT class FROM al_subject_teacher_class WHERE teacher_ID = '" +teacher_ID+ "' AND Grade = " + grade;
            else
                query = "SELECT DISTINCT class FROM `teacher_subject_class` WHERE teacher_ID = '" +teacher_ID+ "' AND Grade = " + grade;
            
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public ResultSet getMySubjects(int grade, String Class) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            if (grade >= 12 && grade <= 13) {
                String section = Grades.getALSection(Class);
                query = "SELECT asub.sub_code, asub.sub_name, astc.Grade, astc.class " + 
                        " FROM al_subject_teacher_class astc, al_subject_teacher ast, al_subject asub " + 
                        " WHERE astc.teacher_ID = ast.teacher_ID AND ast.sub_code = asub.sub_code " + 
                        " AND astc.Grade = " +grade+ " AND ast.teacher_ID = '" +teacher_ID+ "' AND astc.class = '" +Class+ "' AND asub.grade = " +grade+ " AND asub.section = '" +section+ "'";
            }
            else {
                query = "SELECT s.sub_code, s.sub_name FROM teacher_subject_class tsc, teacher_subject ts, subject s " + 
                    " WHERE tsc.teacher_ID = ts.teacher_ID AND ts.sub_code = s.sub_code " + 
                    " AND tsc.teacher_ID = '" +teacher_ID+ "' AND tsc.Grade = " +grade+ " AND tsc.class = '" +Class+ "' AND s.grade = " + grade;
            }
            
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public boolean isClassTeacher() {
        String query = null;
        String query1 = null;
        ResultSet result = null;
        ResultSet result1 = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            Statement st1 = con.createStatement();
            
            query = "SELECT * FROM class_head WHERE teacher_ID = '" +teacher_ID+ "'";
            result = st.executeQuery(query);
            
            if (result.next()) {
                return true;
            }
            else {
                query1 = "SELECT * FROM al_class_head WHERE teacher_ID = '" +teacher_ID+ "'";
                result1 = st1.executeQuery(query1);
                
                if (result1.next()) 
                    return true;
                else
                    return false;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        } catch (Exception ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }  
    }
    
    public String ClassTeacherType() {
        String query = null;
        String query1 = null;
        ResultSet result = null;
        ResultSet result1 = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            Statement st1 = con.createStatement();
            
            query = "SELECT * FROM class_head WHERE teacher_ID = '" +teacher_ID+ "'";
            result = st.executeQuery(query);
            
            if (result.next()) {
                return "regular";
            }
            else {
                query1 = "SELECT * FROM al_class_head WHERE teacher_ID = '" +teacher_ID+ "'";
                result1 = st1.executeQuery(query1);
                
                if (result1.next()) 
                    return "a/l";
                else
                    return "nothing";
            }
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
            return ex.getMessage();
        } catch (Exception ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
            return ex.getMessage();
        }  
    }
    
    public ResultSet getMyClass() {
        String query = null;
        ResultSet result = null;
        String type = ClassTeacherType();
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            if (type.equalsIgnoreCase("regular"))
                query = "SELECT * FROM class_head WHERE teacher_ID = '" +teacher_ID+ "'";
            else if (type.equalsIgnoreCase("a/l"))
                query = "SELECT * FROM al_class_head WHERE teacher_ID = '" +teacher_ID+ "'";
            
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public int ClassStudentCount(int grade, String Class) {
        String query = null;
        ResultSet result = null;
        int no_of_students = 0;
        String type = ClassTeacherType();
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            if (type.equalsIgnoreCase("regular"))
                query = "SELECT s.grade, s.class, COUNT(*) FROM student s WHERE s.grade = " +grade+ " AND s.class = '" +Class+ "'";
            else if (type.equalsIgnoreCase("a/l"))
                query = "SELECT s.grade, s.class, COUNT(*) FROM al_student s WHERE s.grade = " +grade+ " AND s.class = '" +Class+ "'";
            
            result = st.executeQuery(query);
            
            if (result.next()) {
                no_of_students = result.getInt("COUNT(*)");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return no_of_students;
        }
    }
    
}
