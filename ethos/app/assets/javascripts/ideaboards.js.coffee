$(document).ready ->
  $("#ideaboard-create").hide()
  $("#ideaboard-title").focus ->
    console.log('focused')
    $("#ideaboard-create").toggle()

  $("#ideaboard-title").blur ->
    $("ideaboard-create").toggle()
