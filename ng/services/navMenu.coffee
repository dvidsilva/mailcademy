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
).directive('breadcrumb', ($location) ->
  return (scope, element, attrs)->
    scope.link = ''
    scope.text = ''
    scope.$on('$routeChangeStart', () ->
      scope.link = $location.path()
      scope.text = $location.path().replace('/','')
    )
)

