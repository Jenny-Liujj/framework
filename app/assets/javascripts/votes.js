$(document).on('turbolinks:load', function() {
  function registerVote() {
    var vote_elem = $(this)
    var votable_type = vote_elem.data('votable-type')
    var votable_id = vote_elem.data('votable-id')
    var vote_up_elem = $('#vote-up-'+votable_type+'-'+votable_id)
    var vote_down_elem = $('#vote-down-'+votable_type+'-'+votable_id)

    if (vote_up_elem.hasClass('disable') && vote_down_elem.hasClass('disable')) {
      vote_elem.addClass('disable')
    }
  }
  $('.vote').each(registerVote)
})
