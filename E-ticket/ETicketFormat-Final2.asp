<%

'CHANGE LOG
'LSP 08/28/05 - intial development

%>

<!--#INCLUDE virtual=GlobalInclude.asp -->
<!--#INCLUDE virtual="dbOpenInclude.asp"-->
<!--#INCLUDE VIRTUAL ="ETicketInclude.asp"-->

<%

OrderNumber = CleanNumeric(Request("OrderNumber"))
TicketNumber = Clean(Request("TicketNumber"))


'Find the OrderNumber for this Ticket.  Check using both OrderNumber and TicketNumber for added security.
Set cmd = server.createobject("ADODB.Command")

cmd.ActiveConnection = OBJdbConnection 'connection object already created
SQLOrderNum = "SELECT OrderNumber FROM Ticket (NOLOCK) WHERE OrderNumber = ? AND TicketNumber = ?"

cmd.CommandText = SQLOrderNum
set prmOrderNumber = cmd.CreateParameter("@OrderNumber", 3, 1, 4, CLng(OrderNumber))
cmd.Parameters.Append prmOrderNumber
set prmOrderNumber = cmd.CreateParameter("@TicketNumber", 200, 1, 24, TicketNumber)
cmd.Parameters.Append prmOrderNumber

Set rsOrderNum = cmd.Execute

