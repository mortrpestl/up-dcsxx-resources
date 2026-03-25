from model import Model
from view import View
from controller import Controller 

ctr = Controller(Model(), View())

ctr.run()