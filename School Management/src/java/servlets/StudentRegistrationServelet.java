/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import student.Student;
import grades.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author DELL
 */
@WebServlet(name = "StudentRegistrationServelet", urlPatterns = {"/StudentRegistrationServelet"})
public class StudentRegistrationServelet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet StudentRegistrationServelet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StudentRegistrationServelet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
            
            String Class = null;
            String section = null;
            int grade = 0;
            
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            grade = Integer.parseInt(request.getParameter("grade"));
            int age = Integer.parseInt(request.getParameter("age"));
            String gender = request.getParameter("gender");
            String address = request.getParameter("address");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            out.println("Grade : " + grade);
            out.println(request.getParameter("cla1"));
            out.println(request.getParameter("cla2"));
            
            if (grade >= 12 && grade <= 13)
                section = request.getParameter("section");
            
            
            if (section != null) {
                if (section.equals("SE004")) {
                    Class = request.getParameter("art");
                }
                else if (section.equals("SE005")) {
                    Class = request.getParameter("maths");
                }
                else if (section.equals("SE006")) {
                    Class = request.getParameter("science");
                }
                else if (section.equals("SE007")) {
                    Class = request.getParameter("commerce");
                }
                else if (section.equals("SE008")) {
                    Class = request.getParameter("tech");
                }
            }
            else {
                if (grade >= 1 && grade < 10) {
                    out.println("Class 1 is empty");
                    Class = request.getParameter("cla1");
                }
                else if (grade >= 10 && grade <= 11) {
                    out.println("Class 2 is empty");
                    Class = request.getParameter("cla2");
                }
            }
            

            
            
            
            out.println("Class is : " + Class);
            
            Student student = new Student(fname,lname,age,gender,grade,Class,address,email,username,password);
            
            if (student.registerStudent()) {
                response.sendRedirect(request.getContextPath() + "/Admin/admin_profile.jsp");
            }
            else {
                out.println("unsuccessfully registered");
            }
            
            
            
            
        } 
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
