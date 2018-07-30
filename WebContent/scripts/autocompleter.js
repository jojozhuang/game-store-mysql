$(document).ready(function() {
    $(function() {
        $("#search").autocomplete({     
            source : function(request, response) {
                $.ajax({
                    url : "autocompleter.jsp",
                    type : "GET",
                    data : {
                        term : request.term
                    },
                    dataType : "json",
                    success : function(data) {
                        response(data);
                    }
                });
            }
        });
    });
});