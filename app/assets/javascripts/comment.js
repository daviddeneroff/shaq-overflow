$(document).ready(function() {
  $(".new_comment").submit(function(event){
    event.preventDefault();
  var type = $('#comment_commentable_type').val()
  var type_id = $('.comment_commentable_id').val()
  var content = $('#comment_content').val()
    $.ajax({
      type: 'post',
      dataType: "json",
      data: $(this).serialize(),
      url: "/questions/" + type_id + "/comments",
      success: function (response) {
        $(".this-answer" + response.commentable_id).prepend("<p class='centered'>" + response.content + "</p>");
        $('.comment-content').val("");
      }
    });
  })
});