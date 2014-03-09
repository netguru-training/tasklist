$("<%= j (render task)%>").appendTo(".task.right.col-md-10");
setTimeout(function() {
  $('#task_description').val('');
},100);