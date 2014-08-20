ready = ->

  $(".clickable-row").click ->
    window.document.location = $(this).attr "url"

$(document).ready(ready)
$(document).on('page:load', ready)