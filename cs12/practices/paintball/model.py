from dataclasses import dataclass
from common_types import *
from enum import Enum
from typing import Protocol
from abc import abstractmethod, ABC

BulbState = Enum('BulbState', 'ON OFF')
ColorState = Enum('ColorState', 'RED GREEN YELLOW')

@dataclass
class Bulb:
    state : BulbState 
    color : ColorState

class Grid:
    def __init__(self, r : int = 6, c : int = 6):
        self.r : int = r
        self.c : int = c
        self.grid : GridT[Bulb] = self.init_grid()
   
    def inb(self, coord : Coord):
        r,c = coord
        return 0<=r<self.r and 0<=c<self.c
        
    def init_grid(self):
        return [ [Bulb(BulbState.OFF, ColorState.GREEN) for _ in range(self.c)] for _ in range(self.r) ]
        
    def grid_view(self) -> GridT[str]:
        corr : dict[ColorState, str] = {
            ColorState.RED : '🔴',
            ColorState.GREEN : '🟢',
            ColorState.YELLOW : '🟠',
        }
        
        return [[corr[x.color] for x in r] for r in self.grid]
    
class PaintballStrategy:
    def shoot_at_coord(self, coord : Coord, grid : Grid, color : ColorState) -> bool:
        ...
                
class HorizontalShoot:
    def shoot_at_coord(self, coord : Coord, grid : Grid, color : ColorState) -> bool:
        if not grid.inb(coord): return False 
        r,_ = coord
        
        for c in range(grid.c):
            grid.grid[r][c].color = color
            
        return True
    
class SquareShoot:
    def shoot_at_coord(self, coord : Coord, grid : Grid, color : ColorState) -> bool:
        if not grid.inb(coord): return False 
        r,c = coord
        
        coords = [
            (r+dr, c+dc)
            for dr in range(-2, 2+1)
            for dc in range(-2, 2+1)
            if abs(dr) == 2 or abs(dc) == 2
        ]
                
        for r,c in coords:
            if not grid.inb( (r,c) ): continue
            grid.grid[r][c].color = color
            
        return True
        
class ColorFill:
    def shoot_at_coord(self, coord : Coord, grid : Grid, color : ColorState) -> bool:
        
        if not grid.inb(coord): return False 
        r,c = coord
        
        coords : set[Coord] = set()
        vis : set[Coord] = set()
        
        drc = ((-1,0),(1,0),(0,1),(0,-1))
        
        orig_color = grid.grid[r][c].color 
        
        def dfs(_r : int, _c : int):
            stack = [(_r,_c)]
            
            while stack:
                r,c = stack.pop()
                coords.add((r,c))
                
                for dr,dc in drc:
                    ncoord = r+dr, c+dc
                    nr,nc = ncoord
                    if not grid.inb(ncoord): continue
                    if ncoord in vis: continue 
                    if orig_color != grid.grid[nr][nc].color: continue
                    
                    vis.add(ncoord)                    
                    stack.append(ncoord)
            
        dfs(r,c)
        
        for r,c in coords:
            if not grid.inb( (r,c) ): continue
            grid.grid[r][c].color = color
            
        return True
    
class Model: 
    def __init__(self):
        self.grid = Grid()
        
    def paint(self, strategy : PaintballStrategy, coord : Coord, color : ColorState):
        return strategy.shoot_at_coord(coord, self.grid, color)



