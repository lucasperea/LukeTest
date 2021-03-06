<!-- #INCLUDE VIRTUAL=GlobalInclude.asp-->
<!-- #INCLUDE VIRTUAL=DBOpenInclude.asp-->

<%

'-----------------------------------------------

ServerName = Request.ServerVariables ("SERVER_NAME")

If ServerName <> "localhost" Then

	Page = "Management"

	Session.Timeout = 60
	Server.ScriptTimeout = 3600

	'Verify OrganizationNumber
	If Session("OrganizationNumber") = "" Or IsNull(Session("OrganizationNumber")) Then
		OBJdbConnection.Close
		Set OBJdbConnection = nothing
		Response.Redirect("/Management/Default.asp")
	End If

	'Verify User
	If Session("UserNumber") = "" Or IsNull(Session("UserNumber")) Then
		OBJdbConnection.Close
		Set OBJdbConnection = nothing
		Response.Redirect("/Management/Default.asp")
	End If


End If

DIM rootFolder
rootFolder = fnRootFolder

'-----------------------------------------------

%>

<!DOCTYPE html>

<html lang="en">

<head>

	<title>Title</title>

	<!-- Force IE to turn off past version compatibility mode and use current version mode -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1">

	<!-- Get the width of the users display-->
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<!-- Text encoded as UTF-8 -->
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=9" /><link rel="SHORTCUT ICON" href="/Images/FavIcon.ico" /><link href="/css/bootstrap.css" rel="stylesheet" /><link href="/css/bootstrap-tix.css" rel="stylesheet" /><link href="/Javascript/Jquery-ui/themes/Tix/jquery-ui-1.9.0.custom.css" rel="stylesheet" type="text/css" /><link href="/Javascript/ClueTip/jquery.cluetip.css" rel="stylesheet" type="text/css" /><link href="/Clients/Tix/css/dcmegamenu.css" rel="stylesheet" type="text/css" /><link href="/Clients/Tix/css/skins/tix.css" rel="stylesheet" type="text/css" /><link href="/Clients/TixAdmin/css/AdminCommon.css" type="text/css" rel="stylesheet" /><link href="/css/Tooltip.css" rel="stylesheet" type="text/css" media="screen" />

	<script type="text/javascript" src="https://www.tix.com/clients/tixnew/plugins/jquery.min.js"></script>
	<script type="text/javascript" src="https://www.tix.com/Clients/TixNew/js/angular.min.js"></script>
	<script type="text/javascript" src="https://www.tix.com/clients/tixnew/bootstrap/js/bootstrap.min.js"></script>

	<!-- Web Fonts -->
	<link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,400,700,300&amp;subset=latin,latin-ext" rel="stylesheet" type="text/css" /><link href="http://fonts.googleapis.com/css?family=PT+Serif" rel="stylesheet" type="text/css" />

	<!-- Icon Font -->
	<link href="https://www.tix.com/clients/tixnew/fonts/font-awesome/css/font-awesome.css" rel="stylesheet" />

	<!-- Event Icon Font -->
	<link href="https://www.tix.com/clients/tixnew/fonts/event-icons/css/event-icons.css" rel="stylesheet" />

	<!-- Bootstrap core CSS -->
	<link href="https://www.tix.com/clients/tixnew/bootstrap/css/bootstrap.css" rel="stylesheet" />


<!--Fonts-->
<link href='https://fonts.googleapis.com/css?family=Fira+Sans:400,500' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<style>
.container
{max-width: 900px;}

