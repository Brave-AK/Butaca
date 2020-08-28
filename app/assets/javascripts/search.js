$(function() {
  $("#add_a_film").click(function() {
    $("#add_film_form").toggle();
  });


  
  var previousUrl;

  // This is for handle the modal for titles
  $(document).on('click','.product a.btn-eye, .product .product-overlay', function(event){
    var jTarget = $(event.target)
    var previousUrl = window.location.pathname;
    var newUrl;
    if (jTarget.hasClass('btn-eye')) {
      newUrl = $(this).attr('href');
    } else {
      if (!jTarget.parents('.product-overlay').length) {
        newUrl = jTarget.find('a.btn-eye').click();
        return false;
      } else {
        return true;
      }

    }

    $('#modalTitle').off('shown.bs.modal');
    $('#modalTitle').on('shown.bs.modal', function() {
        $(document).off('focusin.modal');
    });
    $('#modalTitle').modal({
      backdrop: false
    });

    window.history.pushState({}, null, newUrl);
  });
  //------------------------------------//

  $(document).ready( function(){
    setSidebarHeight();
  })

  $(window).resize( function(){
    setSidebarHeight();
  });

  // Script for shrink the top navbar
  $(window).scroll(function() {
    if ($(this).scrollTop() >= 100)
    {
      $('.navbar.navbar-default.navbar-inverse').addClass('small');
      $('.navbar-subnav').addClass('scrolled');
      if ($('#modalTitle .modal-main-content').is(':visible')) {
        $('#modalTitle').css({'top': 115});
      }

      if ($('.sidebarr').not('.mobile-sidebar').length){
        if( !$('.menu-sidebar').hasClass('scrolled') ){
          var height = $('.sidebarr').outerHeight() + 30;

          $('.sidebarr').css({
            height: height,
          });
          console.log(height);

          $('.menu-sidebar').addClass('scrolled');
        }
      }
    }
    if ($(this).scrollTop() === 0) {
      $('.navbar.navbar-default.navbar-inverse').removeClass('small');
      $('.navbar-subnav').removeClass('scrolled');
      $('.menu-sidebar').removeClass('scrolled');
      if ($('#modalTitle .modal-main-content').is(':visible')) {
        $('#modalTitle').css({'top': 145});
      }

      var height = $('.sidebarr').outerHeight() - 30;
      if ($('.sidebarr').not('.mobile-sidebar').length){
        $('.sidebarr').css({
          height: height,
        });
      }
    }
  });

  $(document).on('click', '.navbar-collapse-button span.fa-bars', function(){
    if( !$('.menu-sidebar').hasClass('menu-collapsed') ){
      $('.menu-sidebar').addClass('menu-collapsed');
      $('.main-content').addClass('menu-collapsed');
      $('.breadcrumb').addClass('menu-collapsed');
    }else{
      $('.menu-sidebar').removeClass('menu-collapsed');
      $('.main-content').removeClass('menu-collapsed');
      $('.breadcrumb').removeClass('menu-collapsed');
    }
  });

  $(document).on('click', '.close-button-back', function(){
    $('#modalTitle').modal('hide');
  });

  $(document).on('hidden.bs.modal', '#modalTitle', function (e) {
    window.history.pushState({}, null, previousUrl);
    setSidebarHeight();
    $('li.navbar-collapse-button').html('<span class="fa fa-bars"></span>');
  });
});

function setSidebarHeight(){
  var height = $(window).height();
  if ($('.sidebarr').not('.mobile-sidebar').length){
    $('.sidebarr').css({
      height: height - ($('.navbar-default').height() + $('.navbar-subnav').height()),
    });
  }
}