If Not rsOrderNum.EOF Then

    If UCase(Clean(Request("PrintSub"))) <> "Y" Then 'Standard, Print Individual & Child tickets only
    	SQLTix = "SELECT OrderLine.ShipFirstName, OrderLine.ShipLastName, OrderLine.ShipAddress1, OrderLine.ShipAddress2, OrderLine.ShipCity, OrderLine.ShipState, OrderLine.ShipCountry, OrderLine.ShipPostalCode, OrderLine.Price, OrderLine.Discount AS LineDiscount, OrderLine.Price - OrderLine.Discount AS NetPrice, OrderLine.ItemType, OrderHeader.OrderNumber, OrderHeader.Subtotal, OrderHeader.ShipFee, OrderHeader.OrderSurcharge, OrderHeader.Total, OrderHeader.Discount AS OrderDiscount, OrderDate, OrderHeader.OrderTypeNumber, Customer.FirstName, Customer.LastName, Customer.Address1, Customer.Address2, Customer.City, Customer.State, Customer.Country, Customer.PostalCode, Seat.ItemNumber, Seat.Row, Seat.Seat, Section.SectionCode, Section.Section, Event.EventCode, Event.EventDate, Event.Phone AS EventPhoneNumber, Event.EMailAddress AS EventEMailAddress, Act.Act, Act.Actcode, Act.ShortAct, Act.Producer, Act.Comments AS ActComments, Event.Comments AS EventComments, Event.Map, Venue.Venue, Venue.Address_1 AS VenueAddress1, Venue.Address_2 AS VenueAddress2, Venue.City AS VenueCity, Venue.State AS VenueState, Venue.Zip_Code AS VenuePostalCode, SeatType.SeatType, Shipping.ShipType, OrderType, Organization.Organization, Ticket.TicketNumber, ETicketAdPath, ETicketMapPath, ETicketDrivingDirections, ETicketGeneralInfo, ETicketBackgroundPath, ETicketLogoPath, ETicketBottomBarPath, TicketText1, TicketText2, TicketText3 FROM OrderLine (NOLOCK) INNER JOIN OrderHeader (NOLOCK) ON OrderLine.OrderNumber = OrderHeader.OrderNumber INNER JOIN Customer (NOLOCK) ON OrderHeader.CustomerNumber = Customer.CustomerNumber INNER JOIN Seat (NOLOCK) ON OrderLine.ItemNumber = Seat.ItemNumber INNER JOIN Event (NOLOCK) ON Seat.EventCode = Event.EventCode INNER JOIN Act (NOLOCK) ON Event.ActCode = Act.ActCode INNER JOIN Venue (NOLOCK) ON Event.VenueCode = Venue.VenueCode INNER JOIN Shipping (NOLOCK) ON OrderLine.ShipCode = Shipping.ShipCode INNER JOIN SeatType (NOLOCK) ON OrderLine.SeatTypeCode = SeatType.SeatTypeCode INNER JOIN Section (NOLOCK) ON Seat.SectionCode = Section.SectionCode AND Seat.EventCode = Section.EventCode LEFT JOIN OrderType (NOLOCK) ON OrderHeader.OrderTypeNumber = OrderType.OrderTypeNumber INNER JOIN Ticket (NOLOCK) ON OrderLine.ItemNumber = Ticket.ItemNumber AND OrderLine.OrderNumber = Ticket.OrderNumber AND Ticket.StatusCode IN ('A', 'S') INNER JOIN OrganizationVenue (NOLOCK) ON Event.VenueCode = OrganizationVenue.VenueCode INNER JOIN Organization (NOLOCK) ON OrganizationVenue.OrganizationNumber = Organization.OrganizationNumber LEFT JOIN (SELECT EventCode, OptionValue AS ETicketAdPath FROM EventOptions (NOLOCK) WHERE OptionName = 'ETicketAd') AS ETicketAd ON Event.EventCode = ETicketAd.EventCode LEFT JOIN (SELECT EventCode, OptionValue AS ETicketMapPath FROM EventOptions (NOLOCK) WHERE OptionName = 'ETicketMap') AS ETicketMap ON Event.EventCode = ETicketMap.EventCode LEFT JOIN (SELECT EventCode, OptionValue AS ETicketDrivingDirections FROM EventOptions (NOLOCK) WHERE OptionName = 'ETicketDrivingDirections') AS ETicketDrivingDirections ON Event.EventCode = ETicketDrivingDirections.EventCode LEFT JOIN (SELECT EventCode, OptionValue AS ETicketGeneralInfo FROM EventOptions (NOLOCK) WHERE OptionName = 'ETicketGeneralInfo') AS ETicketGeneralInfo ON Event.EventCode = ETicketGeneralInfo.EventCode LEFT JOIN(SELECT EventCode, OptionValue AS ETicketBackgroundPath FROM EventOptions (NOLOCK) WHERE OptionName = 'ETicketBackground') AS ETicketBackground ON Event.EventCode = ETicketBackground.EventCode LEFT JOIN (SELECT EventCode, OptionValue AS ETicketLogoPath FROM EventOptions (NOLOCK) WHERE OptionName = 'ETicketLogo') AS ETicketLogo ON Event.EventCode = ETicketLogo.EventCode LEFT JOIN (SELECT EventCode, OptionValue AS ETicketBottomBarPath FROM EventOptions (NOLOCK) WHERE OptionName = 'ETicketBottomBar') AS ETicketBottomBar ON Event.EventCode = ETicketBottomBar.EventCode LEFT JOIN (SELECT EventCode, OptionValue AS TicketText1 FROM EventOptions (NOLOCK) WHERE OptionName = 'TicketText1') AS TicketText1 ON Event.EventCode = TicketText1.EventCode LEFT JOIN (SELECT EventCode, OptionValue AS TicketText2 FROM EventOptions (NOLOCK) WHERE OptionName = 'TicketText2') AS TicketText2 ON Event.EventCode = TicketText2.EventCode LEFT JOIN (SELECT EventCode, OptionValue AS TicketText3 FROM EventOptions (NOLOCK) WHERE OptionName = 'TicketText3') AS TicketText3 ON Event.EventCode = TicketText3.EventCode WHERE OrderLine.OrderNumber = " & rsOrderNum("OrderNumber") & " AND OrderLine.ShipCode = 13 AND Ticket.StatusCode = 'A' AND OrganizationVenue.Owner = 1 AND OrderLine.ItemType IN ('Seat', 'SubSeat')"
    Else 'Request("PrintSub") = "Y", Print Individual, plus only Parent ticket if all Children have same barcode, otherwise Children only (no Parent).
    	SQLTix = "SELECT OrderLine.ShipFirstName, OrderLine.ShipLastName, OrderLine.ShipAddress1, OrderLine.ShipAddress2, OrderLine.ShipCity, OrderLine.ShipState, OrderLine.ShipCountry, OrderLine.ShipPostalCode, OrderLine.Price, OrderLine.Discount AS LineDiscount, OrderLine.Price - OrderLine.Discount AS NetPrice, OrderLine.ItemType, OrderHeader.OrderNumber, OrderHeader.Subtotal, OrderHeader.ShipFee, OrderHeader.OrderSurcharge, OrderHeader.Total, OrderHeader.Discount AS OrderDiscount, OrderDate, OrderHeader.OrderTypeNumber, Customer.FirstName, Customer.LastName, Customer.Address1, Customer.Address2, Customer.City, Customer.State, Customer.Country, Customer.PostalCode, Seat.ItemNumber, Seat.Row, Seat.Seat, Section.SectionCode, Section.Section, Event.EventCode, Event.EventDate, Event.Phone AS EventPhoneNumber, Event.EMailAddress AS EventEMailAddress, Act.Act, Act.Actcode, Act.ShortAct, Act.Producer, Act.Comments AS ActComments, Event.Comments AS EventComments, Event.Map, Venue.Venue, Venue.Address_1 AS VenueAddress1, Venue.Address_2 AS VenueAddress2, Venue.City AS VenueCity, Venue.State AS VenueState, Venue.Zip_Code AS VenuePostalCode, SeatType.SeatType, Shipping.ShipType, OrderType, Organization.Organization, Ticket.TicketNumber, ETicketAdPath, ETicketMapPath, ETicketDrivingDirections, ETicketGeneralInfo, ETicketBackgroundPath, ETicketLogoPath, ETicketBottomBarPath, TicketText1, TicketText2, TicketText3 FROM (SELECT DISTINCT TicketLine.OrderNumber, TicketLine.LineNumber, CASE WHEN TicketLine.ItemType = 'Seat' THEN 'Seat' WHEN TicketLine.LineNumber = TicketLine.MinTicketMatch AND TicketLine.LineNumber = TicketLine.MaxTicketMatch THEN 'SubFixedEvent' ELSE 'SubSeat' END AS TLItemType, ISNULL(TL2.AvailChildCount,0) AS AvailChildCount FROM (SELECT OrderLine.OrderNumber, OrderLine.LineNumber, OrderLine.ItemType, ISNULL(MIN(CASE TChild.TicketNumber WHEN Ticket.TicketNumber THEN OrderLine.LineNumber ELSE OLChild.LineNumber END), OrderLine.LineNumber) AS MinTicketMatch, ISNULL(MAX(CASE TChild.TicketNumber WHEN Ticket.TicketNumber THEN OrderLine.LineNumber ELSE OLChild.LineNumber END), OrderLine.LineNumber) AS MaxTicketMatch FROM OrderLine (NOLOCK) LEFT JOIN Ticket (NOLOCK) ON OrderLine.ItemNumber = Ticket.ItemNumber AND OrderLine.OrderNumber = Ticket.OrderNumber AND Ticket.StatusCode IN ('A', 'S') LEFT JOIN OrderLine (NOLOCK) AS OLChild ON OrderLine.OrderNumber = OLChild.OrderNumber AND OrderLine.LineNumber = OLChild.ParentLineNumber LEFT JOIN Ticket (NOLOCK) AS TChild ON OLChild.ItemNumber = TChild.ItemNumber AND OLChild.OrderNumber = TChild.OrderNumber AND TChild.StatusCode IN ('A', 'S') WHERE OrderLine.OrderNumber = " & rsOrderNum("OrderNumber") & " AND OrderLine.ItemType IN ('Seat', 'SubFixedEvent') GROUP BY OrderLine.OrderNumber, OrderLine.LineNumber, OrderLine.ItemType) AS TicketLine LEFT JOIN OrderLine (NOLOCK) AS OL ON TicketLine.OrderNumber = OL.OrderNumber AND TicketLine.LineNumber = OL.ParentLineNumber LEFT JOIN (SELECT Ticket.OrderNumber, OrderLine.LineNumber, COUNT(*) AS AvailChildCount FROM Ticket (NOLOCK) INNER JOIN OrderLine (NOLOCK) ON Ticket.OrderNumber = OrderLine.OrderNumber AND Ticket.ItemNumber = OrderLine.ItemNumber INNER JOIN OrderLine (NOLOCK) AS OLC1 ON OrderLine.OrderNumber = OLC1.OrderNumber AND OrderLine.LineNumber = OLC1.ParentLineNumber INNER JOIN Ticket (NOLOCK) AS TC1 ON OLC1.OrderNumber = TC1.OrderNumber AND OLC1.ItemNumber = TC1.ItemNumber AND TC1.StatusCode IN ('A', 'S') WHERE Ticket.OrderNumber = " & rsOrderNum("OrderNumber") & " AND OrderLine.ItemType = 'SubFixedEvent' AND TC1.StatusCode = 'A' GROUP BY Ticket.OrderNumber, OrderLine.LineNumber) AS TL2 ON TicketLine.OrderNumber = TL2.OrderNumber AND TicketLine.LineNumber = TL2.LineNumber) AS TicketLine2 INNER JOIN OrderLine (NOLOCK) ON TicketLine2.OrderNumber = OrderLine.OrderNumber INNER JOIN OrderHeader (NOLOCK) ON OrderLine.OrderNumber = OrderHeader.OrderNumber INNER JOIN Customer (NOLOCK) ON OrderHeader.CustomerNumber = Customer.CustomerNumber INNER JOIN Seat (NOLOCK) ON OrderLine.ItemNumber = Seat.ItemNumber INNER JOIN Event (NOLOCK) ON Seat.EventCode = Event.EventCode INNER JOIN Act (NOLOCK) ON Event.ActCode = Act.ActCode INNER JOIN Venue (NOLOCK) ON Event.VenueCode = Venue.VenueCode INNER JOIN Shipping (NOLOCK) ON OrderLine.ShipCode = Shipping.ShipCode INNER JOIN SeatType (NOLOCK) ON OrderLine.SeatTypeCode = SeatType.SeatTypeCode INNER JOIN Section (NOLOCK) ON Seat.SectionCode = Section.SectionCode AND Seat.EventCode = Section.EventCode LEFT JOIN OrderType (NOLOCK) ON OrderHeader.OrderTypeNumber = OrderType.OrderTypeNumber INNER JOIN Ticket (NOLOCK) ON OrderLine.ItemNumber = Ticket.ItemNumber AND OrderLine.OrderNumber = Ticket.OrderNumber AND Ticket.StatusCode IN ('A', 'S') INNER JOIN OrganizationVenue (NOLOCK) ON Event.VenueCode = OrganizationVenue.VenueCode INNER JOIN Organization (NOLOCK) ON OrganizationVenue.OrganizationNumber = Organization.OrganizationNumber LEFT JOIN (SELECT EventCode, OptionValue AS ETicketAdPath FROM EventOptions (NOLOCK) WHERE OptionName = 'ETicketAd') AS ETicketAd ON Event.EventCode = ETicketAd.EventCode LEFT JOIN (SELECT EventCode, OptionValue AS ETicketMapPath FROM EventOptions (NOLOCK) WHERE OptionName = 'ETicketMap') AS ETicketMap ON Event.EventCode = ETicketMap.EventCode LEFT JOIN (SELECT EventCode, OptionValue AS ETicketDrivingDirections FROM EventOptions (NOLOCK) WHERE OptionName = 'ETicketDrivingDirections') AS ETicketDrivingDirections ON Event.EventCode = ETicketDrivingDirections.EventCode LEFT JOIN (SELECT EventCode, OptionValue AS ETicketGeneralInfo FROM EventOptions (NOLOCK) WHERE OptionName = 'ETicketGeneralInfo') AS ETicketGeneralInfo ON Event.EventCode = ETicketGeneralInfo.EventCode LEFT JOIN (SELECT EventCode, OptionValue AS ETicketBackgroundPath FROM EventOptions (NOLOCK) WHERE OptionName = 'ETicketBackground') AS ETicketBackground ON Event.EventCode = ETicketBackground.EventCode LEFT JOIN (SELECT EventCode, OptionValue AS ETicketLogoPath FROM EventOptions (NOLOCK) WHERE OptionName = 'ETicketLogo') AS ETicketLogo ON Event.EventCode = ETicketLogo.EventCode LEFT JOIN (SELECT EventCode, OptionValue AS ETicketBottomBarPath FROM EventOptions (NOLOCK) WHERE OptionName = 'ETicketBottomBar') AS ETicketBottomBar ON Event.EventCode = ETicketBottomBar.EventCode LEFT JOIN (SELECT EventCode, OptionValue AS TicketText1 FROM EventOptions (NOLOCK) WHERE OptionName = 'TicketText1') AS TicketText1 ON Event.EventCode = TicketText1.EventCode LEFT JOIN (SELECT EventCode, OptionValue AS TicketText2 FROM EventOptions (NOLOCK) WHERE OptionName = 'TicketText2') AS TicketText2 ON Event.EventCode = TicketText2.EventCode LEFT JOIN (SELECT EventCode, OptionValue AS TicketText3 FROM EventOptions (NOLOCK) WHERE OptionName = 'TicketText3') AS TicketText3 ON Event.EventCode = TicketText3.EventCode WHERE OrderLine.OrderNumber = " & rsOrderNum("OrderNumber") & " AND ISNULL(OrderLine.ParentLineNumber,OrderLine.LineNumber) = TicketLine2.LineNumber AND TicketLine2.TLItemType = OrderLine.ItemType AND (TLItemType = 'SubFixedEvent' AND (Ticket.StatusCode = 'A' OR AvailChildCount > 0) OR TLItemType <> 'SubFixedEvent' AND Ticket.StatusCode = 'A') AND OrderLine.ShipCode = 13 AND OrganizationVenue.Owner = 1"
    End If

	Set rsTix = OBJdbConnection.Execute(SQLTix)

	If Not rsTix.EOF Then



