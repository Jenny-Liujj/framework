//= require froala_editor.min
//= require plugins/align.min
//= require plugins/image.min
//= require plugins/image_manager.min
//= require plugins/colors.min
//= require plugins/font_family.min
//= require plugins/font_size.min
//= require plugins/fullscreen.min
//= require plugins/inline_style.min.js
//= require plugins/line_breaker.min.js
//= require plugins/link.min.js
//= require plugins/lists.min.js
//= require plugins/paragraph_format.min.js
//= require plugins/paragraph_style.min.js
//= require plugins/quote.min.js
//= require plugins/table.min.js
//= require plugins/video.min
//= require languages/zh_cn

$(document).on('turbolinks:load', function() {
  $.FroalaEditor.DEFAULTS.key = 'Ohg1bdJ-7A2gfqrvA-8F2xsp=='

  $('.froala-editor#post_content').froalaEditor({
    heightMin: 300,
    fontSize: ['8', '9', '10', '11', '12', '14', '16', '18', '24', '30', '36', '48', '60', '72', '96'],
    language: 'zh_cn'
  })

  $('.froala-editor#comment_content').froalaEditor({
    heightMin: 300,
    fontSize: ['8', '9', '10', '11', '12', '14', '16', '18', '24', '30', '36', '48', '60', '72', '96'],
    language: 'zh_cn'
  })
})
