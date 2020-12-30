# import threading
from events import Events


class hasEvents():
	""" A class that has some events which could be raised"""
	
	def __init__(self):
		""" Constructor """
		self.events = Events(('on_event1', 'on_event2'))  # declare Events
	
	def willraise1(self):
		""" Demo-Method that will raise event 1..."""
		self.events.on_event1()  # This could be raised anywhere in every method in this class

	def willraise2(self):
		""" Demon-Method that will raise event 2..."""
		self.events.on_event2()  # This could be raised anywhere in every method in this class