Response.Write "<html lang=""en"">" &vbCrLF
Response.Write "<head>" &vbCrLf
Response.Write "<meta http-equiv=""X-UA-Compatible"" content=""IE=edge"">" &vbCrLf
Response.Write	"<meta charset=""utf-8"">" &vbCrLf
Response.Write "	<meta name=""viewport"" content=""width=device-width, initial-scale=1.0"">" &vbCrLf

Response.Write	"<link rel=""stylesheet"" href=""https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"" rel=""stylesheet"" media=""all"">" &vbCrLf
Response.Write	"<link rel=""stylesheet"" href=""https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css"">" &vbCrLf
Response.Write  "<link rel=""stylesheet"" href=""https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css"">" &vbCrLf
Response.Write	"<script src=""https://code.jquery.com/jquery-1.11.3.min.js""></script>" &vbCrLf
Response.Write  "<script src=""https://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js""></script>" &vbCrLf
Response.Write  "<link rel=""stylesheet"" href=""https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"">" &vbCrLf
Response.Write  "<link rel=""stylesheet"" href=""images/style.css"">" &vbCrLf

%>
<script type="text/javascript">

$(document).ready(function () {
    //Convert address tags to google map links - Copyright Michael Jasper 2011
    $('addressmobile').each(function () {
        var link = "<a href='http://maps.google.com/maps?q=" + encodeURIComponent( $(this).text() ) + "' target='_blank'>" + $(this).text() + "</a>";
        $(this).html(link);
    });
});
</script>

