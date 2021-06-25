function messageLine(){
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
}

function titleLine(){
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
}

function deliFade(){
    $('.deli-list').each(function(){
        const elemPos = $(this).offset().top-50;
        const scroll = $(window).scrollTop();
        const windowHeight = $(window).height();
        if (scroll >= elemPos - windowHeight) {
          $(this).addClass('deli-fadeUp')
        } else {
          $(this).removeClass('deli-fadeUp')
        }
    });
}

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
  titleLine();
  messageLine();
  deliFade();
});