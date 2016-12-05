$(document).on('turbolinks:load', function() {
  function registercollection() {
    var collection_elem = $(this)
    var collectable_type = collection_elem.data('collectable-type')
    var collectable_id = collection_elem.data('collectable-id')
    var collect_elem = $('#collect-'+collectable_type+'-'+collectable_id)
    var uncollect_elem = $('#uncollect-'+collectable_type+'-'+collectable_id)

    if (collect_elem.hasClass('disable') && uncollect_elem.hasClass('disable')) {
      collect_elem.addClass('disable')
    }
  }
  $('.collection').each(registercollection)
})
