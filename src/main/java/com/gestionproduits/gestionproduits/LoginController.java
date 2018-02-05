package com.gestionproduits.gestionproduits;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ecommerce.Application;
import ecommerce.model.Login;
import ecommerce.model.Role;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public LoginController() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
//		Login logUser = new Login();
//		logUser.setLogin("val");
//		logUser.setMotDePasse("val");
//		logUser.setRole(Role.USER);
//		Application.getInstance().getLoginDao().create(logUser);
//
//		Login logAdmin= new Login();
//		logAdmin.setLogin("oliv");
//		logAdmin.setMotDePasse("oliv");
//		logAdmin.setRole(Role.ADMIN);
//		Application.getInstance().getLoginDao().create(logAdmin);
		
		String action = request.getParameter("action");
		
		if (action != null && action.equals("logout")) {
			request.getSession().invalidate();
			response.sendRedirect("login");
		} 
		else {
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String login = request.getParameter("login");
		String pass = request.getParameter("password");
		
		if(Application.getInstance().getLoginDao().checkLogin(login, pass) != null) {
			Login log = Application.getInstance().getLoginDao().checkLogin(login, pass);
			request.getSession().setAttribute("login", log.getLogin());
			request.getSession().setAttribute("password", log.getMotDePasse());
			request.getSession().setAttribute("role", log.getRole());
			System.out.println("ROLEEEEEEEEE == "+request.getSession().getAttribute("role"));
			response.sendRedirect("index?action=products");
		} else {
			request.setAttribute("error", "Identifiants incorrects");
			request.getRequestDispatcher("login.jsp").forward(request, response);	
		}
	}

}
