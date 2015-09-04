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



<header>
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
 </header>
 <section>
 <div class="container">
	 <div class="row">
		 <div class="col-md-7">
			 <div class="panel panel-sucess">
			   <div class="panel-heading"><h4>list of common questions</h4></div>
			   <div class="panel-body">
					 <div class="panel-group" id="accordion">
					   <div class="panel panel-default">
					     <div class="panel-heading">
					       <h4 class="panel-title">
									 Why is my event listed as "not on sale"?
					         <a data-toggle="collapse" data-parent="#accordion" href="#collapse1">
					         <i class="fa fa-caret-square-o-down fa-lg"></i></a>
					       </h4>
					     </div>
					     <div id="collapse1" class="panel-collapse collapse">
					       <div class="panel-body"><ul>
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
					   <div class="panel panel-default">
					     <div class="panel-heading">
					       <h4 class="panel-title">
					         <a data-toggle="collapse" data-parent="#accordion" href="#collapse2">
					         Collapsible Group 2</a>
					       </h4>
					     </div>
					     <div id="collapse2" class="panel-collapse collapse">
					       <div class="panel-body">Lorem ipsum dolor sit amet, consectetur adipisicing elit,
					       sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
					       minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
					       commodo consequat.</div>
					     </div>
					   </div>
					   <div class="panel panel-default">
					     <div class="panel-heading">
					       <h4 class="panel-title">
					         <a data-toggle="collapse" data-parent="#accordion" href="#collapse3">
					         Collapsible Group 3</a>
					       </h4>
					     </div>
					     <div id="collapse3" class="panel-collapse collapse">
					       <div class="panel-body">Lorem ipsum dolor sit amet, consectetur adipisicing elit,
					       sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
					       minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
					       commodo consequat.</div>
					     </div>
					   </div>
					 </div>
			   </div>
			 </div>


		 </div>
		 <div class="col-md-5">
			 <div class="panel panel-sucess">
				 <div class="panel-heading"><h4>still need help?</h4></div>
				 <div class="panel-body">
					 <table class="table table-striped">
<thead><strong>Business Hours</strong></thead>
	 <tbody>
		 <tr>
			 <td>Monday - Friday | 8:00AM - 5:00PM</td>

		 </tr>
		 <tr>
			 <td valign="middle"><i class="fa fa-envelope"></i> <A href="mailto:support@tix.com">support@tix.com</A> | <i class="fa fa-phone"></i> 800.504.4849 x 3</td>

		 </tr>
		 <tr>
			 <td><strong>Non-Business Hours Support</strong></td>

		 </tr>
		 <tr>
			  <td valign="middle"><i class="fa fa-envelope"></i> <A href="mailto:support@tix.com">support@tix.com</A> | <i class="fa fa-phone"></i> 800.504.4849 x 3</td>
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

</body>

</html>

<%


%>
