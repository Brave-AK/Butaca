// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//

//--- Angle
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require social-share-button
//= require pageless
//= require jquery.raty
//= require ratyrate
//= require bootstrap
//= require dropdowns
//= require turbolinks
//= require fileuploader/load-image.min
//= require fileuploader/tmpl.min
//= require fileuploader/jquery.ui.widget
//= require fileuploader/jquery.iframe-transport
//= require fileuploader/jquery.fileupload
//= require_tree ./fix
//= require init_scopes
//= require titles_operation
//= require sidebar_menu
//= require custom_radio
//= require avatar_uploader
//= require slidebars.min
//= require autocompletes

// init code should be placed here
$(document).on('ready page:load', function(event) {
    new App.Utils.SidebarMenu();
    new App.Utils.CustomRadio();
    new App.User.AvatarUploader();
    App.Utils.Autocompletes.initAllFields()
    // Init bootstrap tooltips
    $('[data-toggle="tooltip"]').tooltip();
    var slideBars = new $.slidebars();

    $('body').on('click', '.sb-toggle-left-custom', function(){
      slideBars.slidebars.toggle('left');
      true
    });

    $(document).on('page:update', function(e){
      $('[data-toggle="tooltip"]').not(['data-original-title']).tooltip();

    });

});

