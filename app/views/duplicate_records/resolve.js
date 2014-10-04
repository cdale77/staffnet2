(function () {
  $("#merge-form-<%= @duplicate_record.id %>").collapse("hide");
  $(".btn-ajax").button("reset");
  $("#merge-alert-<%= @duplicate_record.id %>").html("<%= j render "merge_alert" %>");
  $("#merge-alert-<%= @duplicate_record.id %>").collapse("show");
})();