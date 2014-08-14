# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


## calculator that tells users if they've entered reasonable values for raised amounts

clear_qty_cells = () ->
  $(".calculator-error-qty").removeClass("field_with_errors")

flag_qty_cells = () ->
  $(".calculator-error-qty").addClass("field_with_errors")

clear_amt_cells = () ->
  $(".calculator-error-amt").removeClass("field_with_errors")

flag_amt_cells = () ->
  $(".calculator-error-amt").addClass("field_with_errors")

$ ->

  # initialize and set all variables to 0
  reportedYes = 0
  reportedRaised = 0
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

  monthlyMultiplier = 7.0
  quarterlyMultiplier = 3.0

  # when any of the input fields are blurred, re-grab all the variables.
  # Would be better to just grab the effected field, but performance is not an issue.
  $("input.input-shift-data").on "blur", ->
    reportedYes = $("input#shift_reported_total_yes").val()
    reportedRaised = $("input#shift_reported_raised").val()
    cashQty = $("input#shift_reported_cash_qty").val()
    checkQty = $("input#shift_reported_check_qty").val()
    creditQty = $("input#shift_reported_one_time_cc_qty").val()
    monthlyQty = $("input#shift_reported_monthly_cc_qty").val()
    quarterlyQty = $("input#shift_reported_quarterly_cc_qty").val()
    cashAmt = $("input#shift_reported_cash_amt").val()
    creditAmt = $("input#shift_reported_one_time_cc_amt").val()
    checkAmt = $("input#shift_reported_check_amt").val()
    monthlyAmt = $("input#shift_reported_monthly_cc_amt").val()
    quarterlyAmt = $("input#shift_reported_quarterly_cc_amt").val()

    shiftTypeID = $("select#shift_shift_type_id").val()

    #monthlyMultiplier = gon.shift_types[shiftTypeID]["monthly"]
    #quarterlyMultiplier = gon.shift_types[shiftTypeID]["quarterly"]

    monthlyValue = monthlyAmt * 7
    quarterlyValue = quarterlyAmt * 3

    totalYes = +cashQty + +checkQty + +creditQty + +monthlyQty + +quarterlyQty
    totalRaised = +cashAmt + +creditAmt + +checkAmt + +monthlyValue + +quarterlyValue

    if +reportedYes == totalYes
      clear_qty_cells()
    else
      flag_qty_cells()

    if +reportedRaised == totalRaised
      clear_amt_cells()
    else
      flag_amt_cells()

