Progress.animate
	width: 242
	options:
		time: 24
		curve: Bezier.linear

# Format the video timer to minutes
TotalTime.templateFormatter = (seconds) ->
	minutes = Math.floor(seconds / 60)
	seconds = Math.round(seconds % 60)
	if seconds < 10 then seconds = "0#{seconds}"
	return "#{minutes}:#{seconds}"

TotalTime.transform = (value) =>
	toMinutes(value)

TotalTime.animate
	template:
		time: 24
	options:
		time: 24
		curve: Bezier.linear

# Set up video 
Video = new VideoLayer
	video: "images/video.mp4"
	size: VideoContainer.size

Video.parent = VideoContainer
Video.sendToBack()
Video.player.autoplay = true

# Set up scroll 
Scroll = new ScrollComponent
	height: Screen.height - Video.height - Write.height
	width: Screen.width
	y: Video.height
	scrollHorizontal: false

Content.parent = Scroll.content

# Show the reply icon when dragging Jess' to the right post on the video screen
Reply.scale = 0.5
Reply.opacity = 1

JessPost.draggable.enabled = true
JessPost.draggable.vertical = false
JessPost.directionLock = true
JessPost.draggable.constraints =
	x: 20
	width: 200
	height: 200

JessPost.onMove ->
	Reply.scale = Utils.modulate this.x, [20, 120], [0.5, 1], true