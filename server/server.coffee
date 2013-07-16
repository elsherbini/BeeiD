Species   = new Meteor.Collection "species"
Photos = new Meteor.Collection "photos"

Meteor.startup -> 
	Species.remove({})