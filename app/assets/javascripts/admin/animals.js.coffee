jQuery ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.next_page').children().attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text("Fetching more products...")
        $.getScript(url)
    $(window).scroll()