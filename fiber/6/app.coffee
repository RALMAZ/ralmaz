# Save scroll start position for calculations 
scrollStart = Header.maxY - 20

# Set up ScrollComponent
scroll = new ScrollComponent
	parent: Home
	scrollHorizontal: false
	size: Screen.size
	contentInset:
		top: scrollStart
	
scroll.sendToBack()
Feed.parent = scroll.content

# Collapse header based on scroll position
scroll.onMove (event) ->
	range = [scrollStart, 50]
	Header.y = Utils.modulate(event.y, range, [40, 20], true)
	Header.height = Utils.modulate(event.y, range, [94, 60], true)
	HeaderNew.opacity = Utils.modulate(event.y, range, [1, 0], true)
	HeaderDay.fontSize = Utils.modulate(event.y, range, [36, 18], true)
	HeaderBackground.opacity = Utils.modulate(event.y, range, [0, 1], true)

# Hide Tab Bar
TabBar.states = 
	hide:
		y: 668
	animationOptions:
		time: .2

scroll.onScroll ->
	if scroll.direction is "down"
		TabBar.animate "hide"
	
	if scroll.direction is "up"
		TabBar.animate "default"