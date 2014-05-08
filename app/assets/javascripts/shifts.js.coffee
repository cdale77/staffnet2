# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  totalYes = 0
  totalRaised = 0
  cashQty = 0
  checkQty = 0
  creditQty = 0
  monthlyQty = 0
  quarterlyQty = 0
  cashAmt = 0
  checkAmt = 0
  creditAmt = 0
  monthlyAmt = 0
  quarterlyAmt = 0

  $("input.input-shift-data").on "blur", ->
    cashQty = $("input#cashQty").val()
    checkQty = $("input#checkQty").val()
    creditQty = $("input#creditQty").val()
    monthlyQty = $("input#monthlyQty").val()
    quarterlyQty = $("input#quarterlyQty").val()
    cashAmt = $("input#cashAmt").val()
    creditAmt = $("input#creditAmt").val()
    checkAmt = $("input#checkAmt").val()
    monthlyAmt = $("input#monthlyAmt").val()
    quarterlyAmt = $("input#quarterlyAmt").val()

    shiftType = $("select#shift_shift_type").val()

    if shiftType == 'door' or shiftType == 'street'
      monthlyAmt = monthlyAmt * 7
      quarterlyAmt = quarterlyAmt * 3

    if shiftType == 'phone'
      monthlyAmt = monthlyAmt * 7
      quarterlyAmt = quarterlyAmt * 3
    totalYes =  +cashQty + +checkQty + +creditQty + +monthlyQty + +quarterlyQty
    totalRaised = +cashAmt + +checkAmt + +creditAmt + +monthlyAmt + +quarterlyAmt
    $("span#totalYes").html totalYes
    $("span#totalRaised").html totalRaised

$ ->
  $("select#shift_shift_type").on "change", ->
    shiftType = $("select#shift_shift_type").val()
    switch shiftType
      when 'street'
      #$(".cv_forms").collapse('show')
        $(".door_forms").css "display", "none"
        $(".field_forms").css "display", "block"
      when 'door'
      #$(".cv_forms").collapse('show')
        $(".door_forms").css "display", "block"
        $(".field_forms").css "display", "block"
      when 'phone'
      #$(".cv_forms").collapse('show')
        $(".door_forms").css "display", "none"
        $(".field_forms").css "display", "none"
#when 'office'
#$(".cv_forms").collapse('hide')
#when 'vacation'
#$(".cv_forms").collapse('hide')
#when 'sick'
#$(".cv_forms").collapse('hide')
#when 'holiday'
#$(".cv_forms").collapse('hide')

$ ->
  $("#process_button"). on "click", ->
    $("#process_button").button('loading')