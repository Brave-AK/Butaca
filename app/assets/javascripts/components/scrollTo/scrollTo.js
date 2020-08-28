app.Modules.create({
  body: function(app, $) {
      return {
        constructor: function() {
          this.init();
        },

        init: function() {
          var that = this;

          var handlerClick = function(event) {
            event.preventDefault();

            var $target = $(this).data('target');

            that.animateScrollTo($target);
          }

          $(document).on('click', '.js-move-down', handlerClick)
          },

          animateScrollTo: function(target) {
            $("body, html").animate({ scrollTop: $(target).offset().top}, 700);
          }
      };
  },

   onDocumentReady: true
});
