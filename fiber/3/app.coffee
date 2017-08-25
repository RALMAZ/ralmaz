# Set default animation options
Framer.Defaults.Animation = 
	curve: Spring(damping: .5)
	time: 1

# Set states 
Like.states = 
	small:
		scale: .8
		color: "#FFF"
	liked:
		scale: .8

Amount.states.hide =
	y: -15
	opacity: 0

NewAmount.states.hide =
	y: 0
	opacity: 1
	
Like.stateSwitch("small")
 
Like.onClick ->
	
	# Check the current state and animate
	if Like.states.current.name isnt "liked"
		Like.animate "default"
		Amount.animate "hide"
		NewAmount.animate "hide"
		Like.ignoreEvents = true
		
		Utils.delay 1, ->
			Like.ignoreEvents = false
			Like.animate "liked"
			
	else
		Like.animate "small"
		Amount.animate "default"
		NewAmount.animate "default"