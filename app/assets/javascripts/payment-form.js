$(document).ready(function(){
    $(".profile-selector").on("click", function(){
        $("#payment-profile-id").val($(this).val());
    })
})