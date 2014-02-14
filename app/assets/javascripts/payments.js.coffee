CreditCard =
  cleanNumber: (number) -> number.replace /[- ]/g, ""

  validNumber: (number) ->
    total = 0
    number = @cleanNumber(number)
    for i in [(number.length-1)..0]
      n = +number[i]
      if (i+number.length) % 2 == 0
        n = if n*2 > 9 then n*2 - 9 else n*2
      total += n
    total % 10 == 0

$ ->
  $(document.body).on "click", ".profile-selector", ->
    id = $(this).val()
    $("#payment-profile-id").val(id)

$ ->

  $("input#cc_number").blur ->
    if CreditCard.validNumber(@value)
        $("#cc_number_error").text("")
      else
        $("#cc_number_error").text("Invalid credit card number")



#  $(".profile-selector").on "click", ->
#    console.log('fire')
#    id = $(this).val()
#    $("#payment-profile-id").val(id)

  $("#donation-amount").change ->
    value = $(this).val()
    $("#payment-amount").val(value)


  $("#donation-type").change ->
    value = $(this).val()
    $("#payment-type").val(value)