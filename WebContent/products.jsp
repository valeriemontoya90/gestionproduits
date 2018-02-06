<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<header class="navbar navbar-expand-lg navbar-dark bg-primary">
		<a class="navbar-brand mr-0 mr-md-2" href="/" aria-label="Bootstrap">
			<svg class="d-block" width="36" height="36" viewBox="0 0 612 612"
				xmlns="http://www.w3.org/2000/svg" focusable="false">
			<title>Bootstrap</title>
			<path fill="currentColor"
				d="M510 8a94.3 94.3 0 0 1 94 94v408a94.3 94.3 0 0 1-94 94H102a94.3 94.3 0 0 1-94-94V102a94.3 94.3 0 0 1 94-94h408m0-8H102C45.9 0 0 45.9 0 102v408c0 56.1 45.9 102 102 102h408c56.1 0 102-45.9 102-102V102C612 45.9 566.1 0 510 0z"></path>
			<path fill="currentColor"
				d="M196.77 471.5V154.43h124.15c54.27 0 91 31.64 91 79.1 0 33-24.17 63.72-54.71 69.21v1.76c43.07 5.49 70.75 35.82 70.75 78 0 55.81-40 89-107.45 89zm39.55-180.4h63.28c46.8 0 72.29-18.68 72.29-53 0-31.42-21.53-48.78-60-48.78h-75.57zm78.22 145.46c47.68 0 72.73-19.34 72.73-56s-25.93-55.37-76.46-55.37h-74.49v111.4z"></path></svg>
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarColor02" aria-controls="navbarColor02"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarColor02">
			<span style="color: white;">Bonjour ${sessionScope.login} - </span>
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link"
					href="index?action=products">Produits</a></li>
				<li class="nav-item"><a class="nav-link"
					href="index?action=users">Utilisateurs</a></li>
				<li></li>
			</ul>
			Vous êtes connecté en tant que
			<c:if test="${sessionScope.role == 'ADMIN'}">
			ADMIN
			</c:if>
			<c:if test="${sessionScope.role == 'USER'}">
			USER
			</c:if>
			<form class="form-inline" style="margin-left: 20px;">
				<a href="login?action=logout"><button
						class="btn btn-outline-light my-2 my-sm-0" type="button">Déconnexion</button></a>
			</form>
		</div>
	</header>
	<div class="container">
		<div class="card">
			<div class="card-header">Liste des produits</div>
			<div class="card-body">
				<table class="table table-bordered table-hover">
					<thead>
						<tr>
							<th scope="col">Identifiant</th>
							<th scope="col">Nom</th>
							<th scope="col">Prix</th>
							<th scope="col">Stock</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${liste}" var="item">
							<tr>
								<th scope="col">${item.id}</th>
								<td>${item.nom}</td>
								<td>${item.prix}</td>
								<td>${item.stock}</td>
								<c:if test="${sessionScope.role == 'ADMIN'}">
									<td>
										<button type="button" class="btn btn-info">
											<span class="fas fa-edit"></span>
										</button> <a href="products?action=del&id=${item.id}"><button
												type="button" class="btn btn-danger" aria-label="Close">
												<span class="fa fa-trash-alt" aria-hidden="true"></span>
											</button></a>
									</td>
								</c:if>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<c:if test="${sessionScope.role == 'ADMIN'}">
			<button id="btnAdd" type="button" class="btn-primary rounded-circle"
				role="button">
				<span class="fa fa-plus" aria-hidden="true"></span>
			</button>
		</c:if>
		<div id="cardEdit" class="card">
			<div class="card-header">Edition d'un produit</div>
			<form method="post">
				<div class="form-group">
					<label for="identifiant"><strong>Identifiant :</strong></label> <input
						type="number" class="form-control" id="identifiant"
						name="identifiant" placeholder="Identifiant" />
				</div>
				<div class="form-group">
					<label for="nom"><strong>Nom :</strong></label> <input type="text"
						class="form-control" id="nom" name="nom" placeholder="Nom" />
				</div>
				<div class="form-group">
					<label for="prix"><strong>Prix :</strong></label> <input
						type="number" step="0.01" class="form-control" id="prix"
						name="prix" placeholder="Prix" />
				</div>
				<div class="form-group">
					<label for=""stock""><strong>Stock :</strong></label> <input
						type="number" class="form-control" id="stock" name="stock"
						placeholder="Stock" />
				</div>
				<input id="btnValidate" type="submit" value="Ajouter"
					name="addProduct" /> <input id="btnEdit" type="submit"
					value="Editer" name="editProduct" /> <input id="btnReset"
					type="button" value="Reset" />
			</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	<script src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
	<script src="script.js"></script>
</body>
</html>