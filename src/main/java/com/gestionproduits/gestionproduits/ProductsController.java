package com.gestionproduits.gestionproduits;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ecommerce.Application;
import ecommerce.model.Produit;

/**
 * Servlet implementation class ProduitController
 */
@WebServlet("/products")
public class ProductsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	List<Produit> products = new ArrayList<>();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductsController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		products = Application.getInstance().getProduitDao().findAll();
		request.setAttribute("liste", products);
		System.out.println(products);

		if (request.getParameter("action") != null && request.getParameter("action").equals("del")) {
			Produit p = Application.getInstance().getProduitDao().find(Long.parseLong(request.getParameter("id")));
			Application.getInstance().getProduitDao().delete(p);
			response.sendRedirect("products");
		} else if (request.getParameter("action") != null && request.getParameter("action").equals("edit")) {
			response.sendRedirect("products");
		} else {
			request.getRequestDispatcher("products.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (request.getParameter("addProduct") != null) {
			Produit p = new Produit();
			p.setNom(request.getParameter("nom"));
			p.setPrix(Double.parseDouble(request.getParameter("prix")));
			p.setStock(Integer.parseInt(request.getParameter("stock")));
			Application.getInstance().getProduitDao().create(p);
			response.sendRedirect("products");
		}
		if (request.getParameter("editProduct") != null) {
			System.out.println("Identifiant" + request.getParameter("identifiant"));
			Produit p = Application.getInstance().getProduitDao()
					.find(Long.parseLong(request.getParameter("identifiant")));
			p.setNom(request.getParameter("nom"));
			p.setPrix(Double.parseDouble(request.getParameter("prix")));
			p.setStock(Integer.parseInt(request.getParameter("stock")));
			Application.getInstance().getProduitDao().update(p);
			response.sendRedirect("products");
		}
	}

}
