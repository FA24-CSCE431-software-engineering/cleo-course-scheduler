//= require jquery
//= require select2

$(document).ready(function() {
    $('.searchable-select').select2({
      placeholder: "Select a course",
      allowClear: true
    });
  });