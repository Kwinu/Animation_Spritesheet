-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

function love.load()
    --appel de la fonction d animation
    anim8 = require "librairies/anim8"
    love.graphics.setDefaultFilter("nearest", "nearest")

    player = {}
    player.x = 0
    player.y = 0
    player.speed = 5
    player.spriteSheet = love.graphics.newImage("sprite/player-sheet.png")

    --creer une grille de chaque element du sprite sheet
    player.grid = anim8.newGrid(12, 18, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())
    -- defini chaque element pour chaque ligne de la direction
    player.animations = {}
    player.animations.down = anim8.newAnimation(player.grid("1-4", 1), 0.2)
    player.animations.up = anim8.newAnimation(player.grid("1-4", 4), 0.2)
    player.animations.left = anim8.newAnimation(player.grid("1-4", 2), 0.2)
    player.animations.right = anim8.newAnimation(player.grid("1-4", 3), 0.2)
    -- donne un position de depart
    player.anim = player.animations.down
end

function love.update(dt)
    --verifier si le player bouge 1/2
    local isMoving = false

    --intaure les directions avec les boutons et l animation correspondante
    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed
        player.anim = player.animations.right
        isMoving = true
    end
    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed
        player.anim = player.animations.left
        isMoving = true
    end
    if love.keyboard.isDown("up") then
        player.y = player.y - player.speed
        player.anim = player.animations.up
        isMoving = true
    end
    if love.keyboard.isDown("down") then
        player.y = player.y + player.speed
        player.anim = player.animations.down
        isMoving = true
    end
    --verifier si le player bouge 2/2
    if isMoving == false then
        player.anim:gotoFrame(2)
    end
    -- rappelle de l animation sur le dt
    player.anim:update(dt)
end

function love.draw()
    --dessine le spritesheet
    player.anim:draw(player.spriteSheet, player.x, player.y, nil, 2, 2)
end

function love.keypressed(key)
end
