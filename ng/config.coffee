# I have two config constants, with two different scopes
# one meant to be used across controllers and the application and
# an another one that will be delegated to the rootscope
# The first one is meant to be secretive and can hold passwords, urls
# and the sort, while the other one will be more publicly
# available
MailCademy.constant 'Settings', {
    Views: 'ng/views/'
    Server: '/v1'
    Url: 'https://mailcademy.firebaseio.com/'
  }

MailCademy.constant 'Site', {
    ImgFolder: '/assets/images'
  }


MailCademy.config(($sceDelegateProvider)->
  $sceDelegateProvider.resourceUrlWhitelist([
    'self','https://www.youtube.com/**'
  ])
  return
)

