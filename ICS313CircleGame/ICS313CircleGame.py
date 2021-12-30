#Shawn Anthony
#ICS 313
#Fall 2021
#Biagioni
#Homework 7 Circle Game

import pygame, random

#Setting Variables
SCREEN_WIDTH = 480
SCREEN_HEIGHT = 480
FPS = 30

PROJECTILE_SPAWN_RATE = 7
PROJECTILE_SPEED = 5

PLAYER_SIZE = 18

BG_COLOR = pygame.Color("black")
UNIT_COLOR = pygame.Color("white")
TEXT_COLOR = pygame.Color("red")

#Player Class that creates a player instance to handle collision and movement
class Player:
    #Generic init function to create player and assign variables 
    def __init__(self):
        self.size = PLAYER_SIZE
        self.color = UNIT_COLOR
    
    #Draw function that draws a circle overlayed on a square to handle collision
    #Causes the very edge of the circle to not have collision, much like older sprite based games 
    def draw(self, surface):
        r = self.get_rect()
        pygame.draw.rect(surface, BG_COLOR, r)
        pygame.draw.circle(surface, self.color, pygame.mouse.get_pos(), self.size)
    
    #Rect function to handle movement and position of the collision rectangle
    def get_rect(self):
        x, y = pygame.mouse.get_pos()
        return pygame.Rect((x - 14, y - 14), (28, 28))
    
    #Collision function that uses built in rect collision function
    def collision(self, rect):
        r = self.get_rect()
        return r.colliderect(rect)

#Enemy class which handles logic for creating enemy instances to allow for multiple to exist at once
class Enemy:
    #Generic init call with local variables
    def __init__(self):
        self.size = 48
        self.speed = PROJECTILE_SPEED
        self.color = UNIT_COLOR
        self.variance = random.uniform(-1.75, 1.75)
        self.side = random.randint(1, 4) #Randomize side of spawns, 1 is top, 2 is bottom, 3 is left, 4 is right

        #Handle randomizing side that each projectile spawns on 
        if self.side == 1:
            self.position = (random.randint(0, SCREEN_WIDTH - self.size), 0 - self.size)
        elif self.side == 2:
            self.position = (random.randint(0, SCREEN_WIDTH - self.size), SCREEN_HEIGHT + self.size)
        elif self.side == 3:
            self.position = (0 - self.size, random.randint(0, SCREEN_HEIGHT - self.size))
        elif self.side == 4:
            self.position = (SCREEN_WIDTH + self.size, random.randint(0, SCREEN_HEIGHT - self.size))
        
    #Draws the rect on every frame 
    def draw(self, surface):
        r = self.get_rect()
        pygame.draw.rect(surface, self.color, r)

    #Handles movement based on speed in forward direction, as well as variance in trajectory
    #Learned late in this assignment that pygame does not handle rectangles rotated by other 
    #libraries well at all, did not have time to figure out how to do diagonals using lines after
    #learning that fact, and attempting to use a mesh for circle collision which was far more
    #complex than expected
    def move(self):
        if self.side == 1:
            self.position = (self.position[0] + self.variance, self.position[1] + self.speed)
        elif self.side == 2:
            self.position = (self.position[0] + self.variance, self.position[1] - self.speed)
        elif self.side == 3:
            self.position = (self.position[0] + self.speed, self.position[1] + self.variance)
        elif self.side == 4:
            self.position = (self.position[0] - self.speed, self.position[1] + self.variance)

    #Cleans up projectiles after they leave the screen in any direction
    def offscreen(self):
        if self.side == 1:
            return self.position[1] > SCREEN_HEIGHT + self.size
        elif self.side == 2:
            return self.position[1] < -self.size
        elif self.side == 3:
            return self.position[0] < -self.size
        elif self.side == 4:
            return self.position[0] > SCREEN_WIDTH + self.size

    #Creates a line Rect to be used to draw to the surface
    def get_rect(self):
        if self.side == 1 or self.side == 2:
            return pygame.Rect(self.position, (1, self.size))
        else:
            return pygame.Rect(self.position, (self.size, 1))

#World Class to handle an instance of playing the game
class World:
    def __init__(self):
        self.reset()

    #Reset logic to set variables to default
    def reset(self):
        self.gameover = False
        self.score = 0
        self.player = Player()
        self.lines = []
        self.enemy_timer = 0

    #Checks if game is over
    def is_gameover(self):
        return self.gameover

    #Update function 
    def update(self):
        self.score += 1

        #Calls move function of enemy, and checks for collision between enemy and player
        for e in self.lines:
            e.move()
            if self.player.collision(e.get_rect()):
                self.gameover = True
            
            #Removes projectiles once they leave the visible screen
            if e.offscreen():
                self.lines.remove(e)
        
        #Handles creation and tracking of multiple projectiles
        self.enemy_timer += 1
        if self.enemy_timer > PROJECTILE_SPAWN_RATE:
            self.enemy_timer = 0
            self.lines.append(Enemy())
    
    #Draws units onto the world surface
    def draw(self, surface):
        self.player.draw(surface)
        for e in self.lines:
            e.draw(surface)

#Main run function, initializes instances and starts the game
def run(): 
    pygame.init()
    
    clock = pygame.time.Clock()
    screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
    pygame.display.set_caption("Circle Game")

    surface = pygame.Surface(screen.get_size())
    surface = surface.convert()

    world = World()
    
    font = pygame.font.SysFont("Arial", 20)

    #Main game loop
    running = True
    while running:
        
        #Handle ending of game and restarting 
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                    running = False
            elif event.type == pygame.KEYDOWN and event.key == pygame.K_ESCAPE:
                running = False
            elif event.type == pygame.KEYDOWN and event.key == ord("r"):
                world.reset()

        #Create time
        clock.tick(FPS)

        #Update until game over
        if not world.is_gameover():
            world.update()
        
        #Draw game to screen
        surface.fill(BG_COLOR)
        world.draw(surface)
        screen.blit(surface, (0, 0))
        text = font.render("Score {0}".format(world.score), 1, pygame.Color("white"))
        screen.blit(text, (5, 10))

        #Game over screen output for player
        if world.is_gameover():
            out = font.render("Game Over", 1, TEXT_COLOR)
            screen.blit(out, (180, SCREEN_HEIGHT / 2))
            reset = font.render("Press R to start over", 1, TEXT_COLOR)
            screen.blit(reset, (140, (SCREEN_HEIGHT / 2) + 40))

        pygame.display.update()

#Main
if __name__ == '__main__':
    run()
