// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require upload_image/upload_image
//= require froala
//= require select2
//= require_tree .

$(document).on('turbolinks:load', function() {
  // Turn on navbar dropdown toggle.
  $('.dropdown-toggle').dropdown()

  // Use select2.
  $('.select2-tag').select2({
    tags: true,
    minimumResultsForSearch: -1
  })

  // Lengthen global search field.
  var search_field_changed = false
  $('#global-search-field').focus(function() {
    if ($(this).css('width') == '300px' || parseInt($(this).css('width')) > 300) return
    $(this).animate({ width: '300px' }, 500)
    search_field_changed = true
  }).blur(function() {
    if ($(this).css('width') == '172px' || ! search_field_changed) return
    $(this).animate({ width: '172px' }, 500)
  })
  $('#global-search-submit').click(function() {
    alert('搜索功能正在开发，请您稍后使用，谢谢！')
  })

  $('.cancel-comment').click(function() {
    location.reload()
  })

  // Push footer to bottom if necessary.
  function pushFooterToBottom() {
    var main_columns_top = $('#main-columns').position().top
    // Use css('height') instead of height() to include border width.
    var main_columns_height = parseInt($('#main-columns').css('height'))
    var footer_height = parseInt($('footer').css('height'))
    if (main_columns_top + main_columns_height + footer_height < $(window).height()) {
      $('footer').addClass('fixed-to-bottom')
    } else {
      $('footer').removeClass('fixed-to-bottom')
    }
  }
  pushFooterToBottom()
  $(window).resize(function() {
    pushFooterToBottom()
  })
  $('footer').show()
})
