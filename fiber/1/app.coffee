# Display real statusbar with time & day of the week
weekday = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

setTime = () ->
	date = new Date
	day = date.getDay()
	minute = date.getMinutes()
	hour = date.getHours()
	
	if hour < 10
		hour = '0' + hour 
	
	if minute < 10
		minute = '0' + minute 
		
	statusBarTime.text = "#{hour}:#{minute}"
	CurrentDate.text = weekday[day];
	
	Utils.delay 30, ->
		setTime()
		
setTime()

# Set up ScrollComponent
scroll = new ScrollComponent
	y: Header.height
	parent: Home
	scrollHorizontal: false
	width: Screen.width
	height: Screen.height - Header.height - TabBar.height

scroll.sendToBack()
Feed.parent = scroll.content

# Scroll the content back to its original position when tapping the status bar
statusBar.onTap ->
	scroll.scrollToPoint(x: 0, y: 0)

