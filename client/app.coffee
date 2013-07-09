Photos = new Meteor.Collection "photos"
Species = new Meteor.Collection "species"

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
  'submit .new-species': (e,t) ->
    e.preventDefault()
    
    if Species.find(name: t.find('.species-input').value).count()
      alert "Species already exists! Please select it from the list"
    else
      Species.insert
        name: t.find('.species-input').value
        value: "#"
      console.log t.find('.species-input')
      t.find('.species-input').value = ''

  'click .suggest': (e,t) ->
    cssId =  e.currentTarget.getAttribute('id')
    Session.set "suggest", cssId.substring cssId.indexOf(' ') + 1
    
        
Template.main.photos = ->
  Photos.find()

Template.main.beespecies = ->
  Species.find()

Template.main.suggest = ->
  Session.equals "suggest", this._id



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