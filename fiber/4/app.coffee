# This function checks the required template info. The next button will only activate when all info is set.
validate = ->
	if  ProfileTitle.template isnt undefined and 
		ProfileTitle.template.Job isnt undefined and 
		ProfileTitle.template.Company isnt undefined
			Next.ignoreEvents = false
			Next.animate "default"
	else
		Next.ignoreEvents = true
		Next.animate "disabled"

# Set up click events for items in dropdown menu's 
# Dropdown 1 
for item in Content1.children
	item.onClick (event, layer) ->
		Title1.text = layer.text
		ProfileTitle.template = 
			Job: layer.text
			
		validate()
			
# Dropdown 2
for item in Content2.children
	item.onClick (event, layer) ->
		Title2.text = layer.text
		ProfileTitle.template = 
			Company: layer.text
			
		validate()

# Set up open / close behaviour for both dropdowns 
Dropdowns = [Dropdown1, Dropdown2]
for Dropdown in Dropdowns
	Dropdown.states = 
		closed:
			height: 54
		animationOptions:
			curve: Spring(damping: .7)
			time: .4
		
	Dropdown.stateSwitch("closed")
	Dropdown.onClick (event, layer) ->
		layer.animationOptions.time = .2
		for Dropdown in Dropdowns
			Dropdown.animate "closed"
			layer.childrenWithName("chevron")[0].animate
				rotation: 0
				options:
					time: .2
		
		layer.stateCycle()
		layer.childrenWithName("chevron")[0].animate
			rotation: 180
			options:
				time: .2

# Set up Profile View
Share.states.hide = 
	y: Share.y + 20
	opacity: 0

Next.states.disabled =
	opacity: .5

Next.onClick ->
	Cover.scale = 1
	Cover.animate
		scale: .8
		options:
			time: 2
			
	Share.animate "default"
	Flow.showNext(Step2)

Back.onClick ->
	Flow.showPrevious()

# Set up Flow Component and initial state
Share.stateSwitch "hide"
Next.stateSwitch "disabled"
Next.ignoreEvents = true
ProfileTitle.textTransform = "uppercase"

Flow = new FlowComponent
Flow.showNext(Step1)