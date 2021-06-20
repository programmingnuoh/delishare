$(window).on('load', function(){
  $('.main-message').each(function(){
    const elemPos = $(this).offset().top-50;
    const scroll = $(window).scrollTop();
    const windowHeight = $(window).height();
    if (scroll >= elemPos - windowHeight) {
      $(this).addClass('message-fade');
    } else {
      $(this).removeClass('message-fade');
    }
  });
});

$(window).scroll(function(){
    $('.site-message').each(function(){
        const elemPos = $(this).offset().top-50;
        const scroll = $(window).scrollTop();
        const windowHeight = $(window).height();
        if (scroll >= elemPos - windowHeight) {
          $(this).addClass('message-line-appear')
        } else {
          $(this).removeClass('message-line-appear')
        }
      });
    $('.introduction-title').each(function(){
    const elemPos = $(this).offset().top-50;
    const scroll = $(window).scrollTop();
    const windowHeight = $(window).height();
    if (scroll >= elemPos - windowHeight) {
      $(this).addClass('title-line-move')
    } else {
      $(this).removeClass('title-line-move')
    }
  });
});