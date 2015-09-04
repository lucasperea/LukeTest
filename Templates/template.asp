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

</head>

	<body class="container">

		<header>
			<!-- #INCLUDE VIRTUAL="TopNavInclude.asp" -->
		</header>
		
		<section>	
		

			
		</section>
			
		<footer>
			<!-- #INCLUDE VIRTUAL="FooterInclude.asp" -->	
		</footer>

	</body>
		
</html>

<%


%>


