<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	<%@ page import="java.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Distributed Software Development</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.10/css/jquery.dataTables.min.css">

<style>
  body {
    padding-top: 50px;
  }
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="https://cdn.datatables.net/1.10.10/js/jquery.dataTables.min.js"></script>


<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script>
	function formSubmit() {
		document.getElementById("logoutForm").submit();
	}
	function profilePage() {
		document.getElementById("profilePage").submit();
	}
</script>
<script type="text/javascript">
$(document).ready(function () {
	if ($('.table'+' tr').length > 1) {
	    setTimeout(function () {
	        $('.table').dataTable({
	            "iDisplayLength": 10,
	            "pagingType": "full_numbers",
	            "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
	            "oLanguage": {
	                "sLengthMenu": "_MENU_ records per page"
	            },
	            "bDestroy": true
	
	        });
	    }, 1);
	}

});
      // Load the Visualization API and the piechart package.
      google.load('visualization', '1.0', {'packages':['corechart']});
     
      google.setOnLoadCallback(drawChart);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function drawChart(userDetails) {

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Name');
        data.addColumn('number', 'Commits');
        <c:forEach items="${userDetails}" var="user">
        		data.addRow(['<c:out value="${user.userName}"/>', <c:out value="${user.commitsMade}"/>])
		</c:forEach>

        // Set chart options
        var options = {'title':'Number of commits made',
                       'width':400,
                       'height':300,
                       is3D: true};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>

</head> 
<body id="body">
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container-fluid">
			 <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand page-scroll" href="javascript:profilePage()">DSD TeamTitans</a>
            </div>
            
            <!-- Panel options -->
            <div class="collapse navbar-collapse" id="">
            	<ul class="nav navbar-nav">
					<li>
						<a class="page-scroll" href="#userstats">User Statistics</a>
					</li>
					<li>
						<a class="page-scroll" href="#filestats">File Statistics</a>
					</li>
					<li>
						<a class="page-scroll" href="#buildstats">Code Statistics</a>
					</li>											
				</ul>
				<ul class="nav navbar-nav navbar-right">					
					<c:url value="/logout" var="logoutUrl" />
					<c:if test="${pageContext.request.userPrincipal.name != null}">
						<li><a class="page-scroll" href="#body" >Welcome : ${pageContext.request.userPrincipal.name}</a></li>
					</c:if>
					<li> <a href="javascript:formSubmit()"> Logout</a></li>											
				</ul>
            </div>			
		</div>
	</nav>
	<!-- Logout -->
	<form action="${logoutUrl}" method="post" id="logoutForm">
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
	</form>
	<form action="profile" method="GET" id="profilePage">
	</form>
	
            	<div class="col-md-2 col-md-offset-4" id="chart_div"></div>
	<!-- User Stats Panel -->
	<section  id="userstats" style ='background-color: #FFFFFF'>
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-6 text-center">
                    <h3 class="section-heading text-center">User Statistics</h3>
                    <hr class="light">                                        
                    <table class="table table-hover" id="usertable">
				    	<thead>
					      <tr>
					        <th>User Name</th>
					        <th>Number of Commits</th>
					        <th>Last Active</th>
					      </tr>
					    </thead>					    
					    <tbody>
					    	<c:forEach var="userDetail" items="${userDetails}">
						    	<tr>
							        <td>${userDetail.userName}</td>
							        <td>${userDetail.commitsMade}</td>
							        <td>${userDetail.startDate}</td>					        
						      	</tr>
					      	</c:forEach>					      	
					    </tbody>					      
				  	</table>
				</div>
            </div>
        </div>
    </section>
    <!-- File Stats Panel -->
    <section  id="filestats" style ='background-color: #EFFBFB'>
        <div class="container">
            <div class="row">
            	<div class="col-lg-12 col-md-6 text-center"> 
            		<h3 class="section-heading text-center">File statistics</h3>
            	</div>
                <div class="col-lg-12 ">                    
                    <hr class="light">
		                    
				    <table class="table table-hover" id="buildtable">
				    	<thead>
					      <tr>
					        <th>File Path</th>
					        <th>File Name</th>
					        <th>Created Date</th>
					        <th>Total Commits</th>
					        <th>Last Committed By</th>					        
					      </tr>
					    </thead>					    
					    <tbody>
					    	<c:forEach var="fileDetail" items="${fileDetails}">
						    	<tr>					    	
							        <td>${fileDetail.filePath}</td>
							        <td>${fileDetail.fileName}</td>
							        <td>${fileDetail.createdDate}</td>
							        <td>${fileDetail.commits}</td>
							        <td>${fileDetail.lastCommittedBy}</td>				        
						      	</tr>	
					      	</c:forEach>					      	
					    </tbody>					      
			  		</table>                   
                 </div> 
			</div>
        </div>
    </section>
    <!-- Code Stats Panel -->
    <section  id="buildstats" style ='background-color: #FFFFFF;'>
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-6 text-center">
                    <h3 class="section-heading text-center">Code Statistics</h3>
                    <hr class="light">                    
                    <table class="table table-hover" id="buildtable">
				    	<thead>
					      <tr>
					        <th>Build Number</th>
					        <th>Build Time</th>
					        <th>Triggered By</th>
					        <th>Time Taken</th>
					        <th>Compilation Errors</th>
					        <th>Build Status</th>					        
					      </tr>
					    </thead>					    
					    <tbody>
					    	<c:forEach var="codeStat" items="${codeStats}">
						    	<tr>					    	
							        <td>${codeStat.buildNumber}</td>
							        <td>${codeStat.buildDate}</td>
							        <td>${codeStat.triggeredBy}</td>
							        <td>${codeStat.timeTaken}</td>
							        <td>${codeStat.compilationErrors}</td>
							        <td>${codeStat.buildStatus}</td>					        
						      	</tr>	
					      	</c:forEach>					      	
					    </tbody>					      
				  	</table>
				</div>
            </div>
        </div>
    </section>	
</body>
</html>
<html>