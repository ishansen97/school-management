/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package login;
import java.sql.*;
import dbconnection.DBConnection;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author DELL
 */
public class LoginValidation {
    private String userType, username, password;

    public LoginValidation(String userType, String username, String password) {
        this.userType = userType;
        this.username = username;
        this.password = password;
    }
    
    public String isAvailable() {
        String query = null;
        ResultSet result = null;
        ResultSet result1 = null;
        try {
            DBConnection dbconnect = DBConnection.getInstance();
            Connection con = dbconnect.getCon();
            Statement st = con.createStatement();
            Statement st1 = con.createStatement();
            
            if (userType.equalsIgnoreCase("student")) {
                query = "SELECT * FROM student WHERE username = '" +this.username+ "' AND password = '" +this.password+ "'";
                result = st.executeQuery(query);
                
                if (result.next()) {
                    return "regular";
                }
                else {
                    query = "SELECT * FROM al_student WHERE username = '" +this.username+ "' AND password = '" +this.password+ "'";
                    result1 = st1.executeQuery(query);
                    
                    if (result1.next()) 
                        return "a/l";
                    else
                        return "not found";
                }
            }
            else if (userType.equalsIgnoreCase("teacher")) {
                query = "SELECT * FROM teacher WHERE username = '" +this.username+ "' AND password = '" +this.password+ "'";
                result = st.executeQuery(query);
                
                if (result.next()) 
                    return "teacher";
                else
                    return "not found";
            }
            else
                return "not found";
            
                
        } catch (SQLException ex) {
            Logger.getLogger(LoginValidation.class.getName()).log(Level.SEVERE, null, ex);
            return ex.getMessage();
        } catch (Exception ex) {
            Logger.getLogger(LoginValidation.class.getName()).log(Level.SEVERE, null, ex);
            return ex.getMessage();
        }
    }
}
