MailCademy.directive('navMenu', ($location) ->
  urlMap = []
  currentLink = ''
  return (scope, element, attrs) ->
    scope.messagescount = 3
    links = element.find('a')
    for link in links
      urlMap[link.getAttribute('href')] = link

    scope.$on('$routeChangeStart', () ->
      pathLink = urlMap['/#'+$location.path()]
      if (pathLink)
        if (currentLink)
          currentLink.parentElement.classList.remove('active')
        currentLink = pathLink
        currentLink.parentElement.classList.add('active')
    )
).directive('breadcrumb', ['$location',($location) ->
  return (scope, element, attrs)->
    scope.$on('$routeChangeStart', (event, next, current) ->
      scope.classes = false
      scope.class = false
      scope.action = false
      if next.params.slug
        scope.classes = true
        scope.class = next.params.slug
      if next.params.action
        scope.action = next.params.action
      if $location.path().match('classes')
        scope.classes = true
      return
    )
])

