# Main controller from where everything inherits
MailCademy = angular.module('MailCademy', ['firebase','ngRoute'])


angular.module('App', ['MailCademy','ngRoute','ngResource','ngAnimate','ek.Sizzle', App = ()->
  return
])
#https://github.com/herschel666/angular-sizzle
#https://daneden.me/animate/
#http://www.nganimate.org/angularjs/tutorial/how-to-make-animations-with-angularjs
#http://docs.angularjs.org/api/ngAnimate

disqus_shortname = 'mailcademy'

(() ->
    dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true
    dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js'
    (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
)()


chatRef = new Firebase('https://mailcademy.firebaseio.com/')
auth = new FirebaseSimpleLogin(chatRef, (error, user) ->
  if (error)
    console.log(error)
  else if (user)
    console.log('User ID: ' + user.id + ', Provider: ' + user.provider)
)

#auth.login('facebook', {
#  rememberMe: true,
#  scope: 'email,user_likes'
#})

