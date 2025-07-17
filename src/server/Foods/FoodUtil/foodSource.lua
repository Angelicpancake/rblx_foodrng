--[[
	TO DO:
	Set values to food obj instead of food name in tables with rarity or country key
]]

local CoreScriptDebuggingManagerHelper = game:GetService("CoreScriptDebuggingManagerHelper")
--[[
    source of truth for food
    return multiple dictionary tables for easy key access for sorting in inventory(cookbook)

    foodData
        foodList
        foodByRarity
        foodByCountry
]]
local foodData = {}

--derived tables
foodData.foodByRarity = {}
foodData.foodByCountry = {}
--fusions

type fusionObj = {
	name: string,
	rarity: string,
	country: string,
}

type foodObj = {
	rarity: string,
}

local fusionList: { fusionObj } = {
	["100-Year Soy Sauce|Ramen"] = { name = "Naruto’s Ichiraku Ramen", rarity = "Mythical", country = "Japan" }, --fusion
	["Gimbap|Onigiri|White Rice"] = { name = "Bizzarre Onigiri", rarity = "Mythical", country = "Japan" }, --fusion
	["Jam|Waffle|Wagashi Jelly"] = { name = "Slime Waffle", rarity = "Mythical", country = "USA" },
	["Mapo Tofu|Sundubu|Spicy God Ramyeon"] = { name = "Arise Sundubu", rarity = "Mythical", country = "Korea" },
	["Baozi|Kimchi|Osechi Ryori"] = { name = "MC Dumpling", rarity = "Mythical", country = "China" },
	["Gabagool Requiem|NYC Pizza|Whale Sashimi"] = {
		name = "Tralalero Tralala Cappuccino Assassino",
		rarity = "Mythical",
		country = "Italy",
	},
	--{ name = "", rarity = "", country = "" }
}
foodData.fusionList = fusionList

