MailCademy.controller('Class', Class = ($scope,$routeParams,Settings, angularFire, $sce) ->
  ref = new Firebase(Settings.Url + '/')

  if $routeParams.messageid
    single = true
    angularFire(ref.child($routeParams.slug).child('messages').child($routeParams.messageid), $scope, 'message')
    $scope.link = $routeParams.slug
  else if $routeParams.slug
    angularFire(ref.child($routeParams.slug), $scope, 'class')
    $scope.link = $routeParams.slug
  else
    angularFire(ref, $scope, 'classes')

  if $routeParams.action is 'homeworks'
    angularFire(ref.child($routeParams.slug).child('homeworks'), $scope, 'homeworks')
    $scope.link = $routeParams.slug



  switch $routeParams.action
    when 'emails' then console.log $routeParams.action
    when 'messages' then console.log $routeParams.action

  $scope.hash = (email)->
    if email isnt undefined
      return md5(email.replace(/.*<|>.*/g, '').trim().toLowerCase())
    return

  if single
    $scope.sendReview = ()->
      $scope.message.reviews.push({email: $scope.email, value: $scope.grade, notes: $scope.notes})

  $scope.parse = (text)->
    return text.replace(/\r?\n/g, '<br>')

  $scope.getHtml = (message) ->
    message = message.text.replace(/\r|\n/g, '<br>')
    message = message.replace(/&NewLine;/g, '\n')
    message = message.replace(/(\nOn (?:Mon|Tue|Wed|Thu|Fri|Sat|Sun)(,|&comma;)[^\n]+(?:\n[^\n]+){1,2}(?:\n&gt;[^\n]+)+\n?$)/, '<a class="showMore">...</a><div class="hideMore">$1</div>')
    return $sce.trustAsHtml(message)



  $scope.average = (avg)->
    if typeof(avg) is 'undefined'
      return '?'
    return avg

  $scope.color = (avg)->
    color = 'danger'
    if avg > 3
      color = 'warning'
    if avg > 4
      color = 'success'
    return color
)

MailCademy.filter "toArray", ()->
  return (obj) ->
    result = []
    angular.forEach obj, (val, key) ->
      console.log val
      val.id = key
      result.push(val)
    return result


