World = class()

--Create world that is width x height
function World:init(reid, w, h)
    -- set Reid
    self.reid = reid
    -- an empty array for blocks
    self.blocks = {}
    -- an empty array for walls
    self.walls = {}
    -- an empty array for monsters
    self.monsters = {}
    -- an empty array for loot
    self.loot = {}
    
    -- loop through for width
    for x = 1,w do
        -- create a new array for blocks on the x axis
        self.blocks[x] = {}
        -- do the same for height
        for y = 1,h do
            -- set tile type as FLOOR
            t = FLOOR
            -- set walls
            if math.random() < 0.1 or x == 1 or y == 1
                or x == w or y == h then
                t = WALL
            end
            
            -- create a block at x,y in the array
            self.blocks[x][y] = WorldBlock(t,x,y)
            
            -- if the type is wall, insert into the walls array and records
            -- the wall's position in blocks array
            if t == WALL then
                table.insert(self.walls, self.blocks[x][y])
            else
                --otherwise generate random numbers to set loot or monster
                if math.random() < 0.06 then
                    table.insert(self.loot, Loot(self.blocks[x][y].actualPosition))
                        
                elseif math.random() < 0.05 then
                    table.insert(self.monsters, Monster(reid, self.blocks[x][y].actualPosition))
                        
                end
            end
            -- set tint for blocks around walls
            if (x == 2 or y == 2 or x == w-1 or y == h-1)
                and t == FLOOR then
                --self.blocks[x][y].tint = color(230, 201, 201, 255)
            end
        end
    end
end
-- get point for collisions (probably won't need this)
function World:isColliding(point)
    -- for all the items in walls array return true if wall, otherwise return false
    for i,v in ipairs(self.walls) do
        if v:isColliding(point) then
            return true
        end
    end
    
    return false
end

function World:draw()
    -- loop through all blocks on y axis
    for y = #self.blocks[1],1,-1 do
        -- draw blocks on x axis
        for x = 1,#self.blocks do
            self.blocks[x][y]:draw()
        end
        
    end
    
    --
    for i,m in ipairs(self.loot) do
        if m:collect(self.reid.position) then
            --self.reid.attackPower = self.reid.attackPower + 0.5
        end
        m:draw()
    end
    
    for i,m in ipairs(self.monsters) do
        m:draw()
    end
    
    
    
end

function World:spawnMonster()
    monstPos = vec2(math.random(WIDTH/2,WIDTH),math.random(HEIGHT))
   table.insert(self.monsters, Monster(reid, monstPos))
end

function World:spawnLoot()
    lootPos = vec2(math.random(WIDTH-30), math.random(HEIGHT-30))
    table.insert(self.loot, Loot(lootPos))
end

function World:touched(touch)
    -- Codea does not automatically call this method
end
