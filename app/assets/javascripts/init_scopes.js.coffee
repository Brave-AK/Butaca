window.App or=
  Utils: {}
  Titles: {}
  User: {}
  isMobile: {
    Android: ()->
      navigator.userAgent.match(/Android/i);
    ,
    BlackBerry: ->
      navigator.userAgent.match(/BlackBerry/i);
    ,
    iOS: ->
      navigator.userAgent.match(/iPhone|iPad|iPod/i);
    ,
    Opera: ->
      navigator.userAgent.match(/Opera Mini/i);
    ,
    Windows: ->
      navigator.userAgent.match(/IEMobile/i);
    ,
    any: ->
      (App.isMobile.Android() || App.isMobile.BlackBerry() || App.isMobile.iOS() || App.isMobile.Opera() || App.isMobile.Windows());

};
