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

            var $root = $(this).closest('.landing');

            $root.toggleClass('menu-burger--shown');
          }

          $(document).on('click', '.js-menu-burger-toggle', handlerClick)
          },
      };
  },

   onDocumentReady: true
});
