<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
      <script type="text/javascript" src="<c:url value="/resources/js/loader.js"/>"></script>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Itens', 'Quantidade pelo total'],
          ['Publicados', ${infoItem.itemPublicado}],
          ['Não Publicados', ${infoItem.itemNaoPublicado}],
          ['Trocado',  ${infoItem.itemTrocado}],
          ['Em Avaliação', ${infoItem.itemEmAvaliacao}]          
        ]);

        var options = {
          title: 'Itens do Sistema - Total = '+${infoItem.itemTotal},          
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        chart.draw(data, options);
      }
    </script>
  </head>
  <body>
    <div id="piechart_3d" style="width: 900px; height: 500px;"></div>
  </body>
</html>