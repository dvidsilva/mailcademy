var App, MailCademy, auth, chatRef, disqus_shortname;

MailCademy = angular.module('MailCademy', ['firebase', 'ngRoute']);

angular.module('App', ['MailCademy', 'ngRoute', 'ngResource', 'ngAnimate', 'ek.Sizzle', App = function() {}]);

disqus_shortname = 'mailcademy';

(function() {
  var dsq;
  dsq = document.createElement('script');
  dsq.type = 'text/javascript';
  dsq.async = true;
  dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
  return (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
})();

chatRef = new Firebase('https://mailcademy.firebaseio.com/');

auth = new FirebaseSimpleLogin(chatRef, function(error, user) {
  if (error) {
    return console.log(error);
  } else if (user) {
    return console.log('User ID: ' + user.id + ', Provider: ' + user.provider);
  }
});

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
    }).when('/notifications', {
      templateUrl: Settings.Views + 'messages/list.html',
      controller: 'Class'
    }).when('/classes', {
      templateUrl: Settings.Views + 'classes/list.html',
      controller: 'Class'
    }).when('/class/:slug/message/:messageid', {
      templateUrl: Settings.Views + 'classes/message.html',
      controller: 'Class'
    }).when('/class/:slug/:action', {
      templateUrl: function(params) {
        return Settings.Views + 'classes/' + params.action + '.html';
      },
      controller: 'Class'
    }).when('/class/:slug', {
      templateUrl: Settings.Views + 'messages/list.html',
      controller: 'Class'
    }).otherwise({
      redirectTo: '/'
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
}).directive('breadcrumb', [
  '$location', function($location) {
    return function(scope, element, attrs) {
      return scope.$on('$routeChangeStart', function(event, next, current) {
        scope.classes = false;
        scope["class"] = false;
        scope.action = false;
        if (next.params.slug) {
          scope.classes = true;
          scope["class"] = next.params.slug;
        }
        if (next.params.action) {
          scope.action = next.params.action;
        }
        if ($location.path().match('classes')) {
          scope.classes = true;
        }
      });
    };
  }
]);

var Class;

MailCademy.controller('Class', [
  '$scope', '$routeParams', 'Settings', 'angularFire', Class = function($scope, $routeParams, Settings, angularFire) {
    var ref, single;
    ref = new Firebase(Settings.Url + '/');
    if ($routeParams.messageid) {
      single = true;
      $scope.message = angularFire(ref.child($routeParams.slug).child('messages').child($routeParams.messageid), $scope, 'message');
      $scope.link = $routeParams.slug;
    } else if ($routeParams.slug) {
      $scope["class"] = angularFire(ref.child($routeParams.slug), $scope, 'class');
      $scope.link = $routeParams.slug;
    } else {
      $scope.classes = angularFire(ref, $scope, 'classes');
    }
    switch ($routeParams.action) {
      case 'emails':
        console.log($routeParams.action);
        break;
      case 'messages':
        console.log($routeParams.action);
    }
    $scope.hash = function(email) {
      if (email !== void 0) {
        md5(email.trim().toLowerCase());
      }
    };
    if (single) {
      $scope.sendReview = function() {
        return $scope.message.reviews.push({
          email: $scope.email,
          value: $scope.grade,
          notes: $scope.notes
        });
      };
    }
    return $scope.color = function(avg) {
      var color;
      color = 'danger';
      if (avg > 3) {
        color = 'warning';
      }
      if (avg > 4) {
        color = 'success';
      }
      return color;
    };
  }
]);

MailCademy.filter("toArray", function() {
  return function(obj) {
    var result;
    result = [];
    angular.forEach(obj, function(val, key) {
      console.log(val);
      val.id = key;
      return result.push(val);
    });
    return result;
  };
});
