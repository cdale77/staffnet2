# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


## code for the calculator that tells users if they've entered reasonable values for raised amounts
$ ->

  # initialize and set all variables to 0
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

  # when any of the input fields are blurred, re-grab all the variables.
  # Would be better to just grab the effected field, but performance is not an issue.
  $("input.input-shift-data").on "blur", ->
    totalYes = $("input#shift_reported_total_yes").val()
    totalRaised = $("input#shift_reported_total_raised").val()
    cashQty = $("input#shift_reported_cash_qty").val()
    checkQty = $("input#shift_reported_check_qty").val()
    creditQty = $("input#shift_reported_credit_qty").val()
    monthlyQty = $("input#shift_reported_monthly_qty").val()
    quarterlyQty = $("input#shift_reported_quarterly_qty").val()
    cashAmt = $("input#shift_reported_cash_amt").val()
    creditAmt = $("input#shift_reported_credit_amt").val()
    checkAmt = $("input#shift_reported_check_amt").val()
    monthlyAmt = $("input#shift_reported_monthly_amt").val()
    quarterlyAmt = $("input#shift_reported_quarterly_amt").val()



#    shiftType = $("select#shift_shift_type").val()
#
#    if shiftType == 'door' or shiftType == 'street'
#      monthlyAmt = monthlyAmt * 7
#      quarterlyAmt = quarterlyAmt * 3
#
#    if shiftType == 'phone'
#      monthlyAmt = monthlyAmt * 7
#      quarterlyAmt = quarterlyAmt * 3
#
#    totalYes =  +cashQty + +checkQty + +creditQty + +monthlyQty + +quarterlyQty
#    totalRaised = +cashAmt + +checkAmt + +creditAmt + +monthlyAmt + +quarterlyAmt
#
#    $("span#totalYes").html totalYes
#    $("span#totalRaised").html totalRaised

