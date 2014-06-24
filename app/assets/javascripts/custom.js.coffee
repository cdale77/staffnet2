ready = ->

  $(".datepicker").datepicker({"format": "yyyy-mm-dd", "weekStart": 1, "autoclose": true})
  $(this).timepicker

  $(".clickable-row").click ->
    window.document.location = $(this).attr "url"



$(document).ready(ready)
$(document).on('page:load', ready)