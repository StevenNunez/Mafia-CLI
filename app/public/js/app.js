'use strict';
$(function(){
  if (window.location.pathname === '/'){
    $('.new-game-submit').click(function(event){
      event.preventDefault();
      var labelText = $('.new-game-label').val();
      $.post('/games', {label: labelText}, function(){
        window.location = '/play';
      })
    });

    $.getJSON('games.json', function(games){
      games.forEach(function(game){
        var templateString = "<li data-id='<%= item.id %>'><a href='#'><%= item.label %></a></li>"
        var template = _.template(templateString);
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
    $('.sleep').click(function(e){
        e.preventDefault();
        $.post('/sleep.json', {}, function(data){
          $('.sleep').attr("disabled", "disabled");
          $('.notice').text(data.name + " was killed last night");
          $('.towns-people li:contains("'+ data.name + '")').slideUp();
        })
    })

    $.getJSON('/game.json', function(data){
      data.townsPeople.forEach(function(townsPerson){
        var templateString = "<li><a href='#'><%= item.name %></a></li>"
        var template = _.template(templateString);
        $('.towns-people').append(template({item: townsPerson}));
      });
      $('#game-label').text(data.label);
      $('.towns-people li a').hover(function(){
        $(this).addClass('shake shake-little');
      }, function(){
        $(this).removeClass('shake shake-little');
      });

      $('.towns-people li').on('click', function(event){
        $('.sleep').removeAttr("disabled");
        event.preventDefault();
        var $dead = $(this);
        var deadName = $dead.text();
        $dead.slideUp();

        $.post('/kill.json', { dead: deadName }, function(mafiaStatus){
          if(mafiaStatus === true){
            $('.notice').text(deadName + " was Mafia!");
          } else {
            $('.notice').text(deadName + " was NOT Mafia!");
          }
        });
      });
    });
  }
})
