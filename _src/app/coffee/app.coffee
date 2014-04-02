do (window) ->
  # local fallback to requirejs
  if not window.requirejs?
    do (d = document, t = 'script') ->
      g = d.createElement t
      s = d.getElementsByTagName(t)[0]
      g.src = '/2/vendors/require.js/2.1.11/require.min.js'
      s.parentNode.insertBefore g, s

  # load app
  tid = window.setInterval ->
    if window.requirejs?
      # requirejs config
      window.requirejs.config
        baseUrl: '/2'
        paths:
          app: 'js/app'
          bootstrap: [
            '//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.1.1/js/bootstrap.min',
            'vendors/bootstrap/3.1.1/js/bootstrap.min'
          ]
          jquery: [
            '//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min',
            'vendors/jquery/1.11.0/jquery.min'
          ]
          mediaelement: [
            '//cdnjs.cloudflare.com/ajax/libs/mediaelement/2.13.2/js/mediaelement-and-player.min.js'
          ]
          modernizr: [
            '//cdnjs.cloudflare.com/ajax/libs/modernizr/2.7.1/modernizr.min',
            'vendors/modernizr/2.7.1/modernizr.min'
          ]
        shim:
          'bootstrap': ['jquery']

      # load app/main
      window.requirejs ['app/main.min']

      # clear timeout
      window.clearInterval tid
    return
  , 100
  return
