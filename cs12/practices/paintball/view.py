from model import Grid, PaintballStrategy, HorizontalShoot, SquareShoot, ColorFill, ColorState


class View:
    def grid(self, grid : Grid):
        print( '\n'.join(' '.join(x) for x in grid.grid_view()) )
        
    def welcome(self):
        print('Welcome to Paintball!')

    def ask_for_coord(self, grid : Grid):
        
        r : int 
        c : int
        r,c = -1,-1 
        
        while not grid.inb( (r,c) ):
            try: 
                r = int( input(f'Input row [0-{grid.r-1}]: ') )
                c = int( input(f'Input column [0-{grid.c-1}]: ') )
            except KeyboardInterrupt: 
                exit()
            except Exception: 
                continue
            
        return r,c

    def ask_for_strategy(self):
        resp = ''
        while resp not in [*'hsc']:
            resp = input('Choose strategy [h/s/c]: ')
            
        ans : PaintballStrategy
        
        match resp:
            case 'h':
                ans = HorizontalShoot()
            case 's':
                ans = SquareShoot()
            case _:
                ans = ColorFill()
                
        return ans
            
    def ask_for_color(self):
        resp = ''
        while resp not in [*'rgy']:
            resp = input('Choose a color [r/g/y]: ')
            
        ans : ColorState
        
        match resp:
            case 'r':
                ans = ColorState.RED
            case 'g':
                ans = ColorState.GREEN
            case _:
                ans = ColorState.YELLOW
                
        return ans
        
    def outcome(self, success : bool):
        return 'Success!' if success else 'Failed.'