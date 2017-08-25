# Set up default loading options 
Framer.Defaults.Animation.time = .4
loading = false

# Set up ScrollComponent
scroll = new ScrollComponent
	parent: Home
	scrollHorizontal: false
	clip: false
	size: Screen.size
	y: 20

# Set up states 
Loader.states = 
	hidden:
		opacity: 0
		height: 40
	loading:
		height: 100
		
Feed.states.loading =
	y: 100

Feed.parent = scroll.content
Loader.stateSwitch("hidden")

# Set up load animation 
for circle, i in Loader.children
	circle.states =
		big:
			scale: 1
		small:
			scale: .5
			
	circle.stateSwitch("small")
	circle.onAnimationEnd (event, layer) ->
		if layer.states.current.name is "big"
			layer.animate "small"
		else if loading
			Utils.delay 1, -> layer.animate "big"

loadAnimation = ->
	Loader.children[0].animate "big"
	Utils.delay .4, -> Loader.children[1].animate "big"
	Utils.delay .8, -> Loader.children[2].animate "big"
	Utils.delay 1.2, -> Loader.children[3].animate "big"
	
stopLoadAnimation = ->
	for circle in Loader.children
		circle.stateSwitch("small")

# Collapse header based on scroll position
scroll.onMove (event) ->
	if !loading
		range = [0, 100]
		Loader.height = event.y
		Loader.opacity = Utils.modulate(event.y, range, [0, 1])
		
		for circle, i in Loader.children
			start = i * 25
			circle.opacity = Utils.modulate(event.y, [start, start + 25], [0, 1], true)
			
scroll.onScrollEnd ->
	
	# If dragged beyond 100 pixels, start loading animation
	if scroll.scrollY < -100
		loading = true
		loadAnimation()
		Loader.animate "loading"
		Feed.animate "loading"
		scroll.content.ignoreEvents = true 	
		
		# Simulate refresh with delay and animate back		
		Utils.delay 4, ->
			Loader.animate "hidden"
			Feed.animate "default"
		
		# Stop loading animation and make feed scrollable again		
		Utils.delay 4.4, ->
			loading = false
			stopLoadAnimation()
			scroll.content.ignoreEvents = false