.panel-heading
{background-color:#008400; color: #fff;}
.panel-info
{border: #008400;}

.form-control
{height: 56px; border-radius:0;}
</style>
</head>

<body>



	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="css/style.css">
	<!--Auto Address-->
	<body>


				<header>
					<!-- #INCLUDE VIRTUAL="TopNavInclude.asp" -->
				</header>


	<section>
	<div class="container">
	 <div class="row">
		 <div class="col-md-12"><div class="jumbotron">
			 <h1><Strong>Need help?</Strong></h1>

			 <div class="input-group">
			      <input type="text" class="form-control" placeholder="Search the knowledge base">
			      <span class="input-group-btn">
			        <button class="btn btn-success" type="button"><i class="fa fa-search fa-3x"></i></button>
			      </span>
			    </div>

	</div>
	 </div>
	 </div>
	 </div>


	 <div class="container">
		 <div class="row">
			 <div class="col-md-7">
				 <div class="panel panel-default">
				   <div class="panel-heading"><h4>list of common questions</h4></div>
				   <div class="panel-body">
						 <div class="panel-group" id="accordion">
						   <div class="panel panel-info">
						     <div class="panel-heading">
						       <h4 class="panel-title">
										<strong>Why is my event listed as "not on sale"?</strong>
						      <span class="pull-right">   <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">
						         <i class="fa fa-caret-square-o-down fa-lg"></i></a></span>
						       </h4>
						     </div>
						     <div id="collapse1" class="panel-collapse collapse">
						       <div class="panel-body">
										 There is a good chance the Public Sale Start Date/Time or the Public Sale End Date/Time date has passed. Below are instructions to fix the issue.<BR><BR><ul>
	<li>Select Management Menu&gt;&gt;Operations&gt;&gt;Event Management</li>
	<li>Click on the title of the event you want to modify</li>
	<li>Scroll to the bottom of the Event Information page and click the Modify Event button</li>
	<li>Modify the Public Sale Start Date/Time field as desired</li>
	<li>Scroll to the bottom of the page and click the Continue button</li>
	<li>Scroll to the bottom of the Pricing Page and click the Continue button</li>
	<li>Click the Apply Changes button to save the modifications</li>
	</ul><br><em>*Events will go on-sale on the private label ticket sales page once the event has been <a href="https://www.tix.com/management/knowledgebasesearch.aspx?articleid=3" target="_blank">activated</a> and the Public Sale Start Date/Time has been reached</em></div>
						     </div>
						   </div>
						   <div class="panel panel-info">
								 <div class="panel-heading">
									 <h4 class="panel-title">
										<strong> How do I setup my thermal ticket printer?</strong>
									<span class="pull-right">   <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">
										 <i class="fa fa-caret-square-o-down fa-lg"></i></a></span>
									 </h4>
								 </div>
						     <div id="collapse2" class="panel-collapse collapse">
						       <div class="panel-body">
					<table class="table table-striped">
					<thead><STRONG>Friendly Ghost Language(FGL)</STRONG></thead>
	<td><a href="https://www.tix.com/management/knowledgebasesearch.aspx?articleid=70" target="_blank">Windows 8</a> </td>
	<td><a href="https://www.tix.com/management/knowledgebasesearch.aspx?articleid=68" target="_blank">Windows 7</a></td>
	<td><a href="https://www.tix.com/management/knowledgebasesearch.aspx?articleid=69" target="_blank">Windows XP</a></td>
	</table>
	<table class="table table-striped">
	<thead><STRONG>PCL / HTML</STRONG></thead>
	<td>If you printer is set to PCL/HTML mode, no additional installation instructions are needed.</td>
	</table>
				</div>
						     </div>
						   </div>
							 <div class="panel panel-info">
								 <div class="panel-heading">
									 <h4 class="panel-title">
										<strong>How can I modify my Production?</strong>
									<span class="pull-right">   <a data-toggle="collapse" data-parent="#accordion" href="#collapse3">
										 <i class="fa fa-caret-square-o-down fa-lg"></i></a></span>
									 </h4>
								 </div>
								 <div id="collapse3" class="panel-collapse collapse">
									 <div class="panel-body">
										 	<ul>
										 <li>Select Management Menu>>Operations>>Production Management</li>

	    <li>Click on the production that you want to modify from the list of productions*</li>
	    <li>Hover over the gears in the upper right corner</li>
	    <li>Click the Modify button Make the desired changes to the production information</li>
	    <li>Click the Update button to save the updated production information </li></ul>

	*If the production you are looking for is not listed, use the Show List From dropdown box and select ALL</div>
								 </div>
							 </div>
						 </div>
				   </div>
				 </div>


			 </div>
			 <div class="col-md-5">
				 <div class="panel panel-default">
					 <div class="panel-heading"><h4>still need help?</h4></div>
					 <div class="panel-body">
						 <table class="table table-striped">

		 <tbody>
			 <tr>
				 <td><strong>Business Hours</strong> </td>

			 </tr>
			 <tr>
				 <td>Monday - Friday | 8:00AM - 5:00PM</td>

			 </tr>
			 <tr>
				 <td valign="middle" align="center"><i class="fa fa-envelope"></i> <A href="mailto:support@tix.com">support@tix.com</A> | <i class="fa fa-phone"></i> 800.504.4849 x 3</td>

			 </tr>
			 <tr>
				 <td><strong>Non-Business Hours Support</strong></td>

			 </tr>
			 <tr>
				  <td valign="middle" align="center"><i class="fa fa-envelope"></i> <A href="mailto:support@tix.com">support@tix.com</A> | <i class="fa fa-phone"></i> 800.504.4849 x 3</td>
				</tr>

		 </tbody>
		</table>
					 </div>
				 </div>

		 </div>
	 </div>
	 </div>
	 </section>
	<!-- Latest compiled and minified JavaScript -->
	<footer>
		<!-- #INCLUDE VIRTUAL="FooterInclude.asp" -->
	</footer>
</body>

</html>

<%


%>
