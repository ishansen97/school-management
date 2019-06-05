/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package student;
import dbconnection.DBConnection;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class Student {
    private String studentID;
    private String firstName;
    private String lastname;
    private String gender;
    private int age;
    private int grade;
    private String Class;
    private String address;
    private String email;
    private String username;
    private String password;

    public Student() {}

    public Student(String firstName, String lastname, int age, String gender, int grade, String Class, String address, String email, String username, String password) {
        this.firstName = firstName;
        this.lastname = lastname;
        this.age = age;
        this.gender = gender;
        this.grade = grade;
        this.Class = Class;
        this.address = address;
        this.email = email;
        this.username = username;
        this.password = password;
    }
    
    public String generateStudentID() {
        String query = null;
        String finalID = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
//            if (this.grade == 12 || this.grade == 13)
                query = "SELECT student_ID FROM al_student ORDER BY student_ID DESC LIMIT 1";
//            else
//                query = "SELECT student_ID FROM student ORDER BY student_ID DESC LIMIT 1";
            
            ResultSet result = st.executeQuery(query);
            
            if (result.next()) {
                String id = result.getString("student_ID");
                String[] idParts = null;
                
                if (this.grade == 12 || this.grade == 13)
                    idParts = id.split("IEIAL", 2);
                else
                    idParts = id.split("IEI", 2);
                
                int integerID = Integer.parseInt(idParts[1]);
                integerID++;
                
                if (this.grade == 12 || this.grade == 13) {
                    if (integerID >= 1 && integerID < 10) {
                        finalID = "IEIAL000" + integerID;
                    }
                    else if (integerID >= 10 && integerID < 100) {
                        finalID = "IEIAL00" + integerID;
                    }
                    else if (integerID >= 100 && integerID < 1000) {
                        finalID = "IEIAL0" + integerID;
                    }
                    else if (integerID >= 1000 && integerID < 10000) {
                        finalID = "IEIAL" + integerID;
                    }
                }
                else {
                    if (integerID >= 1 && integerID < 10) {
                        finalID = "IEI000" + integerID;
                    }
                    else if (integerID >= 10 && integerID < 100) {
                        finalID = "IEI00" + integerID;
                    }
                    else if (integerID >= 100 && integerID < 1000) {
                        finalID = "IEI0" + integerID;
                    }
                    else if (integerID >= 1000 && integerID < 10000) {
                        finalID = "IEI" + integerID;
                    }
                }
            }
            else {
                if (this.grade == 12 || this.grade == 13)
                    finalID = "IEIAL0001";
                else
                    finalID = "IEI0001";
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return finalID;
        }
        
    }
    
    public boolean registerStudent() {
        String query = null;
        studentID = generateStudentID();
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            
            if (this.grade >= 12 && this.grade <= 13)
                query = "INSERT INTO al_student(student_ID,fname,lname,address,age,gender,grade,class,email,username,password) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
            else
                query = "INSERT INTO student(student_ID,fname,lname,address,age,gender,grade,class,email,username,password) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
            
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, this.studentID);
            pst.setString(2, this.firstName);
            pst.setString(3, this.lastname);
            pst.setString(4, this.address);
            pst.setInt(5, this.age);
            pst.setString(6, this.gender);
            pst.setInt(7, this.grade);
            pst.setString(8, this.Class);
            pst.setString(9, this.email);
            pst.setString(10, this.username);
            pst.setString(11, this.password);
            
            int result = pst.executeUpdate();
            
            if (result > 0)
                return true;
            else
                return false;
            
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    public static boolean updateStudent(Student student) {
        String query = null;
        String student_ID = student.getStudentID();
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            query = "UPDATE student SET fname = ?, lname = ?, address = ?, age = ?, gender = ?, email = ?, username = ?, password = ? WHERE student_ID = '" +student_ID+ "'";
            
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, student.getFirstName());
            pst.setString(2, student.getLastname());
            pst.setString(3, student.getAddress());
            pst.setInt(4, student.getAge());
            pst.setString(5, student.getGender());
            pst.setString(6, student.getEmail());
            pst.setString(7, student.getUsername());
            pst.setString(8, student.getPassword());
            
            int result = pst.executeUpdate();
            
            if (result > 0) 
                return true;
            else
                return false;
            
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public String getStudentID() {
        return studentID;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastname() {
        return lastname;
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

    public int getGrade() {
        return grade;
    }

    public String getClasses() {
        return Class;
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

    public void setStudentID(String studentID) {
        this.studentID = studentID;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
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

    public void setGrade(int grade) {
        this.grade = grade;
    }

    public void setClass(String Class) {
        this.Class = Class;
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
    
    public static Student getStudent(String username, String password) {
        String query = null;
        Student student = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM student WHERE username = '" +username+ "' AND password = '" +password+ "'";
            ResultSet result = st.executeQuery(query);
            
            while (result.next()) {
                student = new Student();
                student.setStudentID(result.getString("student_ID"));
                student.setFirstName(result.getString("fname"));
                student.setLastname(result.getString("lname"));
                student.setClass(result.getString("class"));
                student.setAge(result.getInt("age"));
                student.setGender(result.getString("gender"));
                student.setGrade(result.getInt("grade"));
                student.setEmail(result.getString("email"));
                student.setUsername(result.getString("username"));
                student.setPassword(result.getString("password"));
                student.setAddress(result.getString("address"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return student;
        }
    }
    
    public static Student getALStudent(String username, String password) {
        String query = null;
        Student student = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM al_student WHERE username = '" +username+ "' AND password = '" +password+ "'";
            ResultSet result = st.executeQuery(query);
            
            while (result.next()) {
                student = new Student();
                student.setStudentID(result.getString("student_ID"));
                student.setFirstName(result.getString("fname"));
                student.setLastname(result.getString("lname"));
                student.setClass(result.getString("class"));
                student.setAge(result.getInt("age"));
                student.setGender(result.getString("gender"));
                student.setGrade(result.getInt("grade"));
                student.setEmail(result.getString("email"));
                student.setUsername(result.getString("username"));
                student.setPassword(result.getString("password"));
                student.setAddress(result.getString("address"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return student;
        }
    }
    
    public static ResultSet getRegularStudents() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM student";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getALStudents() {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM al_student";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet searchRegularStudents(String search) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM student WHERE student_ID LIKE '" +search+ "%' OR fname LIKE '" +search+ "%' OR lname LIKE '" +search+ "%' OR email LIKE '" +search+ "%' OR grade LIKE '"+search+ "%'";
            System.out.println(query);
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet searchALStudents(String search) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM al_student WHERE student_ID LIKE '" +search+ "%' OR fname LIKE '" +search+ "%' OR lname LIKE '" +search+ "%' OR email LIKE '" +search+ "%' OR grade LIKE '"+search+ "%'";
            System.out.println(query);
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getArtStudents(int grade) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `al_student` WHERE grade = " +grade+ " AND class LIKE 'A%'";
            System.out.println(query);
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getMathsStudents(int grade) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `al_student` WHERE grade = " +grade+ " AND class LIKE 'M%'";
            System.out.println(query);
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getScienceStudents(int grade) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `al_student` WHERE grade = " +grade+ " AND class LIKE 'B%'";
            System.out.println(query);
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getCommerceStudents(int grade) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `al_student` WHERE grade = " +grade+ " AND class LIKE 'C%'";
            System.out.println(query);
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getTechStudents(int grade) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT * FROM `al_student` WHERE grade = " +grade+ " AND class LIKE 'T%'";
            System.out.println(query);
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getSectionStudents(int grade, String section) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            if (section.equalsIgnoreCase("SE004"))
                result = getArtStudents(grade);
            else if (section.equalsIgnoreCase("SE005"))
                result = getMathsStudents(grade);
            else if (section.equalsIgnoreCase("SE006"))
                result = getScienceStudents(grade);
            else if (section.equalsIgnoreCase("SE007"))
                result = getCommerceStudents(grade);
            else if (section.equalsIgnoreCase("SE008"))
                result = getTechStudents(grade);
            
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getSubjectStudentsForClass(int grade, String Class, String sub_code, String exam) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            if (grade >= 12 && grade <= 13) {
                query = "SELECT ast.student_ID, ast.fname, ast.lname " + 
                        " FROM al_student ast, al_student_subject ass " + 
                        " WHERE ast.student_ID = ass.student_ID AND ass.sub_code = '" +sub_code+ "' AND ast.grade = " +grade+ " AND ast.class = '" +Class+ "' AND ast.student_ID NOT IN " + 
                        " (SELECT student_ID FROM al_subject_exam_student WHERE subject_ID = '" +sub_code+ "' AND exam_ID = '" +exam+ "')";
            }
            else {
                query = "SELECT s.student_ID, s.fname, s.lname " + 
                        " FROM student s, student_subject ss " + 
                        " WHERE s.student_ID = ss.student_ID AND ss.sub_code = '" +sub_code+"' AND s.grade = " +grade+ " AND s.class = '" +Class+ "' AND s.student_ID NOT IN " + 
                        "(SELECT student_ID FROM subject_exam_student WHERE subject_ID = '" +sub_code+ "' AND exam_ID = '" +exam+ "')";
            }
            
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getLimitedStudents(int grade, String Class) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "";
            System.out.println(query);
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getStudentsWithNoBucketSubjects(int grade, String Class) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT student_ID, fname, lname " + 
                    " FROM student WHERE grade = " +grade+ " AND class = '" +Class+ "' AND student_ID NOT IN " + 
                    " (SELECT s.student_ID FROM student s, student_subject ss, bucket_subjects bs " + 
                    " WHERE s.student_ID = ss.student_ID AND ss.sub_code = bs.sub_code AND s.grade = " +grade+ " AND s.class = '" +Class+ "')";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getALStudentsWithNoBucketSubjects(int grade, String Class) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT student_ID, fname, lname " + 
                    "FROM al_student " + 
                    "WHERE grade = " +grade+ " AND class = '" +Class+ "' AND student_ID NOT IN " + 
                    " (SELECT ass.student_ID FROM al_student ast, al_student_subject ass, al_bucket_subjects abs " + 
                    " WHERE ass.sub_code = abs.sub_code AND ast.student_ID = ass.student_ID AND ast.grade = " +grade+ " AND ast.class = '" +Class+ "')";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getSubjectStudentsForclass(int grade, String Class, String sub_code) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT ast.student_ID, ast.fname, ast.lname " + 
                    " FROM al_student_subject ass, al_student ast " + 
                    " WHERE ast.student_ID = ass.student_ID AND ast.grade = " +grade+ " AND ast.class = '" +Class+ "' AND ass.sub_code = '" +sub_code+ "'";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getStudentsWithOneBucketSubject(String bucket_subject1, String bucket_subject2, String bucket_subject3, int grade, String Class) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            query = "SELECT ast.student_ID, ast.fname, ast.lname " + 
                    " FROM al_student_subject ass, al_student ast " + 
                    " WHERE ass.student_ID = ast.student_ID AND ast.grade = " +grade+ " AND ast.class = '" +Class+ "' AND sub_code = '" +bucket_subject1+ "'" + 
                    " AND ast.student_ID NOT IN (SELECT student_ID FROM al_student_subject WHERE sub_code = '" +bucket_subject2+ "') AND ast.student_ID NOT IN " + 
                    "(SELECT student_ID FROM al_student_subject WHERE sub_code = '" +bucket_subject3+ "')";
            result = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getClassStudents(int grade, String Class, String type) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            if (type.equalsIgnoreCase("regular"))
               query = "SELECT * FROM student s WHERE s.grade = " +grade+ " AND s.class = '" +Class+ "'";
            else if (type.equalsIgnoreCase("a/l"))
                query = "SELECT * FROM al_student s WHERE s.grade = " +grade+ " AND s.class = '" +Class+ "'";
            
            result = st.executeQuery(query);
            
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
    
    public static ResultSet getMyExamMarks(int grade, String exam, String student) {
        String query = null;
        ResultSet result = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            
            if (grade >= 12 && grade <= 13) {
                query = "SELECT s.sub_code, s.sub_name, ses.marks, ses.grade_points " + 
                        "FROM al_subject_exam_student ses, al_subject s " + 
                        "WHERE ses.subject_ID = s.sub_code AND ses.student_ID = '" +student+ "' AND ses.exam_ID = '" +exam+ "'";
            }
            else {
                query = "SELECT s.sub_code, s.sub_name, ses.marks, ses.grade_points " + 
                        "FROM subject_exam_student ses, subject s " + 
                        "WHERE ses.subject_ID = s.sub_code AND ses.student_ID = '" +student+ "' AND ses.exam_ID = '" +exam+ "'";
            }
            System.out.println(query);
            result = st.executeQuery(query);
            
        } catch (SQLException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            return result;
        }
    }
}
