class App.User.AvatarUploader

  constructor: ->
    $('.profile-image-upload').on('click', 'a.upload-button', (e)->
      $('.profile-image-upload input').click()
    )
    jFileInput = $('.profile-image-upload input') 
    jFileInput.fileupload(
      dataType: 'json'
      formData: { }
      url: jFileInput.data('path')
      add: (e, data) =>
        @generatePreviewAndUpload(data)
      done: (e, data) =>
    )
        

  generatePreviewAndUpload: (uploadData)->
    loadImage(uploadData.files[0], (img)=>
      $('.profile-image-upload  img').attr('src',  img.toDataURL())
      uploadData.submit()
    , canvas: true)      