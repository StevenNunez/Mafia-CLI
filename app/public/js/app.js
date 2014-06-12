'use strict';
$(function(){
  if (window.location.pathname === '/'){
    $('.new-game-submit').click(function(event){
        event.preventDefault();
        var labelText = $('.new-game-label').text();
        $.post('/games', {label: labelText}, function(){
          window.location = '/play';
        })
    });

    $.getJSON('games.json', function(games){
      games.forEach(function(game){
        var template_string = "<li data-id='<%= item.id %>'><a href='#'><%= item.label %></a></li>"
        var template = _.template(template_string);
        $('#existing-games').append(template({item: game}));
      });

      $('#existing-games li').click(function(event){
        event.preventDefault();
        var game_id = $(this).data('id');
        $.post('join/' + game_id, function(){
          window.location = '/play';
        })
      });
    });
  }
  if (window.location.pathname === '/play') {
    console.log("Playing a game");
  }
})
