app.Modules.create({
   body: function(app, $) {
       return {
           constructor: function() {
               this.init();
           },

           init: function() {
               // console.log('lol')
           },
       };
   },

   onDocumentReady: true

   // export: {
   //     show_actions_bar_title: 'show',
   //     hide_actions_bar_title: 'hide',
   //     toggle_actions_bar_title: 'toggle'
   // }
});
