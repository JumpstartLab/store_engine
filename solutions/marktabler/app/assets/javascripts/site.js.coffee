# Keeps the scroller anchored.
moveScroller = ->
  offset   = $(window).scrollTop()
  anchor   = $("#scroller-anchor").offset().top
  scroller = $("#scroller")

  if (offset > anchor)
    scroller.css({position:"fixed",top:"0px"})
  else if (offset <= anchor)
    scroller.css({position:"relative",top:""})

$(->
  # Hook into the scroll event,
  # and go ahead and scroll.
  $(window).scroll(moveScroller)
  moveScroller())
