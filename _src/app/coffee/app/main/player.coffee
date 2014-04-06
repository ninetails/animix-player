
window.requirejs ['jquery'], ($) ->
  load_config = () ->
    config =
      autoplay: if $("meta[name='animix.player.autoplay']").length > 0 then !!parseInt($("meta[name='animix.player.autoplay']").attr('content'), 10) else true
      player:
        embed: if $("meta[name='animix.player.embed']").length > 0 then $("meta[name='animix.player.embed']").attr('content') else 'http://play.radioanimix.com.br/'

    if $("meta[name='animix.player.dataurl']").length > 0 and $("meta[name='animix.player.datacallback']").length > 0
      config.data =
        url: $("meta[name='animix.player.dataurl']").attr('content')
        jsonpcallback: $("meta[name='animix.player.datacallback']").attr('content')

    config

  mount_player = (opts) ->
    # load player
    container = $ document.createElement 'div'
      .attr 'id', 'player'
      .css
        'display': 'none'

    player = $ document.createElement 'audio'
      .attr 'src', config.src

    player.attr('autoplay', '') if config.autoplay

    container.append player

    $ 'body'
      .append container
    return

  # player config
  config = load_config()

  if config.data? and typeof config.data.url is 'string' and typeof config.data.jsonpcallback is 'string'
    $.ajax
      url: config.data.url
      dataType: 'jsonp'
      jsonpCallback: config.data.jsonpcallback
      success: (data) ->
        opts = $.extend true, {}, config, data
        mount_player opts
  else
    mount_player config

  return
