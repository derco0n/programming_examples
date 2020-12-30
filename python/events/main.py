from class_that_has_events import hasEvents


class ev_main:

    def handler_1(self):
        """ Method that handles event 1 """
        print("Event 1 raised.")

    def handler_2(self):
        """ Method that handles event 2 """
        print("Event 2 raised.")

    def __init__(self):
        self.evclass = hasEvents()

        # Register handlers
        self.evclass.events.on_event1 += self.handler_1
        self.evclass.events.on_event2 += self.handler_2

        self.start()

    def start(self):
        self.evclass.willraise1()  # call to raise event 1
        self.evclass.willraise2()  # call to raise event 2
