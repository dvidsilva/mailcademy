MailCademy.controller('Class', ['$scope','$routeParams','Settings', 'angularFire', Class = ($scope,$routeParams,Settings, angularFire) ->
  ref = new Firebase(Settings.Url+'/')

  if $routeParams.messageid
    $scope.message = angularFire(ref.child($routeParams.slug).child('messages').child($routeParams.messageid), $scope, 'message')
  else if $routeParams.slug
    $scope.class = angularFire(ref.child($routeParams.slug), $scope, 'class')
    $scope.link = $routeParams.slug
  else
    $scope.classes = angularFire(ref, $scope, 'classes')

  switch $routeParams.action
    when 'emails' then console.log $routeParams.action
    when 'messages' then console.log $routeParams.action

  $scope.hash = (email)->
    if email isnt undefined
      md5(email.trim().toLowerCase())
    return

  $scope.color = (avg)->
    color = 'danger'
    if avg > 3
      color = 'warning'
    if avg > 4
      color = 'success'
    return color
])

MailCademy.filter "toArray", ()->
  return (obj) ->
    result = []
    angular.forEach obj, (val, key) ->
      console.log val
      val.id = key
      result.push(val)
    return result