local foodList: { foodObj } = {
	--japanese foods
	["Ramen"] = { rarity = "Common", country = "Japan" },
	["Onigiri"] = { rarity = "Common", country = "Japan" },
	["Miso Soup"] = { rarity = "Common", country = "Japan" },
	["Tamagoyaki"] = { rarity = "Common", country = "Japan" },
	["White Rice"] = { rarity = "Common", country = "Japan" },
	["Udon"] = { rarity = "Common", country = "Japan" },
	["Takoyaki"] = { rarity = "Uncommon", country = "Japan" },
	["Okonomiyaki"] = { rarity = "Uncommon", country = "Japan" },
	["Ochazuke"] = { rarity = "Uncommon", country = "Japan" },
	["Matcha Ice Cream"] = { rarity = "Uncommon", country = "Japan" },
	["Kinako Mochi"] = { rarity = "Uncommon", country = "Japan" },
	["Fugu"] = { rarity = "Rare", country = "Japan" },
	["Basashi"] = { rarity = "Rare", country = "Japan" },
	["Uni"] = { rarity = "Rare", country = "Japan" },
	["Sakura Mochi"] = { rarity = "Rare", country = "Japan" },
	["Shirasu Don"] = { rarity = "Rare", country = "Japan" },
	["Kobe Beef"] = { rarity = "Epic", country = "Japan" },
	["Kaiseki"] = { rarity = "Epic", country = "Japan" },
	["Osechi Ryori"] = { rarity = "Epic", country = "Japan" },
	["Ise Ebi"] = { rarity = "Epic", country = "Japan" },
	["Spirit Bento Box"] = { rarity = "Epic", country = "Japan" },
	["Whale Sashimi"] = { rarity = "Legendary", country = "Japan" },
	["Wagashi Jelly"] = { rarity = "Legendary", country = "Japan" },
	["Taiyaki"] = { rarity = "Legendary", country = "Japan" },
	["100-Year Soy Sauce"] = { rarity = "Legendary", country = "Japan" },
	["Pokemon Omurice"] = { rarity = "Mythical", country = "Japan" },
	["Spirited Castella Cake"] = { rarity = "Mythical", country = "Japan" },
	["Otaku Cup Ramen"] = { rarity = "Mythical", country = "Japan" },
	--usa foods
	["Sawsbucks CakePop"] = { rarity = "Common", country = "USA" },
	["CoCoste Hot Dog"] = { rarity = "Common", country = "USA" },
	["Jam"] = { rarity = "Common", country = "USA" },
	["MacRonald Burger"] = { rarity = "Uncommon", country = "USA" },
	["Brownies"] = { rarity = "Uncommon", country = "USA" },
	["Choco Chip Cookie"] = { rarity = "Uncommon", country = "USA" },
	["Oysters"] = { rarity = "Rare", country = "USA" },
	["NYC Pizza"] = { rarity = "Epic", country = "USA" },
	["MD Crab"] = { rarity = "Epic", country = "USA" },
	["Deep Dish Pizza"] = { rarity = "Legendary", country = "USA" },
	["Donut"] = { rarity = "Legendary", country = "USA" },
	["Waffle"] = { rarity = "Mythical", country = "USA" },
	--korea foods
	["Kimchi"] = { rarity = "Common", country = "Korea" },
	["Gimbap"] = { rarity = "Common", country = "Korea" },
	["Korean Fried Chicken"] = { rarity = "Common", country = "Korea" },
	["Tteokbokki"] = { rarity = "Common", country = "Korea" },
	["Bulgogi"] = { rarity = "Uncommon", country = "Korea" },
	["Japchae"] = { rarity = "Uncommon", country = "Korea" },
	["Bibimbap"] = { rarity = "Rare", country = "Korea" },
	["Seaweed Soup"] = { rarity = "Rare", country = "Korea" },
	["Yukhoe"] = { rarity = "Epic", country = "Korea" },
	["Jeon (savory pancake)"] = { rarity = "Epic", country = "Korea" },
	["Bingsu"] = { rarity = "Legendary", country = "Korea" },
	["Spicy God Ramyeon"] = { rarity = "Mythical", country = "Korea" },
	--italy foods
	["Spaghetti"] = { rarity = "Common", country = "Italy" },
	["Garlic Bread"] = { rarity = "Common", country = "Italy" },
	["Fettuccine Alfredo"] = { rarity = "Uncommon", country = "Italy" },
	["Arancini"] = { rarity = "Rare", country = "Italy" },
	["Porchetta"] = { rarity = "Epic", country = "Italy" },
	["Gabagool Requiem"] = { rarity = "Mythical", country = "Italy" },
	--china foods
	["Mantou"] = { rarity = "Common", country = "China" },
	["Baozi"] = { rarity = "Common", country = "China" },
	["Egg Fried Rice"] = { rarity = "Uncommon", country = "China" },
	["Hot Pot"] = { rarity = "Rare", country = "China" },
	["Xiaolongbao"] = { rarity = "Rare", country = "China" },
	["Mapo Tofu"] = { rarity = "Epic", country = "China" },
	["Celestrial MoonCake"] = { rarity = "Legendary", country = "China" },

	-- ["Baguette"] = { rarity = "Common", country = "France" },
	-- ["Crêpes"] = { rarity = "Uncommon", country = "France" },
	-- ["Onion Soup"] = { rarity = "Uncommon", country = "France" },
	-- ["Duck Confit"] = { rarity = "Rare", country = "France" },
	-- ["Escargot"] = { rarity = "Rare", country = "France" },
	-- ["Bouillabaisse"] = { rarity = "Epic", country = "France" },
	-- ["Macaron Tower"] = { rarity = "Legendary", country = "France" },
	-- ["Foie Gras en Croûte"] = { rarity = "Legendary", country = "France" },
	-- ["Phantom Soufflé"] = { rarity = "Mythical", country = "France" },
	-- ["Eternal Cheese Wheel"] = { rarity = "Mythical", country = "France" },
	-- ["Roti"] = { rarity = "Common", country = "India" },
	-- ["Basmati Rice"] = { rarity = "Common", country = "India" },
	-- ["Samosa"] = { rarity = "Uncommon", country = "India" },
	-- ["Paneer Tikka"] = { rarity = "Uncommon", country = "India" },
	-- ["Butter Chicken"] = { rarity = "Rare", country = "India" },
	-- ["Rogan Josh"] = { rarity = "Rare", country = "India" },
	-- ["Biryani"] = { rarity = "Epic", country = "India" },
	-- ["Chole Bhature"] = { rarity = "Epic", country = "India" },
	-- ["Tandoori Platter"] = { rarity = "Legendary", country = "India" },
	-- ["Rasmalai"] = { rarity = "Legendary", country = "India" },
	-- ["Naga Ghost Curry"] = { rarity = "Mythical", country = "India" },
	-- ["Tortilla"] = { rarity = "Common", country = "Mexico" },
	-- ["Quesadilla"] = { rarity = "Common", country = "Mexico" },
	-- ["Taco (Street Style)"] = { rarity = "Uncommon", country = "Mexico" },
	-- ["Elote (Street Corn)"] = { rarity = "Uncommon", country = "Mexico" },
	-- ["Enchiladas"] = { rarity = "Rare", country = "Mexico" },
	-- ["Pozole"] = { rarity = "Rare", country = "Mexico" },
	-- ["Mole Poblano"] = { rarity = "Epic", country = "Mexico" },
	-- ["Tamales"] = { rarity = "Legendary", country = "Mexico" },
	-- ["Aztec Sun Taco"] = { rarity = "Mythical", country = "Mexico" },
	-- ["Jasmine Rice"] = { rarity = "Common", country = "Thailand" },
	-- ["Pad Thai"] = { rarity = "Common", country = "Thailand" },
	-- ["Green Curry"] = { rarity = "Rare", country = "Thailand" },
	-- ["Tom Yum Soup"] = { rarity = "Rare", country = "Thailand" },
	-- ["Massaman Curry"] = { rarity = "Epic", country = "Thailand" },
	-- ["Boat Noodles"] = { rarity = "Legendary", country = "Thailand" },
	-- ["Durian Cheesecake"] = { rarity = "Legendary", country = "Thailand" },
	-- ["Spirit Mango of Ayutthaya"] = { rarity = "Mythical", country = "Thailand" },
	-- ["Iced Coffee (Cà Phê Sữa Đá)"] = { rarity = "Common", country = "Vietnam" },
	-- ["Bánh Mì"] = { rarity = "Uncommon", country = "Vietnam" },
	-- ["Gỏi Cuốn (Spring Rolls)"] = { rarity = "Uncommon", country = "Vietnam" },
	-- ["Chè (Sweet Dessert Soup)"] = { rarity = "Uncommon", country = "Vietnam" },
	-- ["Phở"] = { rarity = "Rare", country = "Vietnam" },
	-- ["Cơm Tấm (Broken Rice)"] = { rarity = "Rare", country = "Vietnam" },
	-- ["Bún Bò Huế"] = { rarity = "Epic", country = "Vietnam" },
	-- ["Bánh Xèo (Sizzling Pancake)"] = { rarity = "Legendary", country = "Vietnam" },
	-- ["Lotus Sticky Rice"] = { rarity = "Legendary", country = "Vietnam" },
	-- ["Phoenix Phở Broth"] = { rarity = "Mythical", country = "Vietnam" },
}
foodData.foodList = foodList

-- for index, value in pairs(dict table)
for foodName, info in pairs(foodData.foodList) do
	--initialize before adding to table
	if not foodData.foodByRarity[info.rarity] then
		foodData.foodByRarity[info.rarity] = {}
	end

	if not foodData.foodByCountry[info.country] then
		foodData.foodByCountry[info.country] = {}
	end

	--add to the table
	table.insert(foodData.foodByRarity[info.rarity], foodName)
	table.insert(foodData.foodByCountry[info.country], foodName)
end

return foodData
