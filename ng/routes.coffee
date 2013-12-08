MailCademy.config( ['$routeProvider','Settings', ($routeProvider, Settings)->
  $routeProvider
    .when('/', {templateUrl: Settings.Views + 'pages/home.html', controller: 'App'})
    .when('/classes', {templateUrl: Settings.Views + 'classes/list.html', controller: 'Class'})
    .when('/messages', {templateUrl: Settings.Views + 'messages/list.html', controller: 'Message'})
    .when('/mails', {templateUrl: Settings.Views + 'mails/list.html', controller: 'Mail'})
    .when('/lists', {templateUrl: Settings.Views + 'lists/list.html', controller: 'List'})
    .otherwise({redirectTo: '/page/home'})
  true
  ]
)


