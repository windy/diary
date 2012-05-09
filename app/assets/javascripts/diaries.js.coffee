# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $('.diary a').click ->
    $.get this.href,(data) ->
      $('div.content').html("<pre>" +data + "</pre>")
    false

  diary_text = $("#diary_text")
  preview_text = $("#preview_text")
  $('#preview').click ->
    $('#edit').parent().removeClass('active')
    $(this).parent().addClass('active')
    preview_text.html('加载中...')
    $.post '/diaries/preview', {text: diary_text.val()}, (data)->
      preview_text.html(data)
      diary_text.hide()
      preview_text.show()
    false

  $('#edit').click ->
    $('#preview').parent().removeClass('active')
    $(this).parent().addClass('active')
    preview_text.hide()
    diary_text.show()
    false
