
requirejs ['jquery', 'modernizr', 'bootstrap'], ($) ->
  # bootstrap css fallback
  if $('h1').is ':visible'
    do (d = document) ->
      l = d.createElement(t)
      h = d.getElementsByTagName( 'head' )[0]
      l.rel = 'stylesheet'
      l.href = '/2/vendors/bootstrap/3.1.1/css/bootstrap.min.css'
      h.appendChild l
      return

  return
