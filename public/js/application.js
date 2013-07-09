$(document).ready(function() {

  $('form').on('submit', function(e){

    e.preventDefault();

    var data = {
      tweet: $('textarea').val()
    };
    $('textarea').attr('disabled', 'disabled')
    $('input').attr('disabled', 'disabled')
    $('.tweet_status').append('Tweet being processed...')

    $.ajax({
      url: '/tweets',
      method: 'post',
      data: data
    }).done(function(){
      $('textarea').removeAttr('disabled')
      $('input').removeAttr('disabled')
      $('.tweet_status').empty()
      $('.tweet_status').append('Done!')
    })

  })
});