<%

ETicketBackground = ""
Do Until rsTix.EOF

TixCount = TixCount + 1


'call out at top'
'REE 7/8/6 - Modified to allow flexible length ticket numbers.  Insert dash after every 4th digit.
TicketDigit = 1
ETicketNumber = ""
Do Until TicketDigit >= Len(rsTix("TicketNumber"))
  If TicketDigit < Len(rsTix("TicketNumber")) - 4 Then
    ETicketNumber = ETicketNumber & Mid(rsTix("TicketNumber"), TicketDigit, 4) & "-"
    TicketDigit = TicketDigit + 4
  Else
    ETicketNumber = ETicketNumber & Mid(rsTix("TicketNumber"), TicketDigit, (Len(rsTix("TicketNumber")) - TicketDigit) + 1)
    TicketDigit = Len(rsTix("TicketNumber"))
  End If
Loop

'Please print message
Response.Write "<div class=""container"" >" &vbCrLF
Response.Write "<div class=""row"">" &vbCrLf
Response.Write "<div class=""col-md-12"">" &vbCrLF
Response.Write "<font size=""3""><B>THIS IS YOUR TICKET. Please print and bring to event</B><BR></font>" &vbCrLf
Response.Write "</div>" &vbCrLf
Response.Write "</div>" &vbCrLf
Response.Write  "</div>" &vbCrLf
