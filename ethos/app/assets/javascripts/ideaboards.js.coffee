$(document).ready ->
  $("#ideaboard-create").addClass("unload")
  $("#ideaboard_title").focus ->
    $("#ideaboard-create").removeClass("unload").addClass("load")

  $("#ideaboard-cancel").click ->
    $("#ideaboard-create").removeClass("load").addClass("unload")
