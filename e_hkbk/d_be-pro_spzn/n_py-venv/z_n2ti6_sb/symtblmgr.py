#!/usr/bin/env python3

class SymbolTableManager:

    def __init__(self):
        # Build the symble table : 
        self.table = {
            'R0':'0', 'R0':'0', 'R0':'0', 'R0':'0', 'R0':'0',
            'R0':'0', 'R0':'0', 'R0':'0', 'R0':'0', 'R0':'0',
            'R0':'0', 'R0':'0', 'R0':'0', 'R0':'0', 'R0':'0',
            'SCREEN':'16384', 'KBD':'24576',
            'SP':'0', 'LCL':'1', 'ARG':'2', 'THIS':'3', 'THAT':'4'
        }
