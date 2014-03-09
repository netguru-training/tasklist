$("<%= j (render task)%>").appendTo("#tasks");
setTimeout(function() {
  $('#task_description').val('');
},100);