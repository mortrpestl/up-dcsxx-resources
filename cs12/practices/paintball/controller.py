from model import Model
from view import View

class Controller:
    def __init__(self,
                 model : Model,
                 view : View):
        self.model = model        
        self.view = view 
        
    def run(self):
        model, view = self.model, self.view 

        view.welcome()              
                
        while True:
            try:
                coord = view.ask_for_coord(model.grid) 
                strategy = view.ask_for_strategy()
                color = view.ask_for_color()
                
                
                print( view.outcome( model.paint(strategy, coord, color) ) )
                view.grid(model.grid)
                
            except KeyboardInterrupt:
                exit()
            except Exception as e:
                raise e
        
        