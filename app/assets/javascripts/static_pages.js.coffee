# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#calendar_courses_show').click (e) ->
    e.preventDefault()
    $('div#calendar_courses').fadeIn()
    $('#calendar_courses_show').hide()
    $('#calendar_courses_hide').show()
  $('#calendar_courses_hide').click (e) ->
    e.preventDefault()
    $('div#calendar_courses').fadeOut()
    $('#calendar_courses_show').show()
    $('#calendar_courses_hide').hide()
  showCourseDesciption = (e) ->
    $(@).append("<span class='tooltip'>A quiet, focused environment and step by step teaching method makes Creative a successful program.<br />
Tuition is $20 per class, including all supplies for the class. Classes run for one hour, once a week. </span>")
    $('#calender_link .tooltip').delay(50).fadeIn()
  hideCourseDesciption = (e) ->
    $('#calender_link .tooltip').stop().fadeOut ->
      $(@).remove()
  $('#calender_link a').hover(showCourseDesciption, hideCourseDesciption)



