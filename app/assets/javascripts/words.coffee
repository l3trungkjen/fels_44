$.fn.words = {}

$.fn.words.current

$.fn.words.init = () ->
  $.fn.words.current = $ "#start"
  $.fn.words.current
    .css "background", "#46b8da"
  $ "#prev"
    .attr "disabled", true
  $ "div.word"
    .hide()
  $ "#start"
    .show()
  word_next_attr = $.fn.words.current .next() .attr "data-id"
  if word_next_attr == undefined
    $ "#next"
      .attr "disabled", true
  $ document
    .on "click", "#next", () ->
      $.fn.words.nextWord $.fn.words.current
  $ document
    .on "click", "#prev", () ->
      $.fn.words.prevWord $.fn.words.current

$.fn.words.nextWord = ($current) ->
  word_last_attr = $ "div.word"
    .last() .attr "data-id"
  word_next_attr = $current .next() .attr "data-id"
  if word_last_attr != word_next_attr
    $ "#prev"
      .attr "disabled", false
  else
    $ "#next"
      .attr "disabled", true
  $.fn.words.current = $current .next()
  $ "div.word"
    .css "background", ""
      .hide()
  $.fn.words.current .css "background", "#46b8da"
    .show()

$.fn.words.prevWord = ($current) ->
  word_first_attr = $ "div.word"
    .first() .attr "data-id"
  word_prev_attr = $current .prev() .attr "data-id"
  if word_first_attr != word_prev_attr
    $ "#next"
      .attr "disabled", false
  else
    $ "#prev"
      .attr "disabled", true
  $.fn.words.current = $current
    .prev()
  $ "div.word"
    .css "background", ""
      .hide()
  $.fn.words.current .css "background", "#46b8da"
    .show()