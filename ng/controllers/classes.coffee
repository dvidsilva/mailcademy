MailCademy.controller('Class', ['$scope','Settings', 'angularFire', Class = ($scope,Settings, angularFire) ->
  $scope.classes = []
  console.log Settings
  $scope.classes = angularFire(new Firebase(Settings.Url+'/classes'), $scope, 'classes')
  console.log $scope
])

