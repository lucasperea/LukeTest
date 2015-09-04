<script type="text/javascript">

$(document).ready(function () {
    //Convert address tags to google map links - Copyright Michael Jasper 2011
    $('addressmobile').each(function () {
        var link = "<a href='http://maps.google.com/maps?q=" + encodeURIComponent( $(this).text() ) + "' target='_blank'>" + $(this).text() + "</a>";
        $(this).html(link);
    });
});
</script>
