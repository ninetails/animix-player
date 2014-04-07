
window.requirejs ['jquery', 'app/main/marquee.min'], ($) ->
  load_config = () ->
    config =
      refresh: 60 * 1000
      autoplay: if $("meta[name='animix.player.autoplay']").length > 0 then !!parseInt($("meta[name='animix.player.autoplay']").attr('content'), 10) else true
      player:
        embed: if $("meta[name='animix.player.embed']").length > 0 then $("meta[name='animix.player.embed']").attr('content') else 'http://play.radioanimix.com.br/'

    if $("meta[name='animix.player.dataurl']").length > 0 and $("meta[name='animix.player.datacallback']").length > 0
      config.data =
        url: $("meta[name='animix.player.dataurl']").attr('content')
        jsonpcallback: $("meta[name='animix.player.datacallback']").attr('content')

    config

  mount_player = (opts) ->
    if $('audio').length == 0
      container = $ document.createElement 'div'
        .attr 'id', 'audio'
        .css
          'display': 'none'

      player = $ document.createElement 'audio'
        .attr 'src', opts.player.embed
      player.attr('autoplay', '') if config.autoplay

      container.append player

      $ 'body'
        .append container

      player_bind_events()
    # end of player creation

    player_fill_info opts
    return

  player_bind_events = () ->
    $ '.player-control'
      .bind 'click', (e) ->
        e.preventDefault()
        if $(@).hasClass 'play'
          $ @
            .removeClass 'play'
            .removeClass 'glyphicon-play'
            .addClass 'pause'
            .addClass 'glyphicon-pause'
          $('audio').get(0).play()
        else
          $ @
            .removeClass 'pause'
            .removeClass 'glyphicon-pause'
            .addClass 'play'
            .addClass 'glyphicon-play'
          $('audio').get(0).pause()
    return

  player_fill_info = (opts) ->
    $('.title').text opts.player.title
    $('.caster').text opts.player.caster
    $('.program-link').attr('href', opts.player.url).attr('target', '_blank')
    $('.program-image').attr 'src', opts.player.image
    $('.link-winamp').attr 'href', opts.player.winamp
    $('.link-wmp').attr 'href', opts.player.wmp
    $('.link-itunes').attr 'href', opts.player.itunes
    $('.link-real').attr 'href', opts.player.real

    if opts.player.playing?
      $ '.on-air .marquee'
        .remove()
      $ '.on-air'
        .text 'Tocando:'
        .append($(document.createElement('span')).addClass('marquee'))
        .show()
      $ '.on-air .marquee'
        .removeClass 'full'
        .text opts.player.playing
        .marquee
          speed: 3e1
    else
      $ '.on-air .marquee'
        .remove()
      $ '.on-air'
        .append($(document.createElement('span')).addClass('marquee'))
        .show()
      $ '.on-air .marquee'
        .addClass 'full'
        .text 'Você está ouvindo a Rádio Animix, a Rádio de Todos os seus Momentos!'
        .marquee
          speed: 3e1

    if !!parseInt(opts.player.requests, 10)
      $ '.requests'
        .show()
    else
      $ '.requests'
        .hide()

    return

  fetch_data = () ->
    $.ajax
      url: config.data.url
      dataType: 'jsonp'
      jsonpCallback: config.data.jsonpcallback
      success: (data) ->
        opts = $.extend true, {}, config, data
        mount_player opts
    return

  # player config
  config = load_config()

  if config.data? and typeof config.data.url is 'string' and typeof config.data.jsonpcallback is 'string'
    fetch_data()
    window.setInterval fetch_data, config.refresh
  else
    mount_player config

  return
