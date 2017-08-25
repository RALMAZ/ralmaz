# Toggle the slider between an 'On' And 'Off' state
ToggleSelect.states = 
	disabled:
		x: 1
	animationOptions:
		time: .75
		curve: Spring (damping: 0.7)
			
ToggleBackground.states = 
	disable:
		scale: 0
		opacity: 0
		backgroundColor: "#CCC"
	animationOptions:
		time: .75
		curve: Spring (damping: 0.6)
			
Toggle.onTap (event, layer) ->
	ToggleSelect.stateCycle()
	ToggleBackground.stateCycle()