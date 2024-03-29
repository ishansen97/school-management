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
import javax.servlet.http.HttpSession;
import login.LoginValidation;
import student.*;
import teacher.*;

/**
 *
 * @author DELL
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

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
            out.println("<title>Servlet LoginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
            
            String userType = request.getParameter("userType");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            LoginValidation login = new LoginValidation(userType, username, password);
            String result = login.isAvailable();
            HttpSession session = null;
            out.println(result);
            
            
            Student loggedStudent = null;

            if (result.equalsIgnoreCase("regular")) {
                session = request.getSession();
                loggedStudent = Student.getStudent(username, password);
                session.setAttribute("student", loggedStudent);
                response.sendRedirect(request.getContextPath() + "/Registration/Profile.jsp");
            }
            else if (result.equalsIgnoreCase("a/l")) {
                session = request.getSession();
                loggedStudent = Student.getALStudent(username, password);
                session.setAttribute("student", loggedStudent);
                response.sendRedirect(request.getContextPath() + "/Registration/Profile.jsp");
            }
            else {
                out.println("This student is not found");
            }

            Teacher loggedTeacher = null;

            if (result.equalsIgnoreCase("teacher")) {
                session = request.getSession();
                loggedTeacher = Teacher.getTeacher(username, password);
                session.setAttribute("teacher", loggedTeacher);
                response.sendRedirect(request.getContextPath() + "/Registration/Profile.jsp");
            }
            else {
                out.println("This teacher is not found");
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
