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

  $("input#cc_number").blur ->
    if CreditCard.validNumber(@value)
        $("#cc_number_error").text("")
      else
        $("#cc_number_error").text("Invalid credit card number")


  $("[type='radio']").change ->
    id = $(this).val()
    $("#payment_profile_id").val(id)
###

  $(".btn-pp").click ->
    console.log("click")
    btn = $(this)
    id = btn.attr("id")
    input = $("#payment_profile_id")

    #btn.button("toggle")

    #console.log(id)

    $(".clicked").each ->
      $(this).removeClass("clicked")


    if btn.attr("clicked") == "clicked"
      btn.attr("clicked", "")
      input.val("")
    else
      btn.attr("clicked", "clicked")
      input.val(id)###
###
###
