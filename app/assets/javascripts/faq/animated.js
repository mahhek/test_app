

animatedcollapse.addDiv('1-1', 'fade=0,speed=400,group=cats,hide=1')
animatedcollapse.addDiv('1-2', 'fade=0,speed=400,group=cats,hide=1')
animatedcollapse.addDiv('1-3', 'fade=0,speed=400,group=cats,hide=1')
animatedcollapse.addDiv('1-4', 'fade=0,speed=400,group=cats,hide=1')
animatedcollapse.addDiv('1-5', 'fade=0,speed=400,group=cats,hide=1')
animatedcollapse.addDiv('1-6', 'fade=0,speed=400,group=cats,hide=1')
animatedcollapse.addDiv('1-7', 'fade=0,speed=400,group=cats,hide=1')
animatedcollapse.addDiv('1-8', 'fade=0,speed=400,group=cats,hide=1')

animatedcollapse.ontoggle=function($, divobj, state){ //fires each time a DIV is expanded/contracted
	//$: Access to jQuery
	//divobj: DOM reference to DIV being expanded/ collapsed. Use "divobj.id" to get its ID
	//state: "block" or "none", depending on state
}

animatedcollapse.init()
