$ =>
  $(".profile-selector"). on "click", ->
    $("#payment-profile-id").val($(this).val());

  $("#donation-amount").on "change", ->
    console.log 'test'
    $("#payment-amount").val($(this).val());




