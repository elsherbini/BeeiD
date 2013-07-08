Photos = new Meteor.Collection "photos"

Template.main.events = 
  'click #upload': (e,t) ->
    filepicker.getFile 'image/*', multiple: true, persist: true, (uploads) ->
      _.each uploads, (image) ->
        console.log(image)
        Photos.insert
          user: Meteor.user()
          name: image.data.filename
          url: image.url
          time: (new Date).getTime()
    $(".bee-species").select2({})
        
Template.main.photos = ->
  Photos.find()

Template.main.beespecies = ->
  speciesList = d3.set []

  Photos.find().fetch().forEach (p) ->
    p.beespecies?.forEach (s) ->
      unless speciesList.has s.name
        speciesList.add s.name

  return speciesList.values()



AppRouter = Backbone.Router.extend
  routes:
    "": "main"
    "set/:name": "set"

  main:  ->
    Session.set "set", null
    
  set: (name) ->
    Session.set "set", name    
    
Router = new AppRouter

Meteor.startup ->  
  filepicker.setKey 'AMV2CxrmpRyqOfsE9qJIAz'
  Backbone.history.start pushState: true 
  $(".bee-species").select2({})