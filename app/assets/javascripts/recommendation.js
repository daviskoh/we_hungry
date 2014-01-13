var appendFood = function(food) {
  console.log('appending food reco');

  $("<li class='food'></li> ")
}

$(function() {
  console.log('LOADED');

  // attach even listener to #generate button
  // ajax for reco
    // progress bar while loading food
  // upon success, persist to DB & immediate prepend to list
  $('a#generate').on('click', function(e) {
    e.preventDefault();

    $.ajax({
      url: '/recommendations/generate',
      type: 'GET',
      dataType: 'json',
      data: {id: sessionID},
      success: function() {
        console.log('reco gen SUCCESS');
        response = arguments;
      },
      error: function() {
        console.log('reco gen ERROR');
        response = arguments;
      }
    });
  });
})