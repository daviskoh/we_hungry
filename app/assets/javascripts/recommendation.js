$(function() {
  console.log('LOADED reco ajax js file');

  var createImage = function(url, className) {
    return $("<img src='" + url + "' class='" + className + "'>");
  }

  var createLink = function(button, foodObject, linkExtension, className) {
    var link = "/users/" + sessionID + "/playlist_foods/" + foodObject.id;

    if (linkExtension) link += "/" + linkExtension; 

    return $("<a href='" + link + "' class='" + className + "'></a>").append(button);
  }

  var appendLi = function(foodObject) {
    console.log('appending food reco');

    var li = $("<li class='food'></li>");

    // name link
    li.append( createLink(foodObject.name, foodObject, false, 'food_specific') );
    // image link
    var img = createImage(foodObject.image_url, 'food_image');
    li.append( createLink(img, foodObject, false, '') );

    // thumbs up link
    var img = createImage('http://images.wikia.com/candy-crush-saga/images/7/7e/Thumbs-up-icon.png', 'thumbs_up');
    li.append( createLink(img, foodObject, '/like') );

    // thumbs down link
    var img = createImage('http://upload.wikimedia.org/wikipedia/en/2/2f/Thumbs-down-icon.png', 'thumbs_down');
    li.append( createLink(img, foodObject, '/dislike') );

    $('#recommendations_list').prepend(li);
  }

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
      success: function(foodObject) {
        console.log('reco gen SUCCESS');
        response = arguments;

        appendLi(foodObject);
      },
      error: function() {
        console.log('reco gen ERROR');
        response = arguments;
      }
    });
  });
})