var App, MailCademy;

MailCademy = angular.module('MailCademy', ['firebase', 'ngRoute']);

angular.module('App', ['MailCademy', 'ngRoute', 'ngResource', 'ngAnimate', 'ek.Sizzle', App = function() {}]);

MailCademy.constant('Settings', {
  Views: 'ng/views/',
  Server: '/v1',
  Url: 'https://mailcademy.firebaseio.com/'
});

MailCademy.constant('Site', {
  ImgFolder: '/assets/images'
});

MailCademy.config(function($sceDelegateProvider) {
  $sceDelegateProvider.resourceUrlWhitelist(['self', 'https://www.youtube.com/**']);
});

MailCademy.config([
  '$routeProvider', 'Settings', function($routeProvider, Settings) {
    $routeProvider.when('/', {
      templateUrl: Settings.Views + 'pages/home.html',
      controller: 'App'
    }).when('/classes', {
      templateUrl: Settings.Views + 'classes/list.html',
      controller: 'Class'
    }).when('/messages', {
      templateUrl: Settings.Views + 'messages/list.html',
      controller: 'Message'
    }).when('/mails', {
      templateUrl: Settings.Views + 'mails/list.html',
      controller: 'Mail'
    }).when('/lists', {
      templateUrl: Settings.Views + 'lists/list.html',
      controller: 'List'
    }).otherwise({
      redirectTo: '/page/home'
    });
    return true;
  }
]);

MailCademy.directive('navMenu', function($location) {
  var currentLink, urlMap;
  urlMap = [];
  currentLink = '';
  return function(scope, element, attrs) {
    var link, links, _i, _len;
    scope.messagescount = 3;
    links = element.find('a');
    for (_i = 0, _len = links.length; _i < _len; _i++) {
      link = links[_i];
      urlMap[link.getAttribute('href')] = link;
    }
    return scope.$on('$routeChangeStart', function() {
      var pathLink;
      pathLink = urlMap['/#' + $location.path()];
      if (pathLink) {
        if (currentLink) {
          currentLink.parentElement.classList.remove('active');
        }
        currentLink = pathLink;
        return currentLink.parentElement.classList.add('active');
      }
    });
  };
}).directive('breadcrumb', function($location) {
  return function(scope, element, attrs) {
    scope.link = '';
    scope.text = '';
    return scope.$on('$routeChangeStart', function() {
      scope.link = $location.path();
      return scope.text = $location.path().replace('/', '');
    });
  };
});

var Class;

MailCademy.controller('Class', [
  '$scope', 'Settings', 'angularFire', Class = function($scope, Settings, angularFire) {
    $scope.classes = [];
    console.log(Settings);
    $scope.classes = angularFire(new Firebase(Settings.Url + '/classes'), $scope, 'classes');
    return console.log($scope);
  }
]);
