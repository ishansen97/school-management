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
import exam.Exam;

/**
 *
 * @author Ishan
 */
@WebServlet(name = "ExamRecordSubmissionServlet", urlPatterns = {"/ExamRecordSubmissionServlet"})
public class ExamRecordSubmissionServlet extends HttpServlet {

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
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet ExamRecordSubmissionServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet ExamRecordSubmissionServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
            
            String student = request.getParameter("student");
            String exam = request.getParameter("exam");
            int total = Integer.parseInt(request.getParameter("total"));
            int grade = Integer.parseInt(request.getParameter("grade"));
            double average = Double.parseDouble(request.getParameter("average"));
            double gpa = Double.parseDouble(request.getParameter("gpa"));
            String class_grade = request.getParameter("class_grade");
            int rank = Integer.parseInt(request.getParameter("rank"));
            
            out.println("Student : " + student);
            out.println("Exam : " + exam);
            out.println("Total : " + total);
            out.println("Grade : " + grade);
            out.println("Average : " + average);
            out.println("GPA : " + gpa);
            out.println("class grade : " + class_grade);
            out.println("Rank : " + rank);
            
            String result = Exam.insertStudentExamRecords(student, exam, grade, average, gpa, total, rank, class_grade);
            
            out.println(result);
            
            
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
