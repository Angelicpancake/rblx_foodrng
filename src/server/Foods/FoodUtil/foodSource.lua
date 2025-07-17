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
	country: string,
	image: ImageLabel,
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
	--fusion foods
	["Naruto’s Ichiraku Ramen"] = { rarity = "Mythical", country = "Japan", image = "rbxassetid://90343831955463" },
	["Bizzarre Onigiri"] = { rarity = "Mythical", country = "Japan", image = "rbxassetid://130053028297922" },
	["Slime Waffle"] = { rarity = "Mythical", country = "USA", image = "rbxassetid://120069889204255" },
	["Arise Sundubu"] = { rarity = "Mythical", country = "Korea", image = "rbxassetid://124184066218114" },
	["MC Dumpling"] = { rarity = "Mythical", country = "China", image = "rbxassetid://88494249187896" },
	["Tralalero Tralala Cappuccino Assassino"] = {
		rarity = "Mythical",
		country = "Italy",
		image = "rbxassetid://89663120514487",
	},
	--japanese foods
	["Ramen"] = { rarity = "Common", country = "Japan", image = "rbxassetid://131358676288357" },
	["Onigiri"] = { rarity = "Common", country = "Japan", image = "rbxassetid://85657987517088" },
	["Miso Soup"] = { rarity = "Common", country = "Japan", image = "rbxassetid://82153071731934" },
	["Tamagoyaki"] = { rarity = "Common", country = "Japan", image = "rbxassetid://138914881364606" },
	["White Rice"] = { rarity = "Common", country = "Japan", image = "rbxassetid://131459968881117" },
	["Udon"] = { rarity = "Common", country = "Japan", image = "rbxassetid://126569713107054" },
	["Takoyaki"] = { rarity = "Uncommon", country = "Japan", image = "rbxassetid://96654656158114" },
	["Okonomiyaki"] = { rarity = "Uncommon", country = "Japan", image = "rbxassetid://80528820122084" },
	["Ochazuke"] = { rarity = "Uncommon", country = "Japan", image = "rbxassetid://138596265153324" },
	["Matcha Ice Cream"] = { rarity = "Uncommon", country = "Japan", image = "rbxassetid://75165788736398" },
	["Kinako Mochi"] = { rarity = "Uncommon", country = "Japan", image = "rbxassetid://75622591003600" },
	["Fugu"] = { rarity = "Rare", country = "Japan", image = "rbxassetid://104363537566735" },
	["Basashi"] = { rarity = "Rare", country = "Japan", image = "rbxassetid://83046777172493" },
	["Uni"] = { rarity = "Rare", country = "Japan", image = "rbxassetid://115707018245541" },
	["Sakura Mochi"] = { rarity = "Rare", country = "Japan", image = "rbxassetid://92759743917545" },
	["Shirasu Don"] = { rarity = "Rare", country = "Japan", image = "rbxassetid://88869446753123" },
	["Kobe Beef"] = { rarity = "Epic", country = "Japan", image = "rbxassetid://99987368447280" },
	["Kaiseki"] = { rarity = "Epic", country = "Japan", image = "rbxassetid://94909129191211" },
	["Osechi Ryori"] = { rarity = "Epic", country = "Japan", image = "rbxassetid://126449599850992" },
	["Ise Ebi"] = { rarity = "Epic", country = "Japan", image = "rbxassetid://115617086937713" },
	["Spirit Bento Box"] = { rarity = "Epic", country = "Japan", image = "rbxassetid://120953371174240" },
	["Whale Sashimi"] = { rarity = "Legendary", country = "Japan", image = "rbxassetid://113885251479218" },
	["Wagashi Jelly"] = { rarity = "Legendary", country = "Japan", image = "rbxassetid://87146785882816" },
	["Taiyaki"] = { rarity = "Legendary", country = "Japan", image = "rbxassetid://136134383957438" },
	["100-Year Soy Sauce"] = { rarity = "Legendary", country = "Japan", image = "rbxassetid://127151319607849" },
	["Pokemon Omurice"] = { rarity = "Mythical", country = "Japan", image = "rbxassetid://100567347983695" },
	["Spirited Castella Cake"] = { rarity = "Mythical", country = "Japan", image = "rbxassetid://77236792305737" },
	["Otaku Cup Ramen"] = { rarity = "Mythical", country = "Japan", image = "rbxassetid://99798747100125" },
	--usa foods
	["Sawsbucks CakePop"] = { rarity = "Common", country = "USA", image = "rbxassetid://107816385172246" },
	["CoCoste Hot Dog"] = { rarity = "Common", country = "USA", image = "rbxassetid://86984515652240" },
	["Jam"] = { rarity = "Common", country = "USA", image = "rbxassetid://113076956528816" },
	["MacRonald Burger"] = { rarity = "Uncommon", country = "USA", image = "rbxassetid://76840240811028" },
	["Brownies"] = { rarity = "Uncommon", country = "USA", image = "rbxassetid://111465065412240" },
	["Choco Chip Cookie"] = { rarity = "Uncommon", country = "USA", image = "rbxassetid://104961137668997" },
	["Oysters"] = { rarity = "Rare", country = "USA", image = "rbxassetid://91160796566546" },
	["NYC Pizza"] = { rarity = "Epic", country = "USA", image = "rbxassetid://97997685954353" },
	["MD Crab"] = { rarity = "Epic", country = "USA", image = "rbxassetid://71139779726014" },
	["Deep Dish Pizza"] = { rarity = "Legendary", country = "USA", image = "rbxassetid://87409309587550" },
	["Donut"] = { rarity = "Legendary", country = "USA", image = "rbxassetid://110580601673931" },
	["Waffle"] = { rarity = "Mythical", country = "USA", image = "rbxassetid://85779614033512" },
	--korea foods
	["Kimchi"] = { rarity = "Common", country = "Korea", image = "rbxassetid://100046745160384" },
	["Gimbap"] = { rarity = "Common", country = "Korea", image = "rbxassetid://123285010377450" },
	["Korean Fried Chicken"] = { rarity = "Common", country = "Korea", image = "rbxassetid://72500774817845" },
	["Tteokbokki"] = { rarity = "Common", country = "Korea", image = "rbxassetid://114713299696336" },
	["Bulgogi"] = { rarity = "Uncommon", country = "Korea", image = "rbxassetid://80537097919800" },
	["Japchae"] = { rarity = "Uncommon", country = "Korea", image = "rbxassetid://103441725156341" },
	["Bibimbap"] = { rarity = "Rare", country = "Korea", image = "rbxassetid://98568536773649" },
	["Seaweed Soup"] = { rarity = "Rare", country = "Korea", image = "rbxassetid://82524707639905" },
	["Yukhoe"] = { rarity = "Epic", country = "Korea", image = "rbxassetid://104277611051550" },
	["Jeon (savory pancake)"] = { rarity = "Epic", country = "Korea", image = "rbxassetid://71664962985457" },
	["Bingsu"] = { rarity = "Legendary", country = "Korea", image = "rbxassetid://75168760068894" },
	["Spicy God Ramyeon"] = { rarity = "Mythical", country = "Korea", image = "rbxassetid://117962104020927" },
	--italy foods
	["Spaghetti"] = { rarity = "Common", country = "Italy", image = "rbxassetid://125261336190541" },
	["Garlic Bread"] = { rarity = "Common", country = "Italy", image = "rbxassetid://91767943109259" },
	["Fettuccine Alfredo"] = { rarity = "Uncommon", country = "Italy", image = "rbxassetid://135950566889255" },
	["Arancini"] = { rarity = "Rare", country = "Italy", image = "rbxassetid://80607142611892" },
	["Porchetta"] = { rarity = "Epic", country = "Italy", image = "rbxassetid://80032440786076" },
	["Gabagool Requiem"] = { rarity = "Mythical", country = "Italy", image = "rbxassetid://80853125373076" },
	--china foods
	["Mantou"] = { rarity = "Common", country = "China", image = "rbxassetid://133145522350743" },
	["Baozi"] = { rarity = "Common", country = "China", image = "rbxassetid://108409197525210" },
	["Egg Fried Rice"] = { rarity = "Uncommon", country = "China", image = "rbxassetid://128145745866192" },
	["Hot Pot"] = { rarity = "Rare", country = "China", image = "rbxassetid://88245820749256" },
	["Xiaolongbao"] = { rarity = "Rare", country = "China", image = "rbxassetid://130639909671674" },
	["Mapo Tofu"] = { rarity = "Epic", country = "China", image = "rbxassetid://101140795077279" },
	["Celestrial MoonCake"] = { rarity = "Legendary", country = "China", image = "rbxassetid://115803836456801" },

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
