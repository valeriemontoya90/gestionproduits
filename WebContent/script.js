$(document).ready(function() {
  var trSelected = "";

  $("#cardEdit").hide();
  $("#btnEdit").hide();
  $("#btnValidate").show();
  
  $("#btnReset").bind("click", clearInputs);
  $("td button:first-child").bind("click", setInputs);
  $("td button:last-child").bind("click", remove);
  
  function clearInputs() {
	$("#identifiant").val("");
	$("#nom").val("");
	$("#prix").val("");
	$("#stock").val("");
  }
  
  function setInputs() {
    trSelected = $(this).parent().parent();
    var tr = trSelected;
    var nom = tr.find('td').eq(0).text();
    var prenom = tr.find('td').eq(1).text();
    
    $("#identifiant").val(tr.find('th').eq(0).text());
    $("#nom").val(tr.find('td').eq(0).text());
    $("#prix").val(tr.find('td').eq(1).text());
    $("#stock").val(tr.find('td').eq(2).text());
	$("#cardEdit .card-header").text("Edition de "+nom+" "+prenom);
    
    $("#cardEdit").show();
    $("#btnValidate").toggle();
    $("#btnEdit").toggle();
  }
  
  function remove() {
    trSelected = $(this).parent().parent();
    trSelected.remove();
  }
  
  $("#btnAdd").bind("click", function() {
    $("#cardEdit").show();
	$("#cardEdit .card-header").text("Ajout d'un nouveau produit");
    $("#btnEdit").hide();
    $("#btnValidate").show();
  });

  $("#btnEdit").bind("click", function() {
    var tr = trSelected;
    validEdit(tr);
  });
  
  $("#btnValidate").bind("click", function() {
    var tr = $("<tr/>").appendTo($("tbody"));
    createNewLine(tr);
  });
  
  function createNewLine(tr) {    
	tr.html(
      $("<th scope=\"row\"></th>").append($("#identifiant").val())
    );
    $("<td/>").append($("#nom").val()).appendTo(tr);
    $("<td/>").append($("#prix").val()).appendTo(tr);
    $("<td/>").append($("#stock").val()).appendTo(tr);
    
    var td = $("<td/>").appendTo(tr);
    ($("<button/>").append($("<span class=\"fas fa-edit\"></span>")).addClass("btn btn-info").bind("click", setInputs)).appendTo(td);
    ($("<button/>").append($("<span class=\"fa fa-trash-alt\" aria-hidden=\"true\"></span>")).addClass("btn btn-danger").bind("click", remove)).appendTo(td);
  }
  
  function validEdit(tr) {
    var tr = trSelected;
    tr.find('th').eq(0).text($("#identifiant").val());
    tr.find('td').eq(0).text($("#nom").val());
    tr.find('td').eq(1).text($("#prix").val());
    tr.find('td').eq(2).text($("#stock").val());
  }
});