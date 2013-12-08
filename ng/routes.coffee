MailCademy.config( ['$routeProvider','Settings', ($routeProvider, Settings)->
  $routeProvider
    .when('/', {templateUrl: Settings.Views + 'pages/home.html', controller: 'App'})
    .when('/notifications', {templateUrl: Settings.Views + 'messages/list.html', controller: 'Class'})
    .when('/classes', {templateUrl: Settings.Views + 'classes/list.html', controller: 'Class'})
    .when('/class/:slug/message/:messageid', {templateUrl: Settings.Views + 'classes/message.html', controller: 'Class'})
    .when('/class/:slug/:action', {
      templateUrl: (params)->
        return Settings.Views + 'classes/'+params.action+'.html'
      , controller: 'Class'})
    .when('/class/:slug', {templateUrl: Settings.Views + 'messages/list.html', controller: 'Class'})
    .otherwise({redirectTo: '/'})
  true
  ]
)


