# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
$(document).ready ->
  $('div.diary a').click ->
    preview_modal = $('#preview_modal')
    preview_modal.children('.modal-header').find('h3').html( $(this).text() )
    preview_modal.children('.modal-body').html("加载中...")
    preview_modal.modal('show')
    $.get $(this).attr('href'), (data) ->
      preview_modal.children('.modal-body').html(data + "<p>(全文完)</p>")
    false

  $('div.diary').click ->
    $(this).children('.title').find('a').trigger('click')
