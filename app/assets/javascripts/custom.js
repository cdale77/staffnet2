$(document).on("focus", "[data-behaviour~='datepicker']", function(e){
    $(this).datepicker({"format": "yyyy-mm-dd", "weekStart": 1, "autoclose": true})
});

$(document).on("focus", "[data-behaviour~='timepicker']", function(e){
    $(this).timepicker()
});

$(document).ready(function() {
    $(".field-toggle").on("click", function() {
       $(this).button("toggle");
    });
});