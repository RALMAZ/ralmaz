# States for visual animations

Phone.states.hide = 
	opacity: 0
	y: 60
	
Phone.states.show = 
	opacity: 1
	y: 40
	options: 
		time: 1

Mac.states.hide = 
	opacity: 0
	y: 30

Mac.states.show = 
	opacity: 1
	y: 5
	options: 
		time: 1
		delay: 0.1

Message1.states.hide = 
	opacity: 0
	y: 230

Message1.states.show = 
	opacity: 1
	y: 200
	options: 
		time: 1

Message2.states.hide = 
	opacity: 0
	y: 310

Message2.states.show = 
	opacity: 1
	y: 300
	options: 
		time: 1
		delay: 0.2

Photo1.states.hide = 
	opacity: 0
	x: 155
	y: 210
	rotation: 0

Photo1.states.show = 
	opacity: 1
	x: 120
	y: 210
	rotation: -15
	options: 
		time: 1
	
Photo2.states.hide = 
	opacity: 0
	x: 165
	y: 225
	rotation: 0
	
Photo2.states.show = 
	opacity: 1
	x: 200
	y: 230
	rotation: 15
	options: 
		time: 1

# Set default animation options
Framer.Defaults.Animation =
	time: 2
	curve: Spring(damping: 0.65) 

# Set up FlowComponent
flow = new FlowComponent
flow.showNext(Welcome)

statusBar.parent = null
IndicatorDots.parent = null

# Switch on click
GetStarted.onClick ->
	flow.showNext(OnboardingConnect)

# Switch on click
ConnectNext.onClick ->
	flow.showNext(OnboardingChat)

ChatBack.onClick ->
	flow.showPrevious()
	
ChatNext.onClick ->
	flow.showNext(OnboardingShare)

ShareBack.onClick ->
	flow.showPrevious()

Restart.onClick ->
	flow.showNext(OnboardingConnect)

# Start Welcome screen animations

# Set initial state for logo and start button
for layer in [Fiber, logo1, logo2, logo3, GetStarted]
	layer.opacity = 0

# Logo animation 
logo1.animate
	opacity: 1
	y: 53
	rotation: 45
	options:
		delay: 0.5

logo2.animate
	opacity: 1
	y: 29
	rotation: 45
	options:
		delay: 0.7

logo3.animate
	opacity: 1
	y: 5
	rotation: 45
	options:
		delay: 0.8
		
# Animate the title and start button in when the last logo piece animates
logo3.onAnimationStart ->
	Fiber.animate
		opacity: 1
		y: 390
			
	GetStarted.animate
		opacity: 1
		y: 530
		options: 
			delay: 0.5

IndicatorDots.opacity = 0
activateDot = (index) ->
	IndicatorDots.children[index].animate
		opacity: 1
		scale: 1.1	

# Fires right after the Flow Component changes a page 
flow.onTransitionEnd ->
	for layer in [Phone, Mac, Message1, Message2, Photo1, Photo2]
		layer.stateSwitch("hide")
		
	for dot in IndicatorDots.children
		dot.animate
			opacity: 0.5
			scale: 1
	
	if flow.current is OnboardingConnect
		Phone.animate("show")
		Mac.animate("show")
		activateDot(0)
	
	if flow.current is OnboardingChat
		Message1.animate("show")
		Message2.animate("show")
		activateDot(1)
	
	if flow.current is OnboardingShare
		Photo1.animate("show")
		Photo2.animate("show")
		activateDot(2)
	
	# Show indicator dots after welcome screen
	if flow.current isnt Welcome
		IndicatorDots.animate
			opacity: 1
			options: 
				time: 0.